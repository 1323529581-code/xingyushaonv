#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <dlfcn.h>

static NSString * const kKeyActiveCode = @"ActiveAuthCode";
static NSString * const kKeyActiveDevice = @"ActiveAuthDevice";
static NSString * const kKeyActivationTime = @"ActiveAuthTime";
static NSString * const kKeyCodeType = @"ActiveCodeType";

static NSArray *getAuthDatabase() {
    static NSArray *database = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        database = @[
            // ===== 星欲少女 日卡 (100) =====
            @{@"code": @"DAY-010XZ-2WNDE", @"type": @"日卡"}, @{@"code": @"DAY-05BY8-A5AT3", @"type": @"日卡"}, @{@"code": @"DAY-06HQ3-N51W3", @"type": @"日卡"}, @{@"code": @"DAY-0H6Y4-PZTRY", @"type": @"日卡"}, @{@"code": @"DAY-0RKAF-DC8MT", @"type": @"日卡"}, @{@"code": @"DAY-12R7O-W5ZAC", @"type": @"日卡"}, @{@"code": @"DAY-13IMD-ZW9Z2", @"type": @"日卡"}, @{@"code": @"DAY-1LG22-11BGP", @"type": @"日卡"}, @{@"code": @"DAY-1LKOQ-MPKR2", @"type": @"日卡"}, @{@"code": @"DAY-1ZY8Z-CG4JH", @"type": @"日卡"},
            @{@"code": @"DAY-2FZW3-60L4R", @"type": @"日卡"}, @{@"code": @"DAY-2VYYD-MPGHY", @"type": @"日卡"}, @{@"code": @"DAY-3GNXF-5TGTS", @"type": @"日卡"}, @{@"code": @"DAY-3W00K-QA1MT", @"type": @"日卡"}, @{@"code": @"DAY-4B4MC-OWLI4", @"type": @"日卡"}, @{@"code": @"DAY-4Z9GP-8PLXL", @"type": @"日卡"}, @{@"code": @"DAY-5DPTM-TAIU2", @"type": @"日卡"}, @{@"code": @"DAY-5JE31-8SAK4", @"type": @"日卡"}, @{@"code": @"DAY-5SEEB-BX9PM", @"type": @"日卡"}, @{@"code": @"DAY-6UOXE-LKP92", @"type": @"日卡"},
            @{@"code": @"DAY-6YH0E-LHAQT", @"type": @"日卡"}, @{@"code": @"DAY-769HC-LK9N7", @"type": @"日卡"}, @{@"code": @"DAY-7LBFV-30DHG", @"type": @"日卡"}, @{@"code": @"DAY-7YR53-5P1CN", @"type": @"日卡"}, @{@"code": @"DAY-86PSV-DN1Z6", @"type": @"日卡"}, @{@"code": @"DAY-8NWIO-EADO6", @"type": @"日卡"}, @{@"code": @"DAY-8SPIG-UEE8J", @"type": @"日卡"}, @{@"code": @"DAY-8ZZC3-43IYM", @"type": @"日卡"}, @{@"code": @"DAY-93A2W-Q3CE7", @"type": @"日卡"}, @{@"code": @"DAY-9WQGS-QCOSD", @"type": @"日卡"},
            @{@"code": @"DAY-AFA8W-S1N42", @"type": @"日卡"}, @{@"code": @"DAY-AMU10-NLTKU", @"type": @"日卡"}, @{@"code": @"DAY-AWQPU-FDL9R", @"type": @"日卡"}, @{@"code": @"DAY-BKGQ5-JHHG4", @"type": @"日卡"}, @{@"code": @"DAY-BNW82-2VK4H", @"type": @"日卡"}, @{@"code": @"DAY-BRM6C-YS55W", @"type": @"日卡"}, @{@"code": @"DAY-BSLIW-I8XOI", @"type": @"日卡"}, @{@"code": @"DAY-BZD66-YB0YB", @"type": @"日卡"}, @{@"code": @"DAY-C1U3C-AZHN2", @"type": @"日卡"}, @{@"code": @"DAY-CYPPZ-3U7L7", @"type": @"日卡"},
            @{@"code": @"DAY-D57M6-E0812", @"type": @"日卡"}, @{@"code": @"DAY-DGKMG-DIIQP", @"type": @"日卡"}, @{@"code": @"DAY-DPMG4-ZJ2EY", @"type": @"日卡"}, @{@"code": @"DAY-EM3C8-3T29Y", @"type": @"日卡"}, @{@"code": @"DAY-EZGM2-RR1I1", @"type": @"日卡"}, @{@"code": @"DAY-G26U3-JBLVX", @"type": @"日卡"}, @{@"code": @"DAY-GAEFN-1PA19", @"type": @"日卡"}, @{@"code": @"DAY-GBC7J-P8YDU", @"type": @"日卡"}, @{@"code": @"DAY-GC5ZC-GQGA9", @"type": @"日卡"}, @{@"code": @"DAY-GOWHW-BZHSK", @"type": @"日卡"},
            @{@"code": @"DAY-H1PYO-H2DCJ", @"type": @"日卡"}, @{@"code": @"DAY-H7FZJ-ZKTDF", @"type": @"日卡"}, @{@"code": @"DAY-HB9OD-5HTMJ", @"type": @"日卡"}, @{@"code": @"DAY-HEE3P-RHBEH", @"type": @"日卡"}, @{@"code": @"DAY-HIWY0-L1734", @"type": @"日卡"}, @{@"code": @"DAY-HN913-D6IO7", @"type": @"日卡"}, @{@"code": @"DAY-I8W2V-WRVCI", @"type": @"日卡"}, @{@"code": @"DAY-IP1U0-AOEP4", @"type": @"日卡"}, @{@"code": @"DAY-ITV94-6CCKZ", @"type": @"日卡"}, @{@"code": @"DAY-K0QUB-G1MKC", @"type": @"日卡"},
            @{@"code": @"DAY-L0SHA-NZ6O0", @"type": @"日卡"}, @{@"code": @"DAY-LDKPA-TWL57", @"type": @"日卡"}, @{@"code": @"DAY-LW1I9-0KQ0M", @"type": @"日卡"}, @{@"code": @"DAY-M6GN8-0L094", @"type": @"日卡"}, @{@"code": @"DAY-NNSKL-3D0D7", @"type": @"日卡"}, @{@"code": @"DAY-NWV9C-FHABE", @"type": @"日卡"}, @{@"code": @"DAY-OT794-QGTZN", @"type": @"日卡"}, @{@"code": @"DAY-PAT93-EZ2RQ", @"type": @"日卡"}, @{@"code": @"DAY-QCZVH-QABT6", @"type": @"日卡"}, @{@"code": @"DAY-QYEFM-BR3HD", @"type": @"日卡"},
            @{@"code": @"DAY-R1F25-DXOWK", @"type": @"日卡"}, @{@"code": @"DAY-R88L3-MH4LD", @"type": @"日卡"}, @{@"code": @"DAY-RFQ5U-SNNM5", @"type": @"日卡"}, @{@"code": @"DAY-RM3IA-MWW95", @"type": @"日卡"}, @{@"code": @"DAY-S86HY-16RH2", @"type": @"日卡"}, @{@"code": @"DAY-S9G7E-JPKUK", @"type": @"日卡"}, @{@"code": @"DAY-SAMQ4-J9SVU", @"type": @"日卡"}, @{@"code": @"DAY-SDNS8-AFQ2Z", @"type": @"日卡"}, @{@"code": @"DAY-SI3OE-P8I7X", @"type": @"日卡"}, @{@"code": @"DAY-SMV73-WGP98", @"type": @"日卡"},
            @{@"code": @"DAY-SP64Q-QPOG4", @"type": @"日卡"}, @{@"code": @"DAY-SSTT7-671YZ", @"type": @"日卡"}, @{@"code": @"DAY-TC1T3-SH9CA", @"type": @"日卡"}, @{@"code": @"DAY-TH7EV-32SP5", @"type": @"日卡"}, @{@"code": @"DAY-TLHXB-OQ4XN", @"type": @"日卡"}, @{@"code": @"DAY-TMTAF-2J7FT", @"type": @"日卡"}, @{@"code": @"DAY-UDWUI-ME32O", @"type": @"日卡"}, @{@"code": @"DAY-V0PTR-02OP2", @"type": @"日卡"}, @{@"code": @"DAY-V43TR-AKOXA", @"type": @"日卡"}, @{@"code": @"DAY-V6TE3-DLF3W", @"type": @"日卡"},
            @{@"code": @"DAY-V9IR8-FO6LP", @"type": @"日卡"}, @{@"code": @"DAY-VL4WG-OXZ44", @"type": @"日卡"}, @{@"code": @"DAY-WCQ4V-48923", @"type": @"日卡"}, @{@"code": @"DAY-WDPJH-2JVHU", @"type": @"日卡"}, @{@"code": @"DAY-XN4SI-F5JS4", @"type": @"日卡"}, @{@"code": @"DAY-Y0TB1-WSL0U", @"type": @"日卡"}, @{@"code": @"DAY-YSES8-KDSUI", @"type": @"日卡"}, @{@"code": @"DAY-Z3UU3-1D2UB", @"type": @"日卡"}, @{@"code": @"DAY-Z71BF-2T29M", @"type": @"日卡"}, @{@"code": @"DAY-ZMDDZ-SSJFM", @"type": @"日卡"},

            // ===== 星欲少女 月卡 (100) =====
            @{@"code": @"MON-04SOM-SSBJZ", @"type": @"月卡"}, @{@"code": @"MON-09I2O-PUFWG", @"type": @"月卡"}, @{@"code": @"MON-0FIUU-DUYVB", @"type": @"月卡"}, @{@"code": @"MON-0NF4D-KLFYB", @"type": @"月卡"}, @{@"code": @"MON-0RFI2-DGE1E", @"type": @"月卡"}, @{@"code": @"MON-2AJ1G-K016Z", @"type": @"月卡"}, @{@"code": @"MON-2BFZY-EI4JP", @"type": @"月卡"}, @{@"code": @"MON-2EE1U-TI1PC", @"type": @"月卡"}, @{@"code": @"MON-2G4ER-UVF9N", @"type": @"月卡"}, @{@"code": @"MON-2QR4K-VQS9I", @"type": @"月卡"},
            @{@"code": @"MON-2RK7G-O5PAY", @"type": @"月卡"}, @{@"code": @"MON-3XYJS-PBN37", @"type": @"月卡"}, @{@"code": @"MON-4910G-3CN6Q", @"type": @"月卡"}, @{@"code": @"MON-5446W-SCC6Q", @"type": @"月卡"}, @{@"code": @"MON-5OG51-EU0QU", @"type": @"月卡"}, @{@"code": @"MON-5P6IL-ZMSKT", @"type": @"月卡"}, @{@"code": @"MON-61IOP-PX1K3", @"type": @"月卡"}, @{@"code": @"MON-61RS4-ALPSB", @"type": @"月卡"}, @{@"code": @"MON-69LN4-96WDW", @"type": @"月卡"}, @{@"code": @"MON-6L2IS-L1FU5", @"type": @"月卡"},
            @{@"code": @"MON-6V6YU-91OGD", @"type": @"月卡"}, @{@"code": @"MON-75CZY-B8D2Z", @"type": @"月卡"}, @{@"code": @"MON-7GT0O-75VAJ", @"type": @"月卡"}, @{@"code": @"MON-7IDMT-XZ8KC", @"type": @"月卡"}, @{@"code": @"MON-7P7PS-CDZNB", @"type": @"月卡"}, @{@"code": @"MON-80QHS-YBRP7", @"type": @"月卡"}, @{@"code": @"MON-8CKN9-G85NA", @"type": @"月卡"}, @{@"code": @"MON-8J4KB-QH3YR", @"type": @"月卡"}, @{@"code": @"MON-9EG0Z-C040S", @"type": @"月卡"}, @{@"code": @"MON-A2JN4-DLDOX", @"type": @"月卡"},
            @{@"code": @"MON-B9OEM-ZZJGX", @"type": @"月卡"}, @{@"code": @"MON-BRFYZ-8A78V", @"type": @"月卡"}, @{@"code": @"MON-BUCS2-USY9W", @"type": @"月卡"}, @{@"code": @"MON-BWZ5Z-D2OTY", @"type": @"月卡"}, @{@"code": @"MON-C2DY6-F5LZT", @"type": @"月卡"}, @{@"code": @"MON-CFA5O-13CIO", @"type": @"月卡"}, @{@"code": @"MON-CMUQ0-EU4KB", @"type": @"月卡"}, @{@"code": @"MON-CSAPG-XLHML", @"type": @"月卡"}, @{@"code": @"MON-DBBZO-I23Q7", @"type": @"月卡"}, @{@"code": @"MON-DJ2RD-0Z7FT", @"type": @"月卡"},
            @{@"code": @"MON-DJKOP-6UG1D", @"type": @"月卡"}, @{@"code": @"MON-EM3SC-XBV56", @"type": @"月卡"}, @{@"code": @"MON-F1V6P-9K62R", @"type": @"月卡"}, @{@"code": @"MON-FXVRO-JH9VF", @"type": @"月卡"}, @{@"code": @"MON-GBBOH-V1A8G", @"type": @"月卡"}, @{@"code": @"MON-GIBPE-TGVY4", @"type": @"月卡"}, @{@"code": @"MON-GIGPV-7D9PT", @"type": @"月卡"}, @{@"code": @"MON-GZLIJ-U49MK", @"type": @"月卡"}, @{@"code": @"MON-H97QR-KPUHZ", @"type": @"月卡"}, @{@"code": @"MON-HHPRS-5UPXI", @"type": @"月卡"},
            @{@"code": @"MON-HLH65-5DBP5", @"type": @"月卡"}, @{@"code": @"MON-HPRKO-52KC4", @"type": @"月卡"}, @{@"code": @"MON-HWBHD-KXJVG", @"type": @"月卡"}, @{@"code": @"MON-I0HX1-XHRZL", @"type": @"月卡"}, @{@"code": @"MON-I6476-GSU4K", @"type": @"月卡"}, @{@"code": @"MON-IJ52T-88WUX", @"type": @"月卡"}, @{@"code": @"MON-JF6IG-A4GS8", @"type": @"月卡"}, @{@"code": @"MON-JGG3R-W3H34", @"type": @"月卡"}, @{@"code": @"MON-JK8GC-MGYK6", @"type": @"月卡"}, @{@"code": @"MON-JT0V2-SBOCC", @"type": @"月卡"},
            @{@"code": @"MON-K174U-PK1NP", @"type": @"月卡"}, @{@"code": @"MON-KBKJI-JSM0I", @"type": @"月卡"}, @{@"code": @"MON-KE61H-JM0E3", @"type": @"月卡"}, @{@"code": @"MON-KFY45-C6OHD", @"type": @"月卡"}, @{@"code": @"MON-KKXR5-O29M7", @"type": @"月卡"}, @{@"code": @"MON-L53S1-WN0GW", @"type": @"月卡"}, @{@"code": @"MON-LTIJO-L7BMA", @"type": @"月卡"}, @{@"code": @"MON-M0KVS-CD3HQ", @"type": @"月卡"}, @{@"code": @"MON-MDEGR-RKWXE", @"type": @"月卡"}, @{@"code": @"MON-MQXSD-O8865", @"type": @"月卡"},
            @{@"code": @"MON-MRHGK-OG95I", @"type": @"月卡"}, @{@"code": @"MON-NQ3N1-XYH0N", @"type": @"月卡"}, @{@"code": @"MON-O6HLZ-SZABY", @"type": @"月卡"}, @{@"code": @"MON-OS84L-KL94W", @"type": @"月卡"}, @{@"code": @"MON-OSBNW-0STZM", @"type": @"月卡"}, @{@"code": @"MON-OWKMC-NUKMY", @"type": @"月卡"}, @{@"code": @"MON-OYS6G-P57BJ", @"type": @"月卡"}, @{@"code": @"MON-P0FMA-OHJWM", @"type": @"月卡"}, @{@"code": @"MON-P516H-EBVKC", @"type": @"月卡"}, @{@"code": @"MON-P8YD2-D58Q7", @"type": @"月卡"},
            @{@"code": @"MON-PFGGC-G8APJ", @"type": @"月卡"}, @{@"code": @"MON-PVDNW-93O0G", @"type": @"月卡"}, @{@"code": @"MON-QAC4J-02F5P", @"type": @"月卡"}, @{@"code": @"MON-QKQFU-QRJOI", @"type": @"月卡"}, @{@"code": @"MON-QU4AR-WEI0W", @"type": @"月卡"}, @{@"code": @"MON-R928E-CAAXC", @"type": @"月卡"}, @{@"code": @"MON-RSHHP-2RH56", @"type": @"月卡"}, @{@"code": @"MON-RYU42-KN37J", @"type": @"月卡"}, @{@"code": @"MON-SCCHE-COWLQ", @"type": @"月卡"}, @{@"code": @"MON-SMFRU-ACYMJ", @"type": @"月卡"},
            @{@"code": @"MON-SNKGN-EU99G", @"type": @"月卡"}, @{@"code": @"MON-SXB9Z-KDVB7", @"type": @"月卡"}, @{@"code": @"MON-SYV74-46BC1", @"type": @"月卡"}, @{@"code": @"MON-U59ZT-DM07D", @"type": @"月卡"}, @{@"code": @"MON-UHC5U-YDLQF", @"type": @"月卡"}, @{@"code": @"MON-VOLG0-GKOGX", @"type": @"月卡"}, @{@"code": @"MON-W9N6V-35BOL", @"type": @"月卡"}, @{@"code": @"MON-WAYHC-R2B6T", @"type": @"月卡"}, @{@"code": @"MON-X647P-Q9PLR", @"type": @"月卡"}, @{@"code": @"MON-YKKL9-PVHP0", @"type": @"月卡"},

            // ===== 星欲少女 永久卡 (100) =====
            @{@"code": @"PER-0AVW4-KRYF8", @"type": @"永久卡"}, @{@"code": @"PER-0KPG1-9EXOF", @"type": @"永久卡"}, @{@"code": @"PER-1HK6F-L6FPY", @"type": @"永久卡"}, @{@"code": @"PER-1JXH0-G1N28", @"type": @"永久卡"}, @{@"code": @"PER-2989F-D6698", @"type": @"永久卡"}, @{@"code": @"PER-2I0KC-22JG9", @"type": @"永久卡"}, @{@"code": @"PER-3YY40-50Z99", @"type": @"永久卡"}, @{@"code": @"PER-4O0CX-MTRSV", @"type": @"永久卡"}, @{@"code": @"PER-55862-O189R", @"type": @"永久卡"}, @{@"code": @"PER-5HCPF-2QPYT", @"type": @"永久卡"},
            @{@"code": @"PER-615PA-GRXFY", @"type": @"永久卡"}, @{@"code": @"PER-6E661-DN008", @"type": @"永久卡"}, @{@"code": @"PER-6RT5K-SY959", @"type": @"永久卡"}, @{@"code": @"PER-6ZYHE-R9HS1", @"type": @"永久卡"}, @{@"code": @"PER-70TQZ-UQDBH", @"type": @"永久卡"}, @{@"code": @"PER-71XM2-INFGL", @"type": @"永久卡"}, @{@"code": @"PER-7CV6K-GMN0K", @"type": @"永久卡"}, @{@"code": @"PER-7NIZ2-LORYH", @"type": @"永久卡"}, @{@"code": @"PER-820A7-YB5HX", @"type": @"永久卡"}, @{@"code": @"PER-8AS5F-53W1E", @"type": @"永久卡"},
            @{@"code": @"PER-8VU79-YTAGX", @"type": @"永久卡"}, @{@"code": @"PER-8Z9VL-4EX76", @"type": @"永久卡"}, @{@"code": @"PER-AFQ6L-RQKSQ", @"type": @"永久卡"}, @{@"code": @"PER-B0FX3-R85PU", @"type": @"永久卡"}, @{@"code": @"PER-BBMB4-3109S", @"type": @"永久卡"}, @{@"code": @"PER-BGHKA-XONCZ", @"type": @"永久卡"}, @{@"code": @"PER-BH8LT-5ON81", @"type": @"永久卡"}, @{@"code": @"PER-BL4K5-REN8B", @"type": @"永久卡"}, @{@"code": @"PER-CNKQQ-HJW8F", @"type": @"永久卡"}, @{@"code": @"PER-DE84V-G54KW", @"type": @"永久卡"},
            @{@"code": @"PER-E3N9V-D3SZ0", @"type": @"永久卡"}, @{@"code": @"PER-EDJDV-492HS", @"type": @"永久卡"}, @{@"code": @"PER-ELNUO-X1OQ3", @"type": @"永久卡"}, @{@"code": @"PER-EUC63-H7QOD", @"type": @"永久卡"}, @{@"code": @"PER-F2C7U-IXQ6M", @"type": @"永久卡"}, @{@"code": @"PER-F7I39-E4OAT", @"type": @"永久卡"}, @{@"code": @"PER-FY34V-PNGKZ", @"type": @"永久卡"}, @{@"code": @"PER-G1LY5-V3ORH", @"type": @"永久卡"}, @{@"code": @"PER-GCVG5-W43EU", @"type": @"永久卡"}, @{@"code": @"PER-GEDDG-SSF6B", @"type": @"永久卡"},
            @{@"code": @"PER-H28E5-8E7B8", @"type": @"永久卡"}, @{@"code": @"PER-H3YZ5-D1IFK", @"type": @"永久卡"}, @{@"code": @"PER-HSRNL-O8T4V", @"type": @"永久卡"}, @{@"code": @"PER-HSZF8-XT7JB", @"type": @"永久卡"}, @{@"code": @"PER-I1NC7-C78XV", @"type": @"永久卡"}, @{@"code": @"PER-IFDBN-TSJRI", @"type": @"永久卡"}, @{@"code": @"PER-IPVCM-J3ZJS", @"type": @"永久卡"}, @{@"code": @"PER-IW505-ITY8G", @"type": @"永久卡"}, @{@"code": @"PER-J1G26-X2LBY", @"type": @"永久卡"}, @{@"code": @"PER-JAKWM-4SQMX", @"type": @"永久卡"},
            @{@"code": @"PER-JQ3HV-BFQ60", @"type": @"永久卡"}, @{@"code": @"PER-KQXMX-M9OYA", @"type": @"永久卡"}, @{@"code": @"PER-LFR0D-SPV3A", @"type": @"永久卡"}, @{@"code": @"PER-LHR8W-4XK05", @"type": @"永久卡"}, @{@"code": @"PER-LNVX3-39X2G", @"type": @"永久卡"}, @{@"code": @"PER-M05FV-KZURA", @"type": @"永久卡"}, @{@"code": @"PER-MEHX6-UZ0LV", @"type": @"永久卡"}, @{@"code": @"PER-NC507-LT0R8", @"type": @"永久卡"}, @{@"code": @"PER-NV1DS-RU82U", @"type": @"永久卡"}, @{@"code": @"PER-OMURC-7CYHT", @"type": @"永久卡"},
            @{@"code": @"PER-ONGDQ-GBEU6", @"type": @"永久卡"}, @{@"code": @"PER-ORH8V-650DZ", @"type": @"永久卡"}, @{@"code": @"PER-P3827-H2X5T", @"type": @"永久卡"}, @{@"code": @"PER-P9DN4-6RGJA", @"type": @"永久卡"}, @{@"code": @"PER-PII9C-NWNNA", @"type": @"永久卡"}, @{@"code": @"PER-QVEF9-95B7V", @"type": @"永久卡"}, @{@"code": @"PER-QXKUO-0MZLT", @"type": @"永久卡"}, @{@"code": @"PER-R2SDS-6YBKR", @"type": @"永久卡"}, @{@"code": @"PER-R5VO4-K83BT", @"type": @"永久卡"}, @{@"code": @"PER-RAL1J-0B8TU", @"type": @"永久卡"},
            @{@"code": @"PER-RM6CI-ZGCN0", @"type": @"永久卡"}, @{@"code": @"PER-RVLDY-7NMY7", @"type": @"永久卡"}, @{@"code": @"PER-S4XSB-X9GSS", @"type": @"永久卡"}, @{@"code": @"PER-STCXP-KVIOJ", @"type": @"永久卡"}, @{@"code": @"PER-STQL3-MA99J", @"type": @"永久卡"}, @{@"code": @"PER-SUXO1-JS3UA", @"type": @"永久卡"}, @{@"code": @"PER-TPVGM-HKZEN", @"type": @"永久卡"}, @{@"code": @"PER-U6ZKY-X4VDI", @"type": @"永久卡"}, @{@"code": @"PER-U7MEM-DSJFG", @"type": @"永久卡"}, @{@"code": @"PER-UFGEZ-QHDG8", @"type": @"永久卡"},
            @{@"code": @"PER-UFWR3-3HWOA", @"type": @"永久卡"}, @{@"code": @"PER-UMIJZ-TUTWF", @"type": @"永久卡"}, @{@"code": @"PER-UNAN8-GG2VD", @"type": @"永久卡"}, @{@"code": @"PER-V29CE-ZH2OA", @"type": @"永久卡"}, @{@"code": @"PER-VEGA8-ET6Y5", @"type": @"永久卡"}, @{@"code": @"PER-VGERT-D45YE", @"type": @"永久卡"}, @{@"code": @"PER-VKGAD-0Z1KF", @"type": @"永久卡"}, @{@"code": @"PER-W8SKK-JIZIX", @"type": @"永久卡"}, @{@"code": @"PER-WERVC-TKZ0I", @"type": @"永久卡"}, @{@"code": @"PER-WLGI2-VZQNT", @"type": @"永久卡"},
            @{@"code": @"PER-WS263-VWNCU", @"type": @"永久卡"}, @{@"code": @"PER-X51RG-ZH0FL", @"type": @"永久卡"}, @{@"code": @"PER-Y6Q3Z-4HOXU", @"type": @"永久卡"}, @{@"code": @"PER-Y7NCA-QPYXC", @"type": @"永久卡"}, @{@"code": @"PER-YPFSF-R1311", @"type": @"永久卡"}, @{@"code": @"PER-YSC2E-QRXVH", @"type": @"永久卡"}, @{@"code": @"PER-YWG29-6JT1A", @"type": @"永久卡"}, @{@"code": @"PER-ZNXWS-NW0FI", @"type": @"永久卡"}, @{@"code": @"PER-ZT6J0-L6U1A", @"type": @"永久卡"}, @{@"code": @"PER-ZU4NT-1WRNZ", @"type": @"永久卡"}
        ];
    });
    return database;
}

