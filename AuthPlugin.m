// AuthPlugin.m
// Objective-C authorization UI and URL-gate helper for an app/plugin you are authorized to modify.
// IMPORTANT: This is a local/demo validator. Embedded keys can be extracted from a compiled dylib.
// For production, move activation, one-time redemption, and device binding to a server.

#import <UIKit/UIKit.h>

static NSString * const kAuthDefaultsActivatedCode = @"AuthPlugin.ActivatedCode";
static NSString * const kAuthDefaultsExpiry        = @"AuthPlugin.Expiry";
static NSString * const kAuthDefaultsDevice        = @"AuthPlugin.Device";

@interface AuthPlugin : NSObject
+ (void)start;
+ (BOOL)isAuthorized;
+ (BOOL)shouldAllowURL:(NSURL *)url;
@end

#pragma mark - Activation-code table

static NSDictionary<NSString *, NSString *> *AuthActivationCodes(void) {
    static NSDictionary<NSString *, NSString *> *codes;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        codes = @{
        @"DAY-010XZ-2WNDE": @"DAY",
        @"DAY-05BY8-A5AT3": @"DAY",
        @"DAY-06HQ3-N51W3": @"DAY",
        @"DAY-0H6Y4-PZTRY": @"DAY",
        @"DAY-0RKAF-DC8MT": @"DAY",
        @"DAY-12R7O-W5ZAC": @"DAY",
        @"DAY-13IMD-ZW9Z2": @"DAY",
        @"DAY-1LG22-11BGP": @"DAY",
        @"DAY-1LKOQ-MPKR2": @"DAY",
        @"DAY-1ZY8Z-CG4JH": @"DAY",
        @"DAY-2FZW3-60L4R": @"DAY",
        @"DAY-2VYYD-MPGHY": @"DAY",
        @"DAY-3GNXF-5TGTS": @"DAY",
        @"DAY-3W00K-QA1MT": @"DAY",
        @"DAY-4B4MC-OWLI4": @"DAY",
        @"DAY-4Z9GP-8PLXL": @"DAY",
        @"DAY-5DPTM-TAIU2": @"DAY",
        @"DAY-5JE31-8SAK4": @"DAY",
        @"DAY-5SEEB-BX9PM": @"DAY",
        @"DAY-6UOXE-LKP92": @"DAY",
        @"DAY-6YH0E-LHAQT": @"DAY",
        @"DAY-769HC-LK9N7": @"DAY",
        @"DAY-7LBFV-30DHG": @"DAY",
        @"DAY-7YR53-5P1CN": @"DAY",
        @"DAY-86PSV-DN1Z6": @"DAY",
        @"DAY-8NWIO-EADO6": @"DAY",
        @"DAY-8SPIG-UEE8J": @"DAY",
        @"DAY-8ZZC3-43IYM": @"DAY",
        @"DAY-93A2W-Q3CE7": @"DAY",
        @"DAY-9WQGS-QCOSD": @"DAY",
        @"DAY-AFA8W-S1N42": @"DAY",
        @"DAY-AMU10-NLTKU": @"DAY",
        @"DAY-AWQPU-FDL9R": @"DAY",
        @"DAY-BKGQ5-JHHG4": @"DAY",
        @"DAY-BNW82-2VK4H": @"DAY",
        @"DAY-BRM6C-YS55W": @"DAY",
        @"DAY-BSLIW-I8XOI": @"DAY",
        @"DAY-BZD66-YB0YB": @"DAY",
        @"DAY-C1U3C-AZHN2": @"DAY",
        @"DAY-CYPPZ-3U7L7": @"DAY",
        @"DAY-D57M6-E0812": @"DAY",
        @"DAY-DGKMG-DIIQP": @"DAY",
        @"DAY-DPMG4-ZJ2EY": @"DAY",
        @"DAY-EM3C8-3T29Y": @"DAY",
        @"DAY-EZGM2-RR1I1": @"DAY",
        @"DAY-G26U3-JBLVX": @"DAY",
        @"DAY-GAEFN-1PA19": @"DAY",
        @"DAY-GBC7J-P8YDU": @"DAY",
        @"DAY-GC5ZC-GQGA9": @"DAY",
        @"DAY-GOWHW-BZHSK": @"DAY",
        @"DAY-H1PYO-H2DCJ": @"DAY",
        @"DAY-H7FZJ-ZKTDF": @"DAY",
        @"DAY-HB9OD-5HTMJ": @"DAY",
        @"DAY-HEE3P-RHBEH": @"DAY",
        @"DAY-HIWY0-L1734": @"DAY",
        @"DAY-HN913-D6IO7": @"DAY",
        @"DAY-I8W2V-WRVCI": @"DAY",
        @"DAY-IP1U0-AOEP4": @"DAY",
        @"DAY-ITV94-6CCKZ": @"DAY",
        @"DAY-K0QUB-G1MKC": @"DAY",
        @"DAY-L0SHA-NZ6O0": @"DAY",
        @"DAY-LDKPA-TWL57": @"DAY",
        @"DAY-LW1I9-0KQ0M": @"DAY",
        @"DAY-M6GN8-0L094": @"DAY",
        @"DAY-NNSKL-3D0D7": @"DAY",
        @"DAY-NWV9C-FHABE": @"DAY",
        @"DAY-OT794-QGTZN": @"DAY",
        @"DAY-PAT93-EZ2RQ": @"DAY",
        @"DAY-QCZVH-QABT6": @"DAY",
        @"DAY-QYEFM-BR3HD": @"DAY",
        @"DAY-R1F25-DXOWK": @"DAY",
        @"DAY-R88L3-MH4LD": @"DAY",
        @"DAY-RFQ5U-SNNM5": @"DAY",
        @"DAY-RM3IA-MWW95": @"DAY",
        @"DAY-S86HY-16RH2": @"DAY",
        @"DAY-S9G7E-JPKUK": @"DAY",
        @"DAY-SAMQ4-J9SVU": @"DAY",
        @"DAY-SDNS8-AFQ2Z": @"DAY",
        @"DAY-SI3OE-P8I7X": @"DAY",
        @"DAY-SMV73-WGP98": @"DAY",
        @"DAY-SP64Q-QPOG4": @"DAY",
        @"DAY-SSTT7-671YZ": @"DAY",
        @"DAY-TC1T3-SH9CA": @"DAY",
        @"DAY-TH7EV-32SP5": @"DAY",
        @"DAY-TLHXB-OQ4XN": @"DAY",
        @"DAY-TMTAF-2J7FT": @"DAY",
        @"DAY-UDWUI-ME32O": @"DAY",
        @"DAY-V0PTR-02OP2": @"DAY",
        @"DAY-V43TR-AKOXA": @"DAY",
        @"DAY-V6TE3-DLF3W": @"DAY",
        @"DAY-V9IR8-FO6LP": @"DAY",
        @"DAY-VL4WG-OXZ44": @"DAY",
        @"DAY-WCQ4V-48923": @"DAY",
        @"DAY-WDPJH-2JVHU": @"DAY",
        @"DAY-XN4SI-F5JS4": @"DAY",
        @"DAY-Y0TB1-WSL0U": @"DAY",
        @"DAY-YSES8-KDSUI": @"DAY",
        @"DAY-Z3UU3-1D2UB": @"DAY",
        @"DAY-Z71BF-2T29M": @"DAY",
        @"DAY-ZMDDZ-SSJFM": @"DAY",
        @"MON-04SOM-SSBJZ": @"MONTH",
        @"MON-09I2O-PUFWG": @"MONTH",
        @"MON-0FIUU-DUYVB": @"MONTH",
        @"MON-0NF4D-KLFYB": @"MONTH",
        @"MON-0RFI2-DGE1E": @"MONTH",
        @"MON-2AJ1G-K016Z": @"MONTH",
        @"MON-2BFZY-EI4JP": @"MONTH",
        @"MON-2EE1U-TI1PC": @"MONTH",
        @"MON-2G4ER-UVF9N": @"MONTH",
        @"MON-2QR4K-VQS9I": @"MONTH",
        @"MON-2RK7G-O5PAY": @"MONTH",
        @"MON-3XYJS-PBN37": @"MONTH",
        @"MON-4910G-3CN6Q": @"MONTH",
        @"MON-5446W-SCC6Q": @"MONTH",
        @"MON-5OG51-EU0QU": @"MONTH",
        @"MON-5P6IL-ZMSKT": @"MONTH",
        @"MON-61IOP-PX1K3": @"MONTH",
        @"MON-61RS4-ALPSB": @"MONTH",
        @"MON-69LN4-96WDW": @"MONTH",
        @"MON-6L2IS-L1FU5": @"MONTH",
        @"MON-6V6YU-91OGD": @"MONTH",
        @"MON-75CZY-B8D2Z": @"MONTH",
        @"MON-7GT0O-75VAJ": @"MONTH",
        @"MON-7IDMT-XZ8KC": @"MONTH",
        @"MON-7P7PS-CDZNB": @"MONTH",
        @"MON-80QHS-YBRP7": @"MONTH",
        @"MON-8CKN9-G85NA": @"MONTH",
        @"MON-8J4KB-QH3YR": @"MONTH",
        @"MON-9EG0Z-C040S": @"MONTH",
        @"MON-A2JN4-DLDOX": @"MONTH",
        @"MON-B9OEM-ZZJGX": @"MONTH",
        @"MON-BRFYZ-8A78V": @"MONTH",
        @"MON-BUCS2-USY9W": @"MONTH",
        @"MON-BWZ5Z-D2OTY": @"MONTH",
        @"MON-C2DY6-F5LZT": @"MONTH",
        @"MON-CFA5O-13CIO": @"MONTH",
        @"MON-CMUQ0-EU4KB": @"MONTH",
        @"MON-CSAPG-XLHML": @"MONTH",
        @"MON-DBBZO-I23Q7": @"MONTH",
        @"MON-DJ2RD-0Z7FT": @"MONTH",
        @"MON-DJKOP-6UG1D": @"MONTH",
        @"MON-EM3SC-XBV56": @"MONTH",
        @"MON-F1V6P-9K62R": @"MONTH",
        @"MON-FXVRO-JH9VF": @"MONTH",
        @"MON-GBBOH-V1A8G": @"MONTH",
        @"MON-GIBPE-TGVY4": @"MONTH",
        @"MON-GIGPV-7D9PT": @"MONTH",
        @"MON-GZLIJ-U49MK": @"MONTH",
        @"MON-H97QR-KPUHZ": @"MONTH",
        @"MON-HHPRS-5UPXI": @"MONTH",
        @"MON-HLH65-5DBP5": @"MONTH",
        @"MON-HPRKO-52KC4": @"MONTH",
        @"MON-HWBHD-KXJVG": @"MONTH",
        @"MON-I0HX1-XHRZL": @"MONTH",
        @"MON-I6476-GSU4K": @"MONTH",
        @"MON-IJ52T-88WUX": @"MONTH",
        @"MON-JF6IG-A4GS8": @"MONTH",
        @"MON-JGG3R-W3H34": @"MONTH",
        @"MON-JK8GC-MGYK6": @"MONTH",
        @"MON-JT0V2-SBOCC": @"MONTH",
        @"MON-K174U-PK1NP": @"MONTH",
        @"MON-KBKJI-JSM0I": @"MONTH",
        @"MON-KE61H-JM0E3": @"MONTH",
        @"MON-KFY45-C6OHD": @"MONTH",
        @"MON-KKXR5-O29M7": @"MONTH",
        @"MON-L53S1-WN0GW": @"MONTH",
        @"MON-LTIJO-L7BMA": @"MONTH",
        @"MON-M0KVS-CD3HQ": @"MONTH",
        @"MON-MDEGR-RKWXE": @"MONTH",
        @"MON-MQXSD-O8865": @"MONTH",
        @"MON-MRHGK-OG95I": @"MONTH",
        @"MON-NQ3N1-XYH0N": @"MONTH",
        @"MON-O6HLZ-SZABY": @"MONTH",
        @"MON-OS84L-KL94W": @"MONTH",
        @"MON-OSBNW-0STZM": @"MONTH",
        @"MON-OWKMC-NUKMY": @"MONTH",
        @"MON-OYS6G-P57BJ": @"MONTH",
        @"MON-P0FMA-OHJWM": @"MONTH",
        @"MON-P516H-EBVKC": @"MONTH",
        @"MON-P8YD2-D58Q7": @"MONTH",
        @"MON-PFGGC-G8APJ": @"MONTH",
        @"MON-PVDNW-93O0G": @"MONTH",
        @"MON-QAC4J-02F5P": @"MONTH",
        @"MON-QKQFU-QRJOI": @"MONTH",
        @"MON-QU4AR-WEI0W": @"MONTH",
        @"MON-R928E-CAAXC": @"MONTH",
        @"MON-RSHHP-2RH56": @"MONTH",
        @"MON-RYU42-KN37J": @"MONTH",
        @"MON-SCCHE-COWLQ": @"MONTH",
        @"MON-SMFRU-ACYMJ": @"MONTH",
        @"MON-SNKGN-EU99G": @"MONTH",
        @"MON-SXB9Z-KDVB7": @"MONTH",
        @"MON-SYV74-46BC1": @"MONTH",
        @"MON-U59ZT-DM07D": @"MONTH",
        @"MON-UHC5U-YDLQF": @"MONTH",
        @"MON-VOLG0-GKOGX": @"MONTH",
        @"MON-W9N6V-35BOL": @"MONTH",
        @"MON-WAYHC-R2B6T": @"MONTH",
        @"MON-X647P-Q9PLR": @"MONTH",
        @"MON-YKKL9-PVHP0": @"MONTH",
        @"PER-0AVW4-KRYF8": @"PERMANENT",
        @"PER-0KPG1-9EXOF": @"PERMANENT",
        @"PER-1HK6F-L6FPY": @"PERMANENT",
        @"PER-1JXH0-G1N28": @"PERMANENT",
        @"PER-2989F-D6698": @"PERMANENT",
        @"PER-2I0KC-22JG9": @"PERMANENT",
        @"PER-3YY40-50Z99": @"PERMANENT",
        @"PER-4O0CX-MTRSV": @"PERMANENT",
        @"PER-55862-O189R": @"PERMANENT",
        @"PER-5HCPF-2QPYT": @"PERMANENT",
        @"PER-615PA-GRXFY": @"PERMANENT",
        @"PER-6E661-DN008": @"PERMANENT",
        @"PER-6RT5K-SY959": @"PERMANENT",
        @"PER-6ZYHE-R9HS1": @"PERMANENT",
        @"PER-70TQZ-UQDBH": @"PERMANENT",
        @"PER-71XM2-INFGL": @"PERMANENT",
        @"PER-7CV6K-GMN0K": @"PERMANENT",
        @"PER-7NIZ2-LORYH": @"PERMANENT",
        @"PER-820A7-YB5HX": @"PERMANENT",
        @"PER-8AS5F-53W1E": @"PERMANENT",
        @"PER-8VU79-YTAGX": @"PERMANENT",
        @"PER-8Z9VL-4EX76": @"PERMANENT",
        @"PER-AFQ6L-RQKSQ": @"PERMANENT",
        @"PER-B0FX3-R85PU": @"PERMANENT",
        @"PER-BBMB4-3109S": @"PERMANENT",
        @"PER-BGHKA-XONCZ": @"PERMANENT",
        @"PER-BH8LT-5ON81": @"PERMANENT",
        @"PER-BL4K5-REN8B": @"PERMANENT",
        @"PER-CNKQQ-HJW8F": @"PERMANENT",
        @"PER-DE84V-G54KW": @"PERMANENT",
        @"PER-E3N9V-D3SZ0": @"PERMANENT",
        @"PER-EDJDV-492HS": @"PERMANENT",
        @"PER-ELNUO-X1OQ3": @"PERMANENT",
        @"PER-EUC63-H7QOD": @"PERMANENT",
        @"PER-F2C7U-IXQ6M": @"PERMANENT",
        @"PER-F7I39-E4OAT": @"PERMANENT",
        @"PER-FY34V-PNGKZ": @"PERMANENT",
        @"PER-G1LY5-V3ORH": @"PERMANENT",
        @"PER-GCVG5-W43EU": @"PERMANENT",
        @"PER-GEDDG-SSF6B": @"PERMANENT",
        @"PER-H28E5-8E7B8": @"PERMANENT",
        @"PER-H3YZ5-D1IFK": @"PERMANENT",
        @"PER-HSRNL-O8T4V": @"PERMANENT",
        @"PER-HSZF8-XT7JB": @"PERMANENT",
        @"PER-I1NC7-C78XV": @"PERMANENT",
        @"PER-IFDBN-TSJRI": @"PERMANENT",
        @"PER-IPVCM-J3ZJS": @"PERMANENT",
        @"PER-IW505-ITY8G": @"PERMANENT",
        @"PER-J1G26-X2LBY": @"PERMANENT",
        @"PER-JAKWM-4SQMX": @"PERMANENT",
        @"PER-JQ3HV-BFQ60": @"PERMANENT",
        @"PER-KQXMX-M9OYA": @"PERMANENT",
        @"PER-LFR0D-SPV3A": @"PERMANENT",
        @"PER-LHR8W-4XK05": @"PERMANENT",
        @"PER-LNVX3-39X2G": @"PERMANENT",
        @"PER-M05FV-KZURA": @"PERMANENT",
        @"PER-MEHX6-UZ0LV": @"PERMANENT",
        @"PER-NC507-LT0R8": @"PERMANENT",
        @"PER-NV1DS-RU82U": @"PERMANENT",
        @"PER-OMURC-7CYHT": @"PERMANENT",
        @"PER-ONGDQ-GBEU6": @"PERMANENT",
        @"PER-ORH8V-650DZ": @"PERMANENT",
        @"PER-P3827-H2X5T": @"PERMANENT",
        @"PER-P9DN4-6RGJA": @"PERMANENT",
        @"PER-PII9C-NWNNA": @"PERMANENT",
        @"PER-QVEF9-95B7V": @"PERMANENT",
        @"PER-QXKUO-0MZLT": @"PERMANENT",
        @"PER-R2SDS-6YBKR": @"PERMANENT",
        @"PER-R5VO4-K83BT": @"PERMANENT",
        @"PER-RAL1J-0B8TU": @"PERMANENT",
        @"PER-RM6CI-ZGCN0": @"PERMANENT",
        @"PER-RVLDY-7NMY7": @"PERMANENT",
        @"PER-S4XSB-X9GSS": @"PERMANENT",
        @"PER-STCXP-KVIOJ": @"PERMANENT",
        @"PER-STQL3-MA99J": @"PERMANENT",
        @"PER-SUXO1-JS3UA": @"PERMANENT",
        @"PER-TPVGM-HKZEN": @"PERMANENT",
        @"PER-U6ZKY-X4VDI": @"PERMANENT",
        @"PER-U7MEM-DSJFG": @"PERMANENT",
        @"PER-UFGEZ-QHDG8": @"PERMANENT",
        @"PER-UFWR3-3HWOA": @"PERMANENT",
        @"PER-UMIJZ-TUTWF": @"PERMANENT",
        @"PER-UNAN8-GG2VD": @"PERMANENT",
        @"PER-V29CE-ZH2OA": @"PERMANENT",
        @"PER-VEGA8-ET6Y5": @"PERMANENT",
        @"PER-VGERT-D45YE": @"PERMANENT",
        @"PER-VKGAD-0Z1KF": @"PERMANENT",
        @"PER-W8SKK-JIZIX": @"PERMANENT",
        @"PER-WERVC-TKZ0I": @"PERMANENT",
        @"PER-WLGI2-VZQNT": @"PERMANENT",
        @"PER-WS263-VWNCU": @"PERMANENT",
        @"PER-X51RG-ZH0FL": @"PERMANENT",
        @"PER-Y6Q3Z-4HOXU": @"PERMANENT",
        @"PER-Y7NCA-QPYXC": @"PERMANENT",
        @"PER-YPFSF-R1311": @"PERMANENT",
        @"PER-YSC2E-QRXVH": @"PERMANENT",
        @"PER-YWG29-6JT1A": @"PERMANENT",
        @"PER-ZNXWS-NW0FI": @"PERMANENT",
        @"PER-ZT6J0-L6U1A": @"PERMANENT",
        @"PER-ZU4NT-1WRNZ": @"PERMANENT"
        };
    });
    return codes;
}

