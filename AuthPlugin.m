// AuthPlugin.m
// 星欲少女授权状态机 v3
// 修复：隐藏“已显示”的弹窗，在 presentation 完成后隐藏整条祖先链

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

typedef NS_ENUM(NSInteger, AuthState) {
    AuthStateDisabled = 0,
    AuthStateActivating,
    AuthStateActivated,
    AuthStateError,
};

typedef NS_ENUM(NSInteger, ActivationResult) {
    ActivationResultSuccess = 0,
    ActivationResultNotFound,
    ActivationResultExpired,
    ActivationResultDeviceMismatch,
    ActivationResultInvalid,
};

#pragma mark - 全局状态

static AuthState gAuthState = AuthStateDisabled;
static BOOL gPopupsHidden = YES;

static UIWindow *gOverlayWindow = nil;
static NSMutableArray<UIView *> *gHiddenPopupViews = nil;
static NSTimer *gScanTimer = nil;

static IMP gOriginalPresent = NULL;
static IMP gOriginalAlertShow = NULL;

static NSString *const kCurrentActivationKey = @"AuthPlugin_CurrentActivation";
static NSString *const kRecordPrefix = @"AuthPlugin_Record_";

static const NSTimeInterval kScanInterval = 0.15;

static void ShowActivationInput(void);
static void ShowAuthErrorAlert(NSString *title, NSString *message);

#pragma mark - 内嵌卡密表

