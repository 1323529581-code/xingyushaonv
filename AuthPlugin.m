// AuthPlugin.m
// Standalone local activation UI for an app you own and are authorized to modify.
// Includes the supplied 300 activation codes directly in this file.

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <Security/Security.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^AuthPluginFinishedHandler)(BOOL activated);

FOUNDATION_EXPORT void AuthPluginStart(UIViewController *presenter,
                                       UIView *protectedPopup,
                                       AuthPluginFinishedHandler _Nullable finished);
FOUNDATION_EXPORT void AuthPluginClearCachedActivation(void);

typedef struct { const char *code; const char *plan; } AuthEmbeddedCode;
static const AuthEmbeddedCode kAuthEmbeddedCodes[] = {
    { "DAY-010XZ-2WNDE", "日卡" },
    { "DAY-05BY8-A5AT3", "日卡" },
    { "DAY-06HQ3-N51W3", "日卡" },
    { "DAY-0H6Y4-PZTRY", "日卡" },
    { "DAY-0RKAF-DC8MT", "日卡" },
    { "DAY-12R7O-W5ZAC", "日卡" },
    { "DAY-13IMD-ZW9Z2", "日卡" },
    { "DAY-1LG22-11BGP", "日卡" },
    { "DAY-1LKOQ-MPKR2", "日卡" },
    { "DAY-1ZY8Z-CG4JH", "日卡" },
    { "DAY-2FZW3-60L4R", "日卡" },
    { "DAY-2VYYD-MPGHY", "日卡" },
    { "DAY-3GNXF-5TGTS", "日卡" },
    { "DAY-3W00K-QA1MT", "日卡" },
    { "DAY-4B4MC-OWLI4", "日卡" },
    { "DAY-4Z9GP-8PLXL", "日卡" },
    { "DAY-5DPTM-TAIU2", "日卡" },
    { "DAY-5JE31-8SAK4", "日卡" },
    { "DAY-5SEEB-BX9PM", "日卡" },
    { "DAY-6UOXE-LKP92", "日卡" },
    { "DAY-6YH0E-LHAQT", "日卡" },
    { "DAY-769HC-LK9N7", "日卡" },
    { "DAY-7LBFV-30DHG", "日卡" },
    { "DAY-7YR53-5P1CN", "日卡" },
    { "DAY-86PSV-DN1Z6", "日卡" },
    { "DAY-8NWIO-EADO6", "日卡" },
    { "DAY-8SPIG-UEE8J", "日卡" },
    { "DAY-8ZZC3-43IYM", "日卡" },
    { "DAY-93A2W-Q3CE7", "日卡" },
    { "DAY-9WQGS-QCOSD", "日卡" },
    { "DAY-AFA8W-S1N42", "日卡" },
    { "DAY-AMU10-NLTKU", "日卡" },
    { "DAY-AWQPU-FDL9R", "日卡" },
    { "DAY-BKGQ5-JHHG4", "日卡" },
    { "DAY-BNW82-2VK4H", "日卡" },
    { "DAY-BRM6C-YS55W", "日卡" },
    { "DAY-BSLIW-I8XOI", "日卡" },
    { "DAY-BZD66-YB0YB", "日卡" },
    { "DAY-C1U3C-AZHN2", "日卡" },
    { "DAY-CYPPZ-3U7L7", "日卡" },
    { "DAY-D57M6-E0812", "日卡" },
    { "DAY-DGKMG-DIIQP", "日卡" },
    { "DAY-DPMG4-ZJ2EY", "日卡" },
    { "DAY-EM3C8-3T29Y", "日卡" },
    { "DAY-EZGM2-RR1I1", "日卡" },
    { "DAY-G26U3-JBLVX", "日卡" },
    { "DAY-GAEFN-1PA19", "日卡" },
    { "DAY-GBC7J-P8YDU", "日卡" },
    { "DAY-GC5ZC-GQGA9", "日卡" },
    { "DAY-GOWHW-BZHSK", "日卡" },
    { "DAY-H1PYO-H2DCJ", "日卡" },
    { "DAY-H7FZJ-ZKTDF", "日卡" },
    { "DAY-HB9OD-5HTMJ", "日卡" },
    { "DAY-HEE3P-RHBEH", "日卡" },
    { "DAY-HIWY0-L1734", "日卡" },
    { "DAY-HN913-D6IO7", "日卡" },
    { "DAY-I8W2V-WRVCI", "日卡" },
    { "DAY-IP1U0-AOEP4", "日卡" },
    { "DAY-ITV94-6CCKZ", "日卡" },
    { "DAY-K0QUB-G1MKC", "日卡" },
    { "DAY-L0SHA-NZ6O0", "日卡" },
    { "DAY-LDKPA-TWL57", "日卡" },
    { "DAY-LW1I9-0KQ0M", "日卡" },
    { "DAY-M6GN8-0L094", "日卡" },
    { "DAY-NNSKL-3D0D7", "日卡" },
    { "DAY-NWV9C-FHABE", "日卡" },
    { "DAY-OT794-QGTZN", "日卡" },
    { "DAY-PAT93-EZ2RQ", "日卡" },
    { "DAY-QCZVH-QABT6", "日卡" },
    { "DAY-QYEFM-BR3HD", "日卡" },
    { "DAY-R1F25-DXOWK", "日卡" },
    { "DAY-R88L3-MH4LD", "日卡" },
    { "DAY-RFQ5U-SNNM5", "日卡" },
    { "DAY-RM3IA-MWW95", "日卡" },
    { "DAY-S86HY-16RH2", "日卡" },
    { "DAY-S9G7E-JPKUK", "日卡" },
    { "DAY-SAMQ4-J9SVU", "日卡" },
    { "DAY-SDNS8-AFQ2Z", "日卡" },
    { "DAY-SI3OE-P8I7X", "日卡" },
    { "DAY-SMV73-WGP98", "日卡" },
    { "DAY-SP64Q-QPOG4", "日卡" },
    { "DAY-SSTT7-671YZ", "日卡" },
    { "DAY-TC1T3-SH9CA", "日卡" },
    { "DAY-TH7EV-32SP5", "日卡" },
    { "DAY-TLHXB-OQ4XN", "日卡" },
    { "DAY-TMTAF-2J7FT", "日卡" },
    { "DAY-UDWUI-ME32O", "日卡" },
    { "DAY-V0PTR-02OP2", "日卡" },
    { "DAY-V43TR-AKOXA", "日卡" },
    { "DAY-V6TE3-DLF3W", "日卡" },
    { "DAY-V9IR8-FO6LP", "日卡" },
    { "DAY-VL4WG-OXZ44", "日卡" },
    { "DAY-WCQ4V-48923", "日卡" },
    { "DAY-WDPJH-2JVHU", "日卡" },
    { "DAY-XN4SI-F5JS4", "日卡" },
    { "DAY-Y0TB1-WSL0U", "日卡" },
    { "DAY-YSES8-KDSUI", "日卡" },
    { "DAY-Z3UU3-1D2UB", "日卡" },
    { "DAY-Z71BF-2T29M", "日卡" },
    { "DAY-ZMDDZ-SSJFM", "日卡" },
    { "MON-04SOM-SSBJZ", "月卡" },
    { "MON-09I2O-PUFWG", "月卡" },
    { "MON-0FIUU-DUYVB", "月卡" },
    { "MON-0NF4D-KLFYB", "月卡" },
    { "MON-0RFI2-DGE1E", "月卡" },
    { "MON-2AJ1G-K016Z", "月卡" },
    { "MON-2BFZY-EI4JP", "月卡" },
    { "MON-2EE1U-TI1PC", "月卡" },
    { "MON-2G4ER-UVF9N", "月卡" },
    { "MON-2QR4K-VQS9I", "月卡" },
    { "MON-2RK7G-O5PAY", "月卡" },
    { "MON-3XYJS-PBN37", "月卡" },
    { "MON-4910G-3CN6Q", "月卡" },
    { "MON-5446W-SCC6Q", "月卡" },
    { "MON-5OG51-EU0QU", "月卡" },
    { "MON-5P6IL-ZMSKT", "月卡" },
    { "MON-61IOP-PX1K3", "月卡" },
    { "MON-61RS4-ALPSB", "月卡" },
    { "MON-69LN4-96WDW", "月卡" },
    { "MON-6L2IS-L1FU5", "月卡" },
    { "MON-6V6YU-91OGD", "月卡" },
    { "MON-75CZY-B8D2Z", "月卡" },
    { "MON-7GT0O-75VAJ", "月卡" },
    { "MON-7IDMT-XZ8KC", "月卡" },
    { "MON-7P7PS-CDZNB", "月卡" },
    { "MON-80QHS-YBRP7", "月卡" },
    { "MON-8CKN9-G85NA", "月卡" },
    { "MON-8J4KB-QH3YR", "月卡" },
    { "MON-9EG0Z-C040S", "月卡" },
    { "MON-A2JN4-DLDOX", "月卡" },
    { "MON-B9OEM-ZZJGX", "月卡" },
    { "MON-BRFYZ-8A78V", "月卡" },
    { "MON-BUCS2-USY9W", "月卡" },
    { "MON-BWZ5Z-D2OTY", "月卡" },
    { "MON-C2DY6-F5LZT", "月卡" },
    { "MON-CFA5O-13CIO", "月卡" },
    { "MON-CMUQ0-EU4KB", "月卡" },
    { "MON-CSAPG-XLHML", "月卡" },
    { "MON-DBBZO-I23Q7", "月卡" },
    { "MON-DJ2RD-0Z7FT", "月卡" },
    { "MON-DJKOP-6UG1D", "月卡" },
    { "MON-EM3SC-XBV56", "月卡" },
    { "MON-F1V6P-9K62R", "月卡" },
    { "MON-FXVRO-JH9VF", "月卡" },
    { "MON-GBBOH-V1A8G", "月卡" },
    { "MON-GIBPE-TGVY4", "月卡" },
    { "MON-GIGPV-7D9PT", "月卡" },
    { "MON-GZLIJ-U49MK", "月卡" },
    { "MON-H97QR-KPUHZ", "月卡" },
    { "MON-HHPRS-5UPXI", "月卡" },
    { "MON-HLH65-5DBP5", "月卡" },
    { "MON-HPRKO-52KC4", "月卡" },
    { "MON-HWBHD-KXJVG", "月卡" },
    { "MON-I0HX1-XHRZL", "月卡" },
    { "MON-I6476-GSU4K", "月卡" },
    { "MON-IJ52T-88WUX", "月卡" },
    { "MON-JF6IG-A4GS8", "月卡" },
    { "MON-JGG3R-W3H34", "月卡" },
    { "MON-JK8GC-MGYK6", "月卡" },
    { "MON-JT0V2-SBOCC", "月卡" },
    { "MON-K174U-PK1NP", "月卡" },
    { "MON-KBKJI-JSM0I", "月卡" },
    { "MON-KE61H-JM0E3", "月卡" },
    { "MON-KFY45-C6OHD", "月卡" },
    { "MON-KKXR5-O29M7", "月卡" },
    { "MON-L53S1-WN0GW", "月卡" },
    { "MON-LTIJO-L7BMA", "月卡" },
    { "MON-M0KVS-CD3HQ", "月卡" },
    { "MON-MDEGR-RKWXE", "月卡" },
    { "MON-MQXSD-O8865", "月卡" },
    { "MON-MRHGK-OG95I", "月卡" },
    { "MON-NQ3N1-XYH0N", "月卡" },
    { "MON-O6HLZ-SZABY", "月卡" },
    { "MON-OS84L-KL94W", "月卡" },
    { "MON-OSBNW-0STZM", "月卡" },
    { "MON-OWKMC-NUKMY", "月卡" },
    { "MON-OYS6G-P57BJ", "月卡" },
    { "MON-P0FMA-OHJWM", "月卡" },
    { "MON-P516H-EBVKC", "月卡" },
    { "MON-P8YD2-D58Q7", "月卡" },
    { "MON-PFGGC-G8APJ", "月卡" },
    { "MON-PVDNW-93O0G", "月卡" },
    { "MON-QAC4J-02F5P", "月卡" },
    { "MON-QKQFU-QRJOI", "月卡" },
    { "MON-QU4AR-WEI0W", "月卡" },
    { "MON-R928E-CAAXC", "月卡" },
    { "MON-RSHHP-2RH56", "月卡" },
    { "MON-RYU42-KN37J", "月卡" },
    { "MON-SCCHE-COWLQ", "月卡" },
    { "MON-SMFRU-ACYMJ", "月卡" },
    { "MON-SNKGN-EU99G", "月卡" },
    { "MON-SXB9Z-KDVB7", "月卡" },
    { "MON-SYV74-46BC1", "月卡" },
    { "MON-U59ZT-DM07D", "月卡" },
    { "MON-UHC5U-YDLQF", "月卡" },
    { "MON-VOLG0-GKOGX", "月卡" },
    { "MON-W9N6V-35BOL", "月卡" },
    { "MON-WAYHC-R2B6T", "月卡" },
    { "MON-X647P-Q9PLR", "月卡" },
    { "MON-YKKL9-PVHP0", "月卡" },
    { "PER-0AVW4-KRYF8", "永久卡" },
    { "PER-0KPG1-9EXOF", "永久卡" },
    { "PER-1HK6F-L6FPY", "永久卡" },
    { "PER-1JXH0-G1N28", "永久卡" },
    { "PER-2989F-D6698", "永久卡" },
    { "PER-2I0KC-22JG9", "永久卡" },
    { "PER-3YY40-50Z99", "永久卡" },
    { "PER-4O0CX-MTRSV", "永久卡" },
    { "PER-55862-O189R", "永久卡" },
    { "PER-5HCPF-2QPYT", "永久卡" },
    { "PER-615PA-GRXFY", "永久卡" },
    { "PER-6E661-DN008", "永久卡" },
    { "PER-6RT5K-SY959", "永久卡" },
    { "PER-6ZYHE-R9HS1", "永久卡" },
    { "PER-70TQZ-UQDBH", "永久卡" },
    { "PER-71XM2-INFGL", "永久卡" },
    { "PER-7CV6K-GMN0K", "永久卡" },
    { "PER-7NIZ2-LORYH", "永久卡" },
    { "PER-820A7-YB5HX", "永久卡" },
    { "PER-8AS5F-53W1E", "永久卡" },
    { "PER-8VU79-YTAGX", "永久卡" },
    { "PER-8Z9VL-4EX76", "永久卡" },
    { "PER-AFQ6L-RQKSQ", "永久卡" },
    { "PER-B0FX3-R85PU", "永久卡" },
    { "PER-BBMB4-3109S", "永久卡" },
    { "PER-BGHKA-XONCZ", "永久卡" },
    { "PER-BH8LT-5ON81", "永久卡" },
    { "PER-BL4K5-REN8B", "永久卡" },
    { "PER-CNKQQ-HJW8F", "永久卡" },
    { "PER-DE84V-G54KW", "永久卡" },
    { "PER-E3N9V-D3SZ0", "永久卡" },
    { "PER-EDJDV-492HS", "永久卡" },
    { "PER-ELNUO-X1OQ3", "永久卡" },
    { "PER-EUC63-H7QOD", "永久卡" },
    { "PER-F2C7U-IXQ6M", "永久卡" },
    { "PER-F7I39-E4OAT", "永久卡" },
    { "PER-FY34V-PNGKZ", "永久卡" },
    { "PER-G1LY5-V3ORH", "永久卡" },
    { "PER-GCVG5-W43EU", "永久卡" },
    { "PER-GEDDG-SSF6B", "永久卡" },
    { "PER-H28E5-8E7B8", "永久卡" },
    { "PER-H3YZ5-D1IFK", "永久卡" },
    { "PER-HSRNL-O8T4V", "永久卡" },
    { "PER-HSZF8-XT7JB", "永久卡" },
    { "PER-I1NC7-C78XV", "永久卡" },
    { "PER-IFDBN-TSJRI", "永久卡" },
    { "PER-IPVCM-J3ZJS", "永久卡" },
    { "PER-IW505-ITY8G", "永久卡" },
    { "PER-J1G26-X2LBY", "永久卡" },
    { "PER-JAKWM-4SQMX", "永久卡" },
    { "PER-JQ3HV-BFQ60", "永久卡" },
    { "PER-KQXMX-M9OYA", "永久卡" },
    { "PER-LFR0D-SPV3A", "永久卡" },
    { "PER-LHR8W-4XK05", "永久卡" },
    { "PER-LNVX3-39X2G", "永久卡" },
    { "PER-M05FV-KZURA", "永久卡" },
    { "PER-MEHX6-UZ0LV", "永久卡" },
    { "PER-NC507-LT0R8", "永久卡" },
    { "PER-NV1DS-RU82U", "永久卡" },
    { "PER-OMURC-7CYHT", "永久卡" },
    { "PER-ONGDQ-GBEU6", "永久卡" },
    { "PER-ORH8V-650DZ", "永久卡" },
    { "PER-P3827-H2X5T", "永久卡" },
    { "PER-P9DN4-6RGJA", "永久卡" },
    { "PER-PII9C-NWNNA", "永久卡" },
    { "PER-QVEF9-95B7V", "永久卡" },
    { "PER-QXKUO-0MZLT", "永久卡" },
    { "PER-R2SDS-6YBKR", "永久卡" },
    { "PER-R5VO4-K83BT", "永久卡" },
    { "PER-RAL1J-0B8TU", "永久卡" },
    { "PER-RM6CI-ZGCN0", "永久卡" },
    { "PER-RVLDY-7NMY7", "永久卡" },
    { "PER-S4XSB-X9GSS", "永久卡" },
    { "PER-STCXP-KVIOJ", "永久卡" },
    { "PER-STQL3-MA99J", "永久卡" },
    { "PER-SUXO1-JS3UA", "永久卡" },
    { "PER-TPVGM-HKZEN", "永久卡" },
    { "PER-U6ZKY-X4VDI", "永久卡" },
    { "PER-U7MEM-DSJFG", "永久卡" },
    { "PER-UFGEZ-QHDG8", "永久卡" },
    { "PER-UFWR3-3HWOA", "永久卡" },
    { "PER-UMIJZ-TUTWF", "永久卡" },
    { "PER-UNAN8-GG2VD", "永久卡" },
    { "PER-V29CE-ZH2OA", "永久卡" },
    { "PER-VEGA8-ET6Y5", "永久卡" },
    { "PER-VGERT-D45YE", "永久卡" },
    { "PER-VKGAD-0Z1KF", "永久卡" },
    { "PER-W8SKK-JIZIX", "永久卡" },
    { "PER-WERVC-TKZ0I", "永久卡" },
    { "PER-WLGI2-VZQNT", "永久卡" },
    { "PER-WS263-VWNCU", "永久卡" },
    { "PER-X51RG-ZH0FL", "永久卡" },
    { "PER-Y6Q3Z-4HOXU", "永久卡" },
    { "PER-Y7NCA-QPYXC", "永久卡" },
    { "PER-YPFSF-R1311", "永久卡" },
    { "PER-YSC2E-QRXVH", "永久卡" },
    { "PER-YWG29-6JT1A", "永久卡" },
    { "PER-ZNXWS-NW0FI", "永久卡" },
    { "PER-ZT6J0-L6U1A", "永久卡" },
    { "PER-ZU4NT-1WRNZ", "永久卡" },
};
static const NSUInteger kAuthEmbeddedCodeCount = sizeof(kAuthEmbeddedCodes) / sizeof(kAuthEmbeddedCodes[0]);