@implementation AuthPlugin

#pragma mark - Device and state

+ (NSString *)currentDeviceToken {
    // identifierForVendor is suitable for a lightweight local binding only.
    // It may change after all apps from the same vendor are removed/reinstalled.
    return UIDevice.currentDevice.identifierForVendor.UUIDString ?: @"unknown-device";
}

+ (BOOL)isAuthorized {
    NSUserDefaults *defaults = NSUserDefaults.standardUserDefaults;
    NSString *code = [defaults stringForKey:kAuthDefaultsActivatedCode];
    NSString *savedDevice = [defaults stringForKey:kAuthDefaultsDevice];
    if (code.length == 0 || savedDevice.length == 0) return NO;
    if (![savedDevice isEqualToString:[self currentDeviceToken]]) return NO;

    NSString *type = AuthActivationCodes()[code];
    if (type.length == 0) return NO;
    if ([type isEqualToString:@"PERMANENT"]) return YES;

    NSDate *expiry = [defaults objectForKey:kAuthDefaultsExpiry];
    if (![expiry isKindOfClass:NSDate.class]) return NO;
    if ([NSDate.date compare:expiry] != NSOrderedAscending) {
        [defaults removeObjectForKey:kAuthDefaultsActivatedCode];
        [defaults removeObjectForKey:kAuthDefaultsExpiry];
        [defaults removeObjectForKey:kAuthDefaultsDevice];
        [defaults synchronize];
        return NO;
    }
    return YES;
}