static NSString *const kBuiltinCodesData =
/* ---------- 日卡 100 ---------- */
@"DAY-010XZ-2WNDE,day,86400\n"
@"DAY-05BY8-A5AT3,day,86400\n"
@"DAY-06HQ3-N51W3,day,86400\n"
@"DAY-0H6Y4-PZTRY,day,86400\n"
@"DAY-0RKAF-DC8MT,day,86400\n"
@"DAY-12R7O-W5ZAC,day,86400\n"
@"DAY-13IMD-ZW9Z2,day,86400\n"
@"DAY-1LG22-11BGP,day,86400\n"
@"DAY-1LKOQ-MPKR2,day,86400\n"
@"DAY-1ZY8Z-CG4JH,day,86400\n"
@"DAY-2FZW3-60L4R,day,86400\n"
@"DAY-2VYYD-MPGHY,day,86400\n"
@"DAY-3GNXF-5TGTS,day,86400\n"
@"DAY-3W00K-QA1MT,day,86400\n"
@"DAY-4B4MC-OWLI4,day,86400\n"
@"DAY-4Z9GP-8PLXL,day,86400\n"
@"DAY-5DPTM-TAIU2,day,86400\n"
@"DAY-5JE31-8SAK4,day,86400\n"
@"DAY-5SEEB-BX9PM,day,86400\n"
@"DAY-6UOXE-LKP92,day,86400\n"
@"DAY-6YH0E-LHAQT,day,86400\n"
@"DAY-769HC-LK9N7,day,86400\n"
@"DAY-7LBFV-30DHG,day,86400\n"
@"DAY-7YR53-5P1CN,day,86400\n"
@"DAY-86PSV-DN1Z6,day,86400\n"
@"DAY-8NWIO-EADO6,day,86400\n"
@"DAY-8SPIG-UEE8J,day,86400\n"
@"DAY-8ZZC3-43IYM,day,86400\n"
@"DAY-93A2W-Q3CE7,day,86400\n"
@"DAY-9WQGS-QCOSD,day,86400\n"
@"DAY-AFA8W-S1N42,day,86400\n"
@"DAY-AMU10-NLTKU,day,86400\n"
@"DAY-AWQPU-FDL9R,day,86400\n"
@"DAY-BKGQ5-JHHG4,day,86400\n"
@"DAY-BNW82-2VK4H,day,86400\n"
@"DAY-BRM6C-YS55W,day,86400\n"
@"DAY-BSLIW-I8XOI,day,86400\n"
@"DAY-BZD66-YB0YB,day,86400\n"
@"DAY-C1U3C-AZHN2,day,86400\n"
@"DAY-CYPPZ-3U7L7,day,86400\n"
@"DAY-D57M6-E0812,day,86400\n"
@"DAY-DGKMG-DIIQP,day,86400\n"
@"DAY-DPMG4-ZJ2EY,day,86400\n"
@"DAY-EM3C8-3T29Y,day,86400\n"
@"DAY-EZGM2-RR1I1,day,86400\n"
@"DAY-G26U3-JBLVX,day,86400\n"
@"DAY-GAEFN-1PA19,day,86400\n"
@"DAY-GBC7J-P8YDU,day,86400\n"
@"DAY-GC5ZC-GQGA9,day,86400\n"
@"DAY-GOWHW-BZHSK,day,86400\n"
@"DAY-H1PYO-H2DCJ,day,86400\n"
@"DAY-H7FZJ-ZKTDF,day,86400\n"
@"DAY-HB9OD-5HTMJ,day,86400\n"
@"DAY-HEE3P-RHBEH,day,86400\n"
@"DAY-HIWY0-L1734,day,86400\n"
@"DAY-HN913-D6IO7,day,86400\n"
@"DAY-I8W2V-WRVCI,day,86400\n"
@"DAY-IP1U0-AOEP4,day,86400\n"
@"DAY-ITV94-6CCKZ,day,86400\n"
@"DAY-K0QUB-G1MKC,day,86400\n"
@"DAY-L0SHA-NZ6O0,day,86400\n"
@"DAY-LDKPA-TWL57,day,86400\n"
@"DAY-LW1I9-0KQ0M,day,86400\n"
@"DAY-M6GN8-0L094,day,86400\n"
@"DAY-NNSKL-3D0D7,day,86400\n"
@"DAY-NWV9C-FHABE,day,86400\n"
@"DAY-OT794-QGTZN,day,86400\n"
@"DAY-PAT93-EZ2RQ,day,86400\n"
@"DAY-QCZVH-QABT6,day,86400\n"
@"DAY-QYEFM-BR3HD,day,86400\n"
@"DAY-R1F25-DXOWK,day,86400\n"
@"DAY-R88L3-MH4LD,day,86400\n"
@"DAY-RFQ5U-SNNM5,day,86400\n"
@"DAY-RM3IA-MWW95,day,86400\n"
@"DAY-S86HY-16RH2,day,86400\n"
@"DAY-S9G7E-JPKUK,day,86400\n"
@"DAY-SAMQ4-J9SVU,day,86400\n"
@"DAY-SDNS8-AFQ2Z,day,86400\n"
@"DAY-SI3OE-P8I7X,day,86400\n"
@"DAY-SMV73-WGP98,day,86400\n"
@"DAY-SP64Q-QPOG4,day,86400\n"
@"DAY-SSTT7-671YZ,day,86400\n"
@"DAY-TC1T3-SH9CA,day,86400\n"
@"DAY-TH7EV-32SP5,day,86400\n"
@"DAY-TLHXB-OQ4XN,day,86400\n"
@"DAY-TMTAF-2J7FT,day,86400\n"
@"DAY-UDWUI-ME32O,day,86400\n"
@"DAY-V0PTR-02OP2,day,86400\n"
@"DAY-V43TR-AKOXA,day,86400\n"
@"DAY-V6TE3-DLF3W,day,86400\n"
@"DAY-V9IR8-FO6LP,day,86400\n"
@"DAY-VL4WG-OXZ44,day,86400\n"
@"DAY-WCQ4V-48923,day,86400\n"
@"DAY-WDPJH-2JVHU,day,86400\n"
@"DAY-XN4SI-F5JS4,day,86400\n"
@"DAY-Y0TB1-WSL0U,day,86400\n"
@"DAY-YSES8-KDSUI,day,86400\n"
@"DAY-Z3UU3-1D2UB,day,86400\n"
@"DAY-Z71BF-2T29M,day,86400\n"
@"DAY-ZMDDZ-SSJFM,day,86400\n"
/* ---------- 月卡 100 ---------- */
@"MON-04SOM-SSBJZ,month,2592000\n"
@"MON-09I2O-PUFWG,month,2592000\n"
@"MON-0FIUU-DUYVB,month,2592000\n"
@"MON-0NF4D-KLFYB,month,2592000\n"
@"MON-0RFI2-DGE1E,month,2592000\n"
@"MON-2AJ1G-K016Z,month,2592000\n"
@"MON-2BFZY-EI4JP,month,2592000\n"
@"MON-2EE1U-TI1PC,month,2592000\n"
@"MON-2G4ER-UVF9N,month,2592000\n"
@"MON-2QR4K-VQS9I,month,2592000\n"
@"MON-2RK7G-O5PAY,month,2592000\n"
@"MON-3XYJS-PBN37,month,2592000\n"
@"MON-4910G-3CN6Q,month,2592000\n"
@"MON-5446W-SCC6Q,month,2592000\n"
@"MON-5OG51-EU0QU,month,2592000\n"
@"MON-5P6IL-ZMSKT,month,2592000\n"
@"MON-61IOP-PX1K3,month,2592000\n"
@"MON-61RS4-ALPSB,month,2592000\n"
@"MON-69LN4-96WDW,month,2592000\n"
@"MON-6L2IS-L1FU5,month,2592000\n"
@"MON-6V6YU-91OGD,month,2592000\n"
@"MON-75CZY-B8D2Z,month,2592000\n"
@"MON-7GT0O-75VAJ,month,2592000\n"
@"MON-7IDMT-XZ8KC,month,2592000\n"
@"MON-7P7PS-CDZNB,month,2592000\n"
@"MON-80QHS-YBRP7,month,2592000\n"
@"MON-8CKN9-G85NA,month,2592000\n"
@"MON-8J4KB-QH3YR,month,2592000\n"
@"MON-9EG0Z-C040S,month,2592000\n"
@"MON-A2JN4-DLDOX,month,2592000\n"
@"MON-B9OEM-ZZJGX,month,2592000\n"
@"MON-BRFYZ-8A78V,month,2592000\n"
@"MON-BUCS2-USY9W,month,2592000\n"
@"MON-BWZ5Z-D2OTY,month,2592000\n"
@"MON-C2DY6-F5LZT,month,2592000\n"
@"MON-CFA5O-13CIO,month,2592000\n"
@"MON-CMUQ0-EU4KB,month,2592000\n"
@"MON-CSAPG-XLHML,month,2592000\n"
@"MON-DBBZO-I23Q7,month,2592000\n"
@"MON-DJ2RD-0Z7FT,month,2592000\n"
@"MON-DJKOP-6UG1D,month,2592000\n"
@"MON-EM3SC-XBV56,month,2592000\n"
@"MON-F1V6P-9K62R,month,2592000\n"
@"MON-FXVRO-JH9VF,month,2592000\n"
@"MON-GBBOH-V1A8G,month,2592000\n"
@"MON-GIBPE-TGVY4,month,2592000\n"
@"MON-GIGPV-7D9PT,month,2592000\n"
@"MON-GZLIJ-U49MK,month,2592000\n"
@"MON-H97QR-KPUHZ,month,2592000\n"
@"MON-HHPRS-5UPXI,month,2592000\n"
@"MON-HLH65-5DBP5,month,2592000\n"
@"MON-HPRKO-52KC4,month,2592000\n"
@"MON-HWBHD-KXJVG,month,2592000\n"
@"MON-I0HX1-XHRZL,month,2592000\n"
@"MON-I6476-GSU4K,month,2592000\n"
@"MON-IJ52T-88WUX,month,2592000\n"
@"MON-JF6IG-A4GS8,month,2592000\n"
@"MON-JGG3R-W3H34,month,2592000\n"
@"MON-JK8GC-MGYK6,month,2592000\n"
@"MON-JT0V2-SBOCC,month,2592000\n"
@"MON-K174U-PK1NP,month,2592000\n"
@"MON-KBKJI-JSM0I,month,2592000\n"
@"MON-KE61H-JM0E3,month,2592000\n"
@"MON-KFY45-C6OHD,month,2592000\n"
@"MON-KKXR5-O29M7,month,2592000\n"
@"MON-L53S1-WN0GW,month,2592000\n"
@"MON-LTIJO-L7BMA,month,2592000\n"
@"MON-M0KVS-CD3HQ,month,2592000\n"
@"MON-MDEGR-RKWXE,month,2592000\n"
@"MON-MQXSD-O8865,month,2592000\n"
@"MON-MRHGK-OG95I,month,2592000\n"
@"MON-NQ3N1-XYH0N,month,2592000\n"
@"MON-O6HLZ-SZABY,month,2592000\n"
@"MON-OS84L-KL94W,month,2592000\n"
@"MON-OSBNW-0STZM,month,2592000\n"
@"MON-OWKMC-NUKMY,month,2592000\n"
@"MON-OYS6G-P57BJ,month,2592000\n"
@"MON-P0FMA-OHJWM,month,2592000\n"
@"MON-P516H-EBVKC,month,2592000\n"
@"MON-P8YD2-D58Q7,month,2592000\n"
@"MON-PFGGC-G8APJ,month,2592000\n"
@"MON-PVDNW-93O0G,month,2592000\n"
@"MON-QAC4J-02F5P,month,2592000\n"
@"MON-QKQFU-QRJOI,month,2592000\n"
@"MON-QU4AR-WEI0W,month,2592000\n"
@"MON-R928E-CAAXC,month,2592000\n"
@"MON-RSHHP-2RH56,month,2592000\n"
@"MON-RYU42-KN37J,month,2592000\n"
@"MON-SCCHE-COWLQ,month,2592000\n"
@"MON-SMFRU-ACYMJ,month,2592000\n"
@"MON-SNKGN-EU99G,month,2592000\n"
@"MON-SXB9Z-KDVB7,month,2592000\n"
@"MON-SYV74-46BC1,month,2592000\n"
@"MON-U59ZT-DM07D,month,2592000\n"
@"MON-UHC5U-YDLQF,month,2592000\n"
@"MON-VOLG0-GKOGX,month,2592000\n"
@"MON-W9N6V-35BOL,month,2592000\n"
@"MON-WAYHC-R2B6T,month,2592000\n"
@"MON-X647P-Q9PLR,month,2592000\n"
@"MON-YKKL9-PVHP0,month,2592000\n"
/* ---------- 永久卡 100 ---------- */
@"PER-0AVW4-KRYF8,permanent,0\n"
@"PER-0KPG1-9EXOF,permanent,0\n"
@"PER-1HK6F-L6FPY,permanent,0\n"
@"PER-1JXH0-G1N28,permanent,0\n"
@"PER-2989F-D6698,permanent,0\n"
@"PER-2I0KC-22JG9,permanent,0\n"
@"PER-3YY40-50Z99,permanent,0\n"
@"PER-4O0CX-MTRSV,permanent,0\n"
@"PER-55862-O189R,permanent,0\n"
@"PER-5HCPF-2QPYT,permanent,0\n"
@"PER-615PA-GRXFY,permanent,0\n"
@"PER-6E661-DN008,permanent,0\n"
@"PER-6RT5K-SY959,permanent,0\n"
@"PER-6ZYHE-R9HS1,permanent,0\n"
@"PER-70TQZ-UQDBH,permanent,0\n"
@"PER-71XM2-INFGL,permanent,0\n"
@"PER-7CV6K-GMN0K,permanent,0\n"
@"PER-7NIZ2-LORYH,permanent,0\n"
@"PER-820A7-YB5HX,permanent,0\n"
@"PER-8AS5F-53W1E,permanent,0\n"
@"PER-8VU79-YTAGX,permanent,0\n"
@"PER-8Z9VL-4EX76,permanent,0\n"
@"PER-AFQ6L-RQKSQ,permanent,0\n"
@"PER-B0FX3-R85PU,permanent,0\n"
@"PER-BBMB4-3109S,permanent,0\n"
@"PER-BGHKA-XONCZ,permanent,0\n"
@"PER-BH8LT-5ON81,permanent,0\n"
@"PER-BL4K5-REN8B,permanent,0\n"
@"PER-CNKQQ-HJW8F,permanent,0\n"
@"PER-DE84V-G54KW,permanent,0\n"
@"PER-E3N9V-D3SZ0,permanent,0\n"
@"PER-EDJDV-492HS,permanent,0\n"
@"PER-ELNUO-X1OQ3,permanent,0\n"
@"PER-EUC63-H7QOD,permanent,0\n"
@"PER-F2C7U-IXQ6M,permanent,0\n"
@"PER-F7I39-E4OAT,permanent,0\n"
@"PER-FY34V-PNGKZ,permanent,0\n"
@"PER-G1LY5-V3ORH,permanent,0\n"
@"PER-GCVG5-W43EU,permanent,0\n"
@"PER-GEDDG-SSF6B,permanent,0\n"
@"PER-H28E5-8E7B8,permanent,0\n"
@"PER-H3YZ5-D1IFK,permanent,0\n"
@"PER-HSRNL-O8T4V,permanent,0\n"
@"PER-HSZF8-XT7JB,permanent,0\n"
@"PER-I1NC7-C78XV,permanent,0\n"
@"PER-IFDBN-TSJRI,permanent,0\n"
@"PER-IPVCM-J3ZJS,permanent,0\n"
@"PER-IW505-ITY8G,permanent,0\n"
@"PER-J1G26-X2LBY,permanent,0\n"
@"PER-JAKWM-4SQMX,permanent,0\n"
@"PER-JQ3HV-BFQ60,permanent,0\n"
@"PER-KQXMX-M9OYA,permanent,0\n"
@"PER-LFR0D-SPV3A,permanent,0\n"
@"PER-LHR8W-4XK05,permanent,0\n"
@"PER-LNVX3-39X2G,permanent,0\n"
@"PER-M05FV-KZURA,permanent,0\n"
@"PER-MEHX6-UZ0LV,permanent,0\n"
@"PER-NC507-LT0R8,permanent,0\n"
@"PER-NV1DS-RU82U,permanent,0\n"
@"PER-OMURC-7CYHT,permanent,0\n"
@"PER-ONGDQ-GBEU6,permanent,0\n"
@"PER-ORH8V-650DZ,permanent,0\n"
@"PER-P3827-H2X5T,permanent,0\n"
@"PER-P9DN4-6RGJA,permanent,0\n"
@"PER-PII9C-NWNNA,permanent,0\n"
@"PER-QVEF9-95B7V,permanent,0\n"
@"PER-QXKUO-0MZLT,permanent,0\n"
@"PER-R2SDS-6YBKR,permanent,0\n"
@"PER-R5VO4-K83BT,permanent,0\n"
@"PER-RAL1J-0B8TU,permanent,0\n"
@"PER-RM6CI-ZGCN0,permanent,0\n"
@"PER-RVLDY-7NMY7,permanent,0\n"
@"PER-S4XSB-X9GSS,permanent,0\n"
@"PER-STCXP-KVIOJ,permanent,0\n"
@"PER-STQL3-MA99J,permanent,0\n"
@"PER-SUXO1-JS3UA,permanent,0\n"
@"PER-TPVGM-HKZEN,permanent,0\n"
@"PER-U6ZKY-X4VDI,permanent,0\n"
@"PER-U7MEM-DSJFG,permanent,0\n"
@"PER-UFGEZ-QHDG8,permanent,0\n"
@"PER-UFWR3-3HWOA,permanent,0\n"
@"PER-UMIJZ-TUTWF,permanent,0\n"
@"PER-UNAN8-GG2VD,permanent,0\n"
@"PER-V29CE-ZH2OA,permanent,0\n"
@"PER-VEGA8-ET6Y5,permanent,0\n"
@"PER-VGERT-D45YE,permanent,0\n"
@"PER-VKGAD-0Z1KF,permanent,0\n"
@"PER-W8SKK-JIZIX,permanent,0\n"
@"PER-WERVC-TKZ0I,permanent,0\n"
@"PER-WLGI2-VZQNT,permanent,0\n"
@"PER-WS263-VWNCU,permanent,0\n"
@"PER-X51RG-ZH0FL,permanent,0\n"
@"PER-Y6Q3Z-4HOXU,permanent,0\n"
@"PER-Y7NCA-QPYXC,permanent,0\n"
@"PER-YPFSF-R1311,permanent,0\n"
@"PER-YSC2E-QRXVH,permanent,0\n"
@"PER-YWG29-6JT1A,permanent,0\n"
@"PER-ZNXWS-NW0FI,permanent,0\n"
@"PER-ZT6J0-L6U1A,permanent,0\n"
@"PER-ZU4NT-1WRNZ,permanent,0\n";