static NSString * const kAuthService = @"com.example.AuthPlugin.Local";
static NSString * const kAuthAccount = @"activation-record";

static NSString *AuthDeviceIdentifier(void) {
    return UIDevice.currentDevice.identifierForVendor.UUIDString ?: @"vendor-id-unavailable";
}

static NSDictionary *AuthReadRecord(void) {
    NSDictionary *q = @{
        (__bridge id)kSecClass: (__bridge id)kSecClassGenericPassword,
        (__bridge id)kSecAttrService: kAuthService,
        (__bridge id)kSecAttrAccount: kAuthAccount,
        (__bridge id)kSecReturnData: @YES,
        (__bridge id)kSecMatchLimit: (__bridge id)kSecMatchLimitOne
    };
    CFTypeRef result = NULL;
    OSStatus status = SecItemCopyMatching((__bridge CFDictionaryRef)q, &result);
    if (status != errSecSuccess || !result) return nil;
    NSData *data = CFBridgingRelease(result);
    id obj = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    return [obj isKindOfClass:NSDictionary.class] ? obj : nil;
}

static void AuthWriteRecord(NSDictionary *record) {
    NSData *data = [NSJSONSerialization dataWithJSONObject:record options:0 error:nil];
    if (!data) return;
    NSDictionary *q = @{
        (__bridge id)kSecClass: (__bridge id)kSecClassGenericPassword,
        (__bridge id)kSecAttrService: kAuthService,
        (__bridge id)kSecAttrAccount: kAuthAccount
    };
    SecItemDelete((__bridge CFDictionaryRef)q);
    NSMutableDictionary *item = [q mutableCopy];
    item[(__bridge id)kSecValueData] = data;
    item[(__bridge id)kSecAttrAccessible] =
        (__bridge id)kSecAttrAccessibleAfterFirstUnlockThisDeviceOnly;
    SecItemAdd((__bridge CFDictionaryRef)item, NULL);
}