+ (BOOL)shouldAllowURL:(NSURL *)url {
    if (!url) return NO;
    NSString *host = url.host.lowercaseString;
    if (host.length == 0) return NO;

    // This gate only applies when YOUR app/plugin calls it before opening/loading a URL.
    // It does not globally intercept or modify another app's networking stack.
    BOOL isIOSGods = [host isEqualToString:@"iosgods.com"] ||
                     [host hasSuffix:@".iosgods.com"];
    if (!isIOSGods) return YES;
    return [self isAuthorized];
}

#pragma mark - Presentation helpers

+ (UIViewController *)topViewControllerFrom:(UIViewController *)root {
    UIViewController *top = root;
    while (top.presentedViewController) top = top.presentedViewController;
    if ([top isKindOfClass:UINavigationController.class]) {
        return [self topViewControllerFrom:((UINavigationController *)top).visibleViewController];
    }
    if ([top isKindOfClass:UITabBarController.class]) {
        return [self topViewControllerFrom:((UITabBarController *)top).selectedViewController];
    }
    return top;
}

+ (UIViewController *)activeViewController {
    for (UIScene *scene in UIApplication.sharedApplication.connectedScenes) {
        if (![scene isKindOfClass:UIWindowScene.class]) continue;
        UIWindowScene *windowScene = (UIWindowScene *)scene;
        for (UIWindow *window in windowScene.windows) {
            if (window.isKeyWindow && window.rootViewController) {
                return [self topViewControllerFrom:window.rootViewController];
            }
        }
    }
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    UIWindow *window = UIApplication.sharedApplication.keyWindow;
#pragma clang diagnostic pop
    return window.rootViewController ? [self topViewControllerFrom:window.rootViewController] : nil;
}