static NSDictionary *BuiltinCodeTable(void) {
    static NSDictionary *table;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        NSMutableDictionary *m = [NSMutableDictionary dictionary];
        for (NSString *line in [kBuiltinCodesData componentsSeparatedByString:@"\n"]) {
            if (line.length == 0) continue;
            NSArray *parts = [line componentsSeparatedByString:@","];
            if (parts.count != 3) continue;
            m[parts[0]] = @{ @"type": parts[1], @"validitySeconds": @([parts[2] integerValue]) };
        }
        table = [m copy];
    });
    return table;
}

#pragma mark - 弹窗识别

// 默认精确匹配（避免误伤名字带 Alert 的普通控件）
static BOOL IsSystemPopupClass(NSString *cls) {
    if (cls.length == 0) return NO;
    return [cls isEqualToString:@"UIAlertView"] ||
           [cls isEqualToString:@"_UIAlertControllerView"] ||
           [cls isEqualToString:@"_UIAlertControllerShimPresenterWindow"] ||
           [cls isEqualToString:@"UITextEffectsWindow"] == NO; // 不隐藏窗口本身
}

// 用户自定义弹窗类名（若游戏弹窗不是系统类名，加到这里）
static NSArray<NSString *> *CustomPopupClassNames(void) {
    static NSArray *arr;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        arr = @[
            // @"GameNoticeView",
            // @"LobbyAlertPopup",
        ];
    });
    return arr;
}