void AuthPluginClearCachedActivation(void) {
    NSDictionary *q = @{
        (__bridge id)kSecClass: (__bridge id)kSecClassGenericPassword,
        (__bridge id)kSecAttrService: kAuthService,
        (__bridge id)kSecAttrAccount: kAuthAccount
    };
    SecItemDelete((__bridge CFDictionaryRef)q);
}

static NSString *AuthPlanForCode(NSString *candidate) {
    for (NSUInteger i = 0; i < kAuthEmbeddedCodeCount; i++) {
        NSString *known = [NSString stringWithUTF8String:kAuthEmbeddedCodes[i].code];
        if ([known caseInsensitiveCompare:candidate] == NSOrderedSame)
            return [NSString stringWithUTF8String:kAuthEmbeddedCodes[i].plan];
    }
    return nil;
}

static BOOL AuthRecordIsValid(NSDictionary *record) {
    NSString *plan = record[@"plan"];
    NSString *device = record[@"device"];
    NSNumber *activatedAt = record[@"activatedAt"];
    if (![plan isKindOfClass:NSString.class] ||
        ![device isKindOfClass:NSString.class] ||
        ![activatedAt isKindOfClass:NSNumber.class] ||
        ![device isEqualToString:AuthDeviceIdentifier()]) return NO;

    if ([plan isEqualToString:@"永久卡"]) return YES;
    NSTimeInterval duration = [plan isEqualToString:@"日卡"] ? 86400.0 :
        ([plan isEqualToString:@"月卡"] ? 30.0 * 86400.0 : 0.0);
    return duration > 0 &&
        [NSDate date].timeIntervalSince1970 < activatedAt.doubleValue + duration;
}