+ (void)start {
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([self isAuthorized]) return;
        [self showChoiceDialog];
    });
}

+ (void)showChoiceDialog {
    UIViewController *presenter = [self activeViewController];
    if (!presenter || presenter.presentedViewController) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self showChoiceDialog];
        });
        return;
    }

    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"ææéªè¯"
                                                                   message:@"è¯·éæ©æ¯å¦æ¿æ´»è¾å©åè½"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"æ¿æ´»" style:UIAlertActionStyleDefault handler:^(__unused UIAlertAction *action) {
        [self showActivationInput];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"ä¸ä½¿ç¨è¾å©" style:UIAlertActionStyleCancel handler:^(__unused UIAlertAction *action) {
        // No activation is stored. iosgods.com remains blocked by shouldAllowURL:.
    }]];
    [presenter presentViewController:alert animated:YES completion:nil];
}

+ (void)showActivationInput {
    UIViewController *presenter = [self activeViewController];
    if (!presenter) return;

    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"è¾å¥æ¿æ´»ç "
                                                                   message:@"è¯·è¾å¥ææçæ¥å¡ãæå¡ææ°¸ä¹å¡æ¿æ´»ç "
                                                            preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField *field) {
        field.placeholder = @"è¯·è¾å¥æ¿æ´»ç ";
        field.autocapitalizationType = UITextAutocapitalizationTypeAllCharacters;
        field.autocorrectionType = UITextAutocorrectionTypeNo;
        field.clearButtonMode = UITextFieldViewModeWhileEditing;
    }];
    [alert addAction:[UIAlertAction actionWithTitle:@"ç¡®è®¤æ¿æ´»" style:UIAlertActionStyleDefault handler:^(__unused UIAlertAction *action) {
        NSString *code = alert.textFields.firstObject.text.uppercaseString;
        [self validateCode:code];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"ä¸ä½¿ç¨è¾å©" style:UIAlertActionStyleCancel handler:^(__unused UIAlertAction *action) {
        // Remains unauthorized; the URL gate continues to deny iosgods.com.
    }]];
    [presenter presentViewController:alert animated:YES completion:nil];
}