static BOOL IsCustomPopupClass(NSString *cls) {
    for (NSString *name in CustomPopupClassNames()) {
        if ([cls isEqualToString:name]) return YES;
    }
    return NO;
}

static BOOL ShouldHideViewController(UIViewController *vc) {
    if (!vc) return NO;
    if ([vc isKindOfClass:[UIAlertController class]]) return YES;
    NSString *cls = NSStringFromClass([vc class]);
    if (IsSystemPopupClass(cls)) return YES;
    if (IsCustomPopupClass(cls)) return YES;
    return NO;
}

#pragma mark - Defaults

static NSUserDefaults *AuthDefaults(void) {
    static NSUserDefaults *defaults;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        defaults = [[NSUserDefaults alloc] initWithSuiteName:@"com.star.authplugin"];
        if (!defaults) defaults = [NSUserDefaults standardUserDefaults];
    });
    return defaults;
}

#pragma mark - Overlay

static UIViewController *EnsureOverlayRoot(void) {
    if (!gOverlayWindow) {
        if (@available(iOS 13.0, *)) {
            UIWindowScene *targetScene = nil;
            for (UIScene *scene in [UIApplication sharedApplication].connectedScenes) {
                if ([scene isKindOfClass:[UIWindowScene class]]) { targetScene = (UIWindowScene *)scene; break; }
            }
            if (targetScene) gOverlayWindow = [[UIWindow alloc] initWithWindowScene:targetScene];
        }
        if (!gOverlayWindow) gOverlayWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        gOverlayWindow.windowLevel = UIWindowLevelAlert + 1;
        UIViewController *root = [[UIViewController alloc] init];
        root.view.backgroundColor = [UIColor clearColor];
        gOverlayWindow.rootViewController = root;
    }
    [gOverlayWindow makeKeyAndVisible];
    return gOverlayWindow.rootViewController;
}