@interface AuthPluginView : UIView <UITextFieldDelegate>
@property(nonatomic, weak) UIView *protectedPopup;
@property(nonatomic, copy) AuthPluginFinishedHandler finished;
@property(nonatomic, strong) UIView *card;
@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) UILabel *messageLabel;
@property(nonatomic, strong) UITextField *codeField;
@property(nonatomic, strong) UIButton *primaryButton;
@property(nonatomic, strong) UIButton *secondaryButton;
@property(nonatomic, strong) UIStackView *contentStack;
@property(nonatomic) BOOL finishedOnce;
- (void)showEntry;
- (void)showError;
- (void)showSuccess:(NSString *)plan;
@end

@implementation AuthPluginView

- (instancetype)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) [self buildUI];
    return self;
}

- (void)buildUI {
    self.backgroundColor = [UIColor colorWithWhite:0.035 alpha:0.94];

    UIView *card = [UIView new];
    card.translatesAutoresizingMaskIntoConstraints = NO;
    card.backgroundColor = [UIColor colorWithRed:0.10 green:0.12 blue:0.17 alpha:1];
    card.layer.cornerRadius = 20;
    card.layer.borderWidth = 1;
    card.layer.borderColor = [UIColor colorWithWhite:1 alpha:0.12].CGColor;
    [self addSubview:card];
    self.card = card;

    UILayoutGuide *safe = self.safeAreaLayoutGuide;
    [NSLayoutConstraint activateConstraints:@[
        [card.centerYAnchor constraintEqualToAnchor:safe.centerYAnchor],
        [card.leadingAnchor constraintGreaterThanOrEqualToAnchor:self.leadingAnchor constant:24],
        [card.trailingAnchor constraintLessThanOrEqualToAnchor:self.trailingAnchor constant:-24],
        [card.widthAnchor constraintLessThanOrEqualToConstant:390],
        [card.widthAnchor constraintEqualToConstant:MIN(UIScreen.mainScreen.bounds.size.width - 40, 390)],
        [card.centerXAnchor constraintEqualToAnchor:self.centerXAnchor]
    ]];

    UIStackView *stack = [[UIStackView alloc] init];
    stack.axis = UILayoutConstraintAxisVertical;
    stack.spacing = 15;
    stack.alignment = UIStackViewAlignmentFill;
    stack.translatesAutoresizingMaskIntoConstraints = NO;
    [card addSubview:stack];
    self.contentStack = stack;
    [NSLayoutConstraint activateConstraints:@[
        [stack.topAnchor constraintEqualToAnchor:card.topAnchor constant:28],
        [stack.bottomAnchor constraintEqualToAnchor:card.bottomAnchor constant:-26],
        [stack.leadingAnchor constraintEqualToAnchor:card.leadingAnchor constant:24],
        [stack.trailingAnchor constraintEqualToAnchor:card.trailingAnchor constant:-24]
    ]];

    UILabel *title = [UILabel new];
    title.text = @"授权验证";
    title.textColor = UIColor.whiteColor;
    title.font = [UIFont boldSystemFontOfSize:25];
    title.textAlignment = NSTextAlignmentCenter;
    self.titleLabel = title;
    [stack addArrangedSubview:title];

    UILabel *message = [UILabel new];
    message.text = @"请输入激活码以验证使用权限";
    message.textColor = [UIColor colorWithWhite:1 alpha:0.68];
    message.font = [UIFont systemFontOfSize:14];
    message.textAlignment = NSTextAlignmentCenter;
    message.numberOfLines = 0;
    self.messageLabel = message;
    [stack addArrangedSubview:message];

    UITextField *field = [UITextField new];
    field.translatesAutoresizingMaskIntoConstraints = NO;
    field.placeholder = @"请输入激活码";
    field.textColor = UIColor.whiteColor;
    field.tintColor = UIColor.whiteColor;
    field.font = [UIFont systemFontOfSize:16];
    field.autocapitalizationType = UITextAutocapitalizationTypeAllCharacters;
    field.autocorrectionType = UITextAutocorrectionTypeNo;
    field.clearButtonMode = UITextFieldViewModeWhileEditing;
    field.returnKeyType = UIReturnKeyDone;
    field.delegate = self;
    field.backgroundColor = [UIColor colorWithWhite:1 alpha:0.08];
    field.layer.cornerRadius = 11;
    field.layer.borderWidth = 1;
    field.layer.borderColor = [UIColor colorWithWhite:1 alpha:0.13].CGColor;
    UIView *pad = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 12, 48)];
    field.leftView = pad;
    field.leftViewMode = UITextFieldViewModeAlways;
    [stack addArrangedSubview:field];
    [field.heightAnchor constraintEqualToConstant:48].active = YES;
    self.codeField = field;

    UIButton *primary = [self buttonWithTitle:@"激活" background:[UIColor colorWithRed:0.16 green:0.43 blue:0.91 alpha:1]];
    [primary addTarget:self action:@selector(primaryTapped) forControlEvents:UIControlEventTouchUpInside];
    [stack addArrangedSubview:primary];
    self.primaryButton = primary;

    UIButton *secondary = [self buttonWithTitle:@"不使用辅助" background:[UIColor colorWithWhite:1 alpha:0.10]];
    [secondary addTarget:self action:@selector(cancelTapped) forControlEvents:UIControlEventTouchUpInside];
    [stack addArrangedSubview:secondary];
    self.secondaryButton = secondary;

    [self showChoice];
}