@interface AuthManager : NSObject
+ (instancetype)sharedInstance;
- (void)checkAndLoad;
@end

@implementation AuthManager

+ (instancetype)sharedInstance {
    static AuthManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{ instance = [[AuthManager alloc] init]; });
    return instance;
}

- (void)checkAndLoad {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *activeCode = [defaults objectForKey:kKeyActiveCode];
    NSString *activeDevice = [defaults objectForKey:kKeyActiveDevice];
    NSTimeInterval activationTime = [defaults doubleForKey:kKeyActivationTime];
    NSString *codeType = [defaults objectForKey:kKeyCodeType];
    
    NSString *currentDevice = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    BOOL isValid = NO;
    
    if (activeCode && [activeDevice isEqualToString:currentDevice]) {
        NSTimeInterval now = [[NSDate date] timeIntervalSince1970];
        NSTimeInterval elapsed = now - activationTime;
        if ([codeType isEqualToString:@"永久卡"]) isValid = YES;
        else if ([codeType isEqualToString:@"日卡"]) isValid = (elapsed < 24 * 3600);
        else if ([codeType isEqualToString:@"月卡"]) isValid = (elapsed < 30 * 24 * 3600);
    }
    
    if (isValid) {
        [self loadTargetDylib];
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{ [self showAuthUI]; });
    }
}