static void PresentPluginAlert(UIAlertController *alert) {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIViewController *root = EnsureOverlayRoot();
        SEL sel = @selector(presentViewController:animated:completion:);
        if (gOriginalPresent) {
            ((void (*)(id, SEL, UIViewController *, BOOL, void (^)(void)))gOriginalPresent)(
                root, sel, alert, YES, nil);
        } else {
            [root presentViewController:alert animated:YES completion:nil];
        }
    });
}

static void ShowAuthAlert(NSString *title, NSString *message,
                          NSArray<NSString *> *buttonTitles,
                          void (^handler)(NSInteger index)) {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    for (NSInteger i = 0; i < buttonTitles.count; i++) {
        NSString *t = buttonTitles[i];
        [alert addAction:[UIAlertAction actionWithTitle:t style:UIAlertActionStyleDefault
                                                handler:^(UIAlertAction * _Nonnull a) {
            if (handler) handler(i);
        }]];
    }
    PresentPluginAlert(alert);
}

#pragma mark - 隐藏 / 恢复

static void MarkHidden(UIView *view) {
    if (!view) return;
    if (view == gOverlayWindow) return;
    if ([gHiddenPopupViews containsObject:view]) return;
    view.hidden = YES;
    [gHiddenPopupViews addObject:view];
    NSLog(@"[AuthPlugin] hidden: %@", NSStringFromClass([view class]));
}