- (UIButton *)buttonWithTitle:(NSString *)title background:(UIColor *)color {
    UIButton *b = [UIButton buttonWithType:UIButtonTypeSystem];
    b.translatesAutoresizingMaskIntoConstraints = NO;
    b.backgroundColor = color;
    b.layer.cornerRadius = 11;
    [b setTitle:title forState:UIControlStateNormal];
    [b setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    b.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [b.heightAnchor constraintEqualToConstant:48].active = YES;
    return b;
}

- (void)setTitle:(NSString *)title message:(NSString *)message primary:(NSString *)primary secondary:(NSString *)secondary {
    self.titleLabel.text = title;
    self.messageLabel.text = message;
    [self.primaryButton setTitle:primary forState:UIControlStateNormal];
    [self.secondaryButton setTitle:secondary forState:UIControlStateNormal];
}

- (void)showChoice {
    self.codeField.hidden = YES;
    [self setTitle:@"授权验证" message:@"请选择是否激活辅助功能。" primary:@"激活" secondary:@"不使用辅助"];
}

- (void)showEntry {
    self.codeField.hidden = NO;
    self.codeField.text = @"";
    [self setTitle:@"输入激活码" message:@"请输入有效的激活码。" primary:@"确认激活" secondary:@"不使用辅助"];
    [self.codeField becomeFirstResponder];
}

- (void)showError {
    self.codeField.hidden = YES;
    [self setTitle:@"激活码错误" message:@"激活码无效，请检查后重新输入。" primary:@"重新输入" secondary:@"不使用辅助"];
}

- (void)showSuccess:(NSString *)plan {
    self.codeField.hidden = YES;
    [self setTitle:@"成功" message:[NSString stringWithFormat:@"%@授权成功！点击确定继续。", plan] primary:@"确定" secondary:@"关闭"];
}

- (void)primaryTapped {
    NSString *title = self.titleLabel.text ?: @"";
    if ([title isEqualToString:@"授权验证"]) {
        [self showEntry];
    } else if ([title isEqualToString:@"输入激活码"]) {
        NSString *candidate = [[self.codeField.text ?: @"" stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet] uppercaseString];
        NSString *plan = AuthPlanForCode(candidate);
        if (!plan) { [self showError]; return; }

        NSDate *now = [NSDate date];
        NSMutableDictionary *record = [@{
            @"plan": plan,
            @"device": AuthDeviceIdentifier(),
            @"activatedAt": @([now timeIntervalSince1970])
        } mutableCopy];
        AuthWriteRecord(record);
        [self.codeField resignFirstResponder];
        [self showSuccess:plan];
    } else if ([title isEqualToString:@"激活码错误"]) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.35 * NSEC_PER_SEC)),
                       dispatch_get_main_queue(), ^{ [self showEntry]; });
    } else if ([title isEqualToString:@"成功"]) {
        [self finish:YES];
    }
}