+ (void)showInvalidCodeDialog {
    UIViewController *presenter = [self activeViewController];
    if (!presenter) return;

    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"æ¿æ´»ç éè¯¯"
                                                                   message:@"æ¿æ´»ç æ æï¼è¯·æ£æ¥åéè¯"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"éæ°è¾å¥" style:UIAlertActionStyleDefault handler:^(__unused UIAlertAction *action) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.35 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self showActivationInput];
        });
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"ä¸ä½¿ç¨è¾å©" style:UIAlertActionStyleCancel handler:^(__unused UIAlertAction *action) {
        // Remains unauthorized.
    }]];
    [presenter presentViewController:alert animated:YES completion:nil];
}

+ (void)validateCode:(NSString *)code {
    NSString *type = AuthActivationCodes()[code ?: @""];
    if (type.length == 0) {
        [self showInvalidCodeDialog];
        return;
    }

    NSUserDefaults *defaults = NSUserDefaults.standardUserDefaults;
    // A code already activated in this installation cannot be replaced by another code.
    // A server is required to enforce global one-time redemption across multiple devices.
    NSString *existingCode = [defaults stringForKey:kAuthDefaultsActivatedCode];
    if (existingCode.length > 0 && ![existingCode isEqualToString:code]) {
        [self showInvalidCodeDialog];
        return;
    }

    [defaults setObject:code forKey:kAuthDefaultsActivatedCode];
    [defaults setObject:[self currentDeviceToken] forKey:kAuthDefaultsDevice];

    if ([type isEqualToString:@"DAY"]) {
        [defaults setObject:[NSDate.date dateByAddingTimeInterval:24.0 * 60.0 * 60.0] forKey:kAuthDefaultsExpiry];
    } else if ([type isEqualToString:@"MONTH"]) {
        [defaults setObject:[NSDate.date dateByAddingTimeInterval:30.0 * 24.0 * 60.0 * 60.0] forKey:kAuthDefaultsExpiry];
    } else {
        [defaults removeObjectForKey:kAuthDefaultsExpiry];
    }
    [defaults synchronize];

    UIViewController *presenter = [self activeViewController];
    UIAlertController *success = [UIAlertController alertControllerWithTitle:@"æå"
                                                                     message:@"ææéªè¯éè¿"
                                                              preferredStyle:UIAlertControllerStyleAlert];
    [success addAction:[UIAlertAction actionWithTitle:@"ç¡®å®" style:UIAlertActionStyleDefault handler:nil]];
    [presenter presentViewController:success animated:YES completion:nil];
}

@end