// 核心修复：从 alertView 向上遍历，隐藏整条祖先链（不含 window 与 rootView）
static void HideAlertAncestors(UIView *alertView) {
    if (!alertView) return;
    UIWindow *window = alertView.window;
    if (!window) return;

    UIView *rootView = window.rootViewController.view;

    UIView *cur = alertView;
    while (cur && cur != window && cur != rootView) {
        MarkHidden(cur);
        cur = cur.superview;
    }
}

// 对已 present 的 VC，处理其中 alert 视图
static void HidePresentedVC(UIViewController *vc) {
    if (!ShouldHideViewController(vc)) return;
    UIView *alertView = vc.view;
    if (!alertView) return;

    if (!alertView.window) {
        // 动画中或还没上屏，等 100ms 重试（最多重试几次）
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)),
                       dispatch_get_main_queue(), ^{
            if (gPopupsHidden) {
                HideAlertAncestors(vc.view);
            }
        });
        return;
    }
    HideAlertAncestors(alertView);
}

// 遍历 presentedViewController 链
static void ScanPresentedVCs(UIViewController *vc) {
    if (!vc) return;
    UIViewController *presented = vc.presentedViewController;
    while (presented) {
        if (ShouldHideViewController(presented)) {
            HidePresentedVC(presented);
        }
        // 继续检查 presented 自己再 present 的
        UIViewController *next = presented.presentedViewController;
        if (!next) break;
        presented = next;
    }
    for (UIViewController *child in vc.childViewControllers) {
        ScanPresentedVCs(child);
    }
}

// 遍历视图树，识别自定义弹窗 view 直接 add 到 window 的情况
static void ScanViewTree(UIView *view) {
    if (!view || view == gOverlayWindow) return;
    if (view.hidden) {
        // 已经隐藏的 view 不再深入，避免大范围扫描
        return;
    }
    NSString *cls = NSStringFromClass([view class]);
    if (IsCustomPopupClass(cls)) {
        MarkHidden(view);
        // 继续向上隐藏祖先链（不过 view 是直接 add 到某个容器时，向上隐藏到 rootView 前）
        UIView *cur = view;
        UIWindow *win = view.window;
        UIView *rootV = win.rootViewController.view;
        while (cur.superview && cur.superview != win && cur.superview != rootV) {
            cur = cur.superview;
            MarkHidden(cur);
        }
        return;
    }
    for (UIView *sub in view.subviews) {
        ScanViewTree(sub);
    }
}