- (void)cancelTapped {
    NSString *title = self.titleLabel.text ?: @"";
    if ([title isEqualToString:@"成功"]) {
        [self finish:YES];
    } else {
        [self finish:NO];
    }
}

- (void)finish:(BOOL)activated {
    if (self.finishedOnce) return;
    self.finishedOnce = YES;
    [self.codeField resignFirstResponder];
    self.protectedPopup.hidden = !activated;
    [UIView animateWithDuration:0.2 animations:^{ self.alpha = 0; }
                     completion:^(__unused BOOL done) {
        [self removeFromSuperview];
        if (self.finished) self.finished(activated);
    }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    [self primaryTapped];
    return YES;
}

@end

static __weak AuthPluginView *gAuthView = nil;

void AuthPluginStart(UIViewController *presenter,
                     UIView *protectedPopup,
                     AuthPluginFinishedHandler finished) {
    if (!presenter || !protectedPopup) return;

    dispatch_async(dispatch_get_main_queue(), ^{
        protectedPopup.hidden = YES;

        NSDictionary *saved = AuthReadRecord();
        if (saved && AuthRecordIsValid(saved)) {
            protectedPopup.hidden = NO;
            if (finished) finished(YES);
            return;
        }
        if (saved) AuthPluginClearCachedActivation();

        UIWindow *window = presenter.view.window;
        if (!window) window = UIApplication.sharedApplication.keyWindow;
        if (!window) {
            if (finished) finished(NO);
            return;
        }

        [gAuthView removeFromSuperview];
        AuthPluginView *view = [[AuthPluginView alloc] initWithFrame:window.bounds];
        view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        view.protectedPopup = protectedPopup;
        view.finished = finished;
        view.alpha = 0;
        [window addSubview:view];
        gAuthView = view;
        [UIView animateWithDuration:0.2 animations:^{ view.alpha = 1; }];
    });
}

NS_ASSUME_NONNULL_END