- (void)loadTargetDylib {
    // 针对星欲少女：加载 libStarlust.dylib
    NSString *bundlePath = [[NSBundle mainBundle] bundlePath];
    NSString *dylibPath = [bundlePath stringByAppendingPathComponent:@"Frameworks/libStarlust.dylib"];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:dylibPath]) { 
        NSLog(@"[Auth] 找不到目标: %@", dylibPath);
        return; 
    }
    dlopen([dylibPath UTF8String], RTLD_NOW);
}

- (void)showAuthUI {
    UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    if (!rootVC) return;
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"授权验证" message:@"请输入您的激活码以启动游戏" preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) { textField.placeholder = @"粘贴或输入激活码"; }];
    
    UIAlertAction *activateAction = [UIAlertAction actionWithTitle:@"激活" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) { 
        [self verifyCode:alert.textFields.firstObject.text]; 
    }];
    
    UIAlertAction *exitAction = [UIAlertAction actionWithTitle:@"退出游戏" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) { 
        exit(0); 
    }];
    
    [alert addAction:activateAction];
    [alert addAction:exitAction];
    [rootVC presentViewController:alert animated:YES completion:nil];
}

- (void)verifyCode:(NSString *)code {
    NSArray *codesArray = getAuthDatabase();
    BOOL codeFound = NO;
    NSString *cardType = nil;
    NSString *cleanCode = [[code stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    for (NSDictionary *dict in codesArray) {
        if ([dict[@"code"] isEqualToString:cleanCode]) { codeFound = YES; cardType = dict[@"type"]; break; }
    }
    
    if (!codeFound) { 
        [self showErrorAndKill:@"激活码无效，请检查输入"]; 
        return; 
    }
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *savedDevice = [defaults objectForKey:[NSString stringWithFormat:@"Device_%@", cleanCode]];
    NSString *currentDevice = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    if (savedDevice && ![savedDevice isEqualToString:currentDevice]) { 
        [self showErrorAndKill:@"该激活码已在其他设备绑定，无法跨设备使用"]; 
        return; 
    }
    
    [defaults setObject:cleanCode forKey:kKeyActiveCode];
    [defaults setObject:currentDevice forKey:kKeyActiveDevice];
    [defaults setObject:@([[NSDate date] timeIntervalSince1970]) forKey:kKeyActivationTime];
    [defaults setObject:cardType forKey:kKeyCodeType];
    [defaults setObject:currentDevice forKey:[NSString stringWithFormat:@"Device_%@", cleanCode]];
    [defaults synchronize];
    
    [self loadTargetDylib];
    
    UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    [rootVC dismissViewControllerAnimated:YES completion:^{ 
        UIAlertController *successAlert = [UIAlertController alertControllerWithTitle:@"成功" message:@"授权成功，祝您游戏愉快！" preferredStyle:UIAlertControllerStyleAlert];
        [successAlert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
        [rootVC presentViewController:successAlert animated:YES completion:nil];
    }];
}

- (void)showErrorAndKill:(NSString *)message {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
        [rootVC dismissViewControllerAnimated:YES completion:nil]; 
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"错误" message:message preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"退出" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) { 
            exit(0); 
        }]];
        [rootVC presentViewController:alert animated:YES completion:nil];
    });
}

@end

__attribute__((constructor)) static void initPlugin() {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[AuthManager sharedInstance] checkAndLoad];
    });
}