static void ScanAndHidePopups(void) {
    if (!gPopupsHidden) return;
    if (![NSThread isMainThread]) {
        dispatch_async(dispatch_get_main_queue(), ^{ ScanAndHidePopups(); });
        return;
    }

    // 清理已经销毁的 view
    NSMutableArray *invalid = [NSMutableArray array];
    for (UIView *v in gHiddenPopupViews) {
        if (!v.window) [invalid addObject:v];
    }
    if (invalid.count) [gHiddenPopupViews removeObjectsInArray:invalid];

    for (UIWindow *window in [UIApplication sharedApplication].windows) {
        if (window == gOverlayWindow) continue;
        if (window.hidden) continue;
        if (window.rootViewController) {
            ScanPresentedVCs(window.rootViewController);
        }
        ScanViewTree(window);
    }
}

static void StartScanTimer(void) {
    if (gScanTimer) return;
    gScanTimer = [NSTimer timerWithTimeInterval:kScanInterval repeats:YES
                                          block:^(NSTimer * _Nonnull t) {
        ScanAndHidePopups();
    }];
    [[NSRunLoop mainRunLoop] addTimer:gScanTimer forMode:NSRunLoopCommonModes];
}

static void StopScanTimer(void) {
    if (gScanTimer) {
        [gScanTimer invalidate];
        gScanTimer = nil;
    }
}

static void RestoreHiddenPopupViews(void) {
    dispatch_async(dispatch_get_main_queue(), ^{
        for (UIView *view in gHiddenPopupViews) {
            if (view.window) {
                view.hidden = NO;
                NSLog(@"[AuthPlugin] restored: %@", NSStringFromClass([view class]));
            }
        }
        [gHiddenPopupViews removeAllObjects];
    });
}

#pragma mark - Hook

// 修复：completion 后再隐藏；没有 completion 则延迟 0.2s 隐藏
static void HookedPresentViewController(UIViewController *self, SEL _cmd,
                                        UIViewController *vc, BOOL animated,
                                        void (^completion)(void)) {
    BOOL isPopup = gPopupsHidden && ShouldHideViewController(vc);

    void (^wrapped)(void) = ^{
        if (completion) completion();
        if (isPopup && gPopupsHidden) {
            HidePresentedVC(vc);
        }
    };

    ((void (*)(id, SEL, UIViewController *, BOOL, void (^)(void)))gOriginalPresent)(
        self, _cmd, vc, animated, wrapped);

    if (isPopup) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)),
                       dispatch_get_main_queue(), ^{
            if (gPopupsHidden && vc.view.window) {
                HideAlertAncestors(vc.view);
            }
        });
    }
}

static void HookedAlertShow(UIAlertView *self, SEL _cmd) {
    ((void (*)(id, SEL))gOriginalAlertShow)(self, _cmd);
    if (!gPopupsHidden) return;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC)),
                   dispatch_get_main_queue(), ^{
        if (gPopupsHidden) MarkHidden(self);
    });
}

#pragma mark - 激活逻辑

static NSString *CurrentDeviceID(void) {
    NSString *uuid = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    return uuid.length ? uuid : @"unknown-device";
}

static ActivationResult ActivateCode(NSString *rawCode, NSString **outMessage) {
    NSString *code = [rawCode stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (code.length == 0) { if (outMessage) *outMessage = @"请输入激活码"; return ActivationResultInvalid; }

    NSDictionary *meta = BuiltinCodeTable()[code];
    if (![meta isKindOfClass:[NSDictionary class]]) {
        if (outMessage) *outMessage = @"激活码不存在";
        return ActivationResultNotFound;
    }

    NSInteger validity = [meta[@"validitySeconds"] integerValue];
    NSString *recordKey = [kRecordPrefix stringByAppendingString:code];
    NSUserDefaults *defaults = AuthDefaults();
    NSMutableDictionary *record = [[defaults dictionaryForKey:recordKey] mutableCopy];

    NSTimeInterval now = [[NSDate date] timeIntervalSince1970];
    NSString *deviceID = CurrentDeviceID();

    if (record) {
        NSString *bound = record[@"boundDevice"];
        if (bound.length > 0 && ![bound isEqualToString:deviceID]) {
            if (outMessage) *outMessage = @"该激活码已绑定其他设备";
            return ActivationResultDeviceMismatch;
        }
        double expiry = [record[@"expiryAt"] doubleValue];
        if (validity > 0 && expiry > 0 && now > expiry) {
            if (outMessage) *outMessage = @"该激活码已过期";
            return ActivationResultExpired;
        }
        [defaults setObject:record forKey:kCurrentActivationKey];
        [defaults synchronize];
        return ActivationResultSuccess;
    }

    NSNumber *expiry = validity > 0 ? @(now + validity) : @0;
    record = [@{
        @"code": code,
        @"type": meta[@"type"] ?: @"unknown",
        @"validitySeconds": @(validity),
        @"firstActivatedAt": @(now),
        @"expiryAt": expiry,
        @"boundDevice": deviceID,
        @"status": @"active",
    } mutableCopy];
    [defaults setObject:record forKey:recordKey];
    [defaults setObject:record forKey:kCurrentActivationKey];
    [defaults synchronize];
    return ActivationResultSuccess;
}

static BOOL IsCurrentActivationValid(void) {
    NSDictionary *r = [AuthDefaults() dictionaryForKey:kCurrentActivationKey];
    if (![r isKindOfClass:[NSDictionary class]]) return NO;
    NSString *bound = r[@"boundDevice"];
    if (bound.length > 0 && ![bound isEqualToString:CurrentDeviceID()]) return NO;
    NSInteger validity = [r[@"validitySeconds"] integerValue];
    double expiry = [r[@"expiryAt"] doubleValue];
    if (validity > 0 && expiry > 0 && [[NSDate date] timeIntervalSince1970] > expiry) return NO;
    return YES;
}

#pragma mark - UI 状态机

static void ShowActivationEntry(void) {
    ShowAuthAlert(@"授权验证", @"请选择操作", @[@"激活", @"不使用辅助"], ^(NSInteger idx) {
        if (idx == 0) {
            ShowActivationInput();
        } else {
            gAuthState = AuthStateDisabled;
            gPopupsHidden = YES;   // 保持一直隐藏
            [gOverlayWindow setHidden:YES];
        }
    });
}

static void ShowActivationInput(void) {
    gAuthState = AuthStateActivating;

    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"激活"
                                                                   message:@"请输入激活码"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull tf) {
        tf.placeholder = @"激活码";
        tf.autocapitalizationType = UITextAutocapitalizationTypeAllCharacters;
        tf.autocorrectionType = UITextAutocorrectionTypeNo;
    }];
    [alert addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction * _Nonnull a) {
        NSString *code = alert.textFields.firstObject.text ?: @"";
        NSString *msg = nil;
        ActivationResult result = ActivateCode(code, &msg);

        if (result == ActivationResultSuccess) {
            gAuthState = AuthStateActivated;
            gPopupsHidden = NO;             // 不再隐藏
            StopScanTimer();                // 停止扫描

            ShowAuthAlert(@"成功", @"授权成功", @[@"确定"], ^(NSInteger i) {
                [gOverlayWindow setHidden:YES];
                RestoreHiddenPopupViews();  // 调出被隐藏的弹窗
            });
        } else {
            gAuthState = AuthStateError;
            NSString *title = @"激活码错误";
            if (result == ActivationResultExpired) title = @"激活码已过期";
            if (result == ActivationResultDeviceMismatch) title = @"设备不匹配";
            ShowAuthErrorAlert(title, msg ?: @"请选择操作");
        }
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel
                                            handler:^(UIAlertAction * _Nonnull a) {
        gAuthState = AuthStateDisabled;
        gPopupsHidden = YES;
    }]];
    PresentPluginAlert(alert);
}

static void ShowAuthErrorAlert(NSString *title, NSString *message) {
    ShowAuthAlert(title, message, @[@"重新输入", @"不使用辅助"], ^(NSInteger idx) {
        if (idx == 0) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.35 * NSEC_PER_SEC)),
                           dispatch_get_main_queue(), ^{
                ShowActivationInput();
            });
        } else {
            gAuthState = AuthStateDisabled;
            gPopupsHidden = YES;
            [gOverlayWindow setHidden:YES];
        }
    });
}

#pragma mark - Init

__attribute__((constructor))
static void AuthPluginInit(void) {
    gHiddenPopupViews = [NSMutableArray array];

    if (IsCurrentActivationValid()) {
        gAuthState = AuthStateActivated;
        gPopupsHidden = NO;
        NSLog(@"[AuthPlugin] already activated");
        return;
    }

    gAuthState = AuthStateDisabled;
    gPopupsHidden = YES;

    Method present = class_getInstanceMethod([UIViewController class],
                                             @selector(presentViewController:animated:completion:));
    if (present) {
        gOriginalPresent = method_getImplementation(present);
        method_setImplementation(present, (IMP)HookedPresentViewController);
    }

    Method show = class_getInstanceMethod([UIAlertView class], @selector(show));
    if (show) {
        gOriginalAlertShow = method_getImplementation(show);
        method_setImplementation(show, (IMP)HookedAlertShow);
    }

    // 立即扫描并启动定时器
    ScanAndHidePopups();
    StartScanTimer();

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)),
                   dispatch_get_main_queue(), ^{
        ShowActivationEntry();
    });
}
