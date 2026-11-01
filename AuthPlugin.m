#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <Security/Security.h>
#import <objc/runtime.h>

#pragma mark - 1. 配置区

// 修改为你自己 App 中需要隐藏的弹窗类名
static NSString * const kProtectedPopupClassName = @"YourPopupViewController";

// 本地授权状态
static NSString * const kAuthActivatedKey = @"AuthPluginActivated";
static NSString * const kAuthCodeKey = @"AuthPluginCode";

#pragma mark - 2. 激活码数据

// 将你的 300 条激活码放在这里。
// 格式：@{@"激活码": @"DAY"}, @{@"激活码": @"MON"}, @{@"激活码": @"PER"}
static NSDictionary<NSString *, NSString *> *AuthCodes(void) {
    static NSDictionary *codes = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        codes = @{
            // 在这里粘贴你的 300 条激活码映射
            // @"你的日卡激活码": @"DAY",
            // @"你的月卡激活码": @"MON",
            // @"你的永久激活码": @"PER",
        };
    });
    return codes;
}

#pragma mark - 3. 激活状态

static BOOL IsActivated(void) {
    return [[NSUserDefaults standardUserDefaults] boolForKey:kAuthActivatedKey];
}

static void SaveActivation(NSString *code) {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:YES forKey:kAuthActivatedKey];
    [defaults setObject:code forKey:kAuthCodeKey];
    [defaults synchronize];
}

#pragma mark - 4. 激活码校验

static BOOL ValidateCode(NSString *code) {
    if (code.length == 0) return NO;

    NSString *type = AuthCodes()[code];
    if (type == nil) return NO;

    // 本示例只检查激活码是否存在。
    // DAY / MON 的有效期应由你自己的授权规则决定。
    // PER 表示永久授权。
    return YES;
}

#pragma mark - 5. 授权界面

@interface AuthPluginController : UIViewController
@property (nonatomic, copy) void (^successHandler)(void);
@end

@implementation AuthPluginController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.88];

    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(25, 100,
        self.view.bounds.size.width - 50, 40)];
    title.text = @"授权验证";
    title.textColor = UIColor.whiteColor;
    title.textAlignment = NSTextAlignmentCenter;
    title.font = [UIFont boldSystemFontOfSize:24];
    [self.view addSubview:title];

    UIButton *activate = [UIButton buttonWithType:UIButtonTypeSystem];
    activate.frame = CGRectMake(40, 190, self.view.bounds.size.width - 80, 48);
    [activate setTitle:@"激活" forState:UIControlStateNormal];
    [activate setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    activate.backgroundColor = [UIColor systemBlueColor];
    activate.layer.cornerRadius = 8;
    [activate addTarget:self action:@selector(inputCode)
       forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:activate];

    UIButton *skip = [UIButton buttonWithType:UIButtonTypeSystem];
    skip.frame = CGRectMake(40, 255, self.view.bounds.size.width - 80, 48);
    [skip setTitle:@"不使用辅助" forState:UIControlStateNormal];
    [skip setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [skip addTarget:self action:@selector(skipAuth)
       forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:skip];
}

- (void)inputCode {
    UIAlertController *alert =
    [UIAlertController alertControllerWithTitle:@"输入激活码"
        message:nil
        preferredStyle:UIAlertControllerStyleAlert];

    [alert addTextFieldWithConfigurationHandler:^(UITextField *field) {
        field.placeholder = @"请输入激活码";
        field.autocapitalizationType = UITextAutocapitalizationTypeAllCharacters;
    }];

    __weak typeof(self) weakSelf = self;

    [alert addAction:[UIAlertAction actionWithTitle:@"确认"
        style:UIAlertActionStyleDefault
        handler:^(UIAlertAction *action) {

        NSString *code = alert.textFields.firstObject.text ?: @"";

        if (ValidateCode(code)) {
            SaveActivation(code);

            UIAlertController *success =
            [UIAlertController alertControllerWithTitle:@"激活成功"
                message:@"授权验证通过"
                preferredStyle:UIAlertControllerStyleAlert];

            [success addAction:[UIAlertAction actionWithTitle:@"确定"
                style:UIAlertActionStyleDefault
                handler:^(UIAlertAction *a) {
                    if (weakSelf.successHandler) {
                        weakSelf.successHandler();
                    }
                }]];

            [weakSelf presentViewController:success animated:YES completion:nil];
        } else {
            [weakSelf showInvalidCode];
        }
    }]];

    [alert addAction:[UIAlertAction actionWithTitle:@"取消"
        style:UIAlertActionStyleCancel handler:nil]];

    [self presentViewController:alert animated:YES completion:nil];
}

- (void)showInvalidCode {
    UIAlertController *alert =
    [UIAlertController alertControllerWithTitle:@"激活码错误"
        message:@"请检查激活码后重试"
        preferredStyle:UIAlertControllerStyleAlert];

    __weak typeof(self) weakSelf = self;

    [alert addAction:[UIAlertAction actionWithTitle:@"重新输入"
        style:UIAlertActionStyleDefault
        handler:^(UIAlertAction *action) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW,
                (int64_t)(0.35 * NSEC_PER_SEC)),
                dispatch_get_main_queue(), ^{
                    [weakSelf inputCode];
                });
        }]];

    [alert addAction:[UIAlertAction actionWithTitle:@"不使用辅助"
        style:UIAlertActionStyleCancel handler:nil]];

    [self presentViewController:alert animated:YES completion:nil];
}

- (void)skipAuth {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end

#pragma mark - 6. 弹窗显示控制

static void PresentAuth(UIViewController *presenter,
                        UIViewController *protectedPopup) {
    if (presenter == nil || protectedPopup == nil) {
        return;
    }

    AuthPluginController *auth = [AuthPluginController new];

    __weak UIViewController *weakPopup = protectedPopup;

    auth.successHandler = ^{
        weakPopup.view.hidden = NO;
    };

    [presenter presentViewController:auth animated:YES completion:nil];
}

#pragma mark - 7. 启动入口

__attribute__((constructor))
static void AuthPluginInit(void) {
    dispatch_async(dispatch_get_main_queue(), ^{
        // 此处只初始化插件。
        // 你需要在自己的 App 弹窗创建位置调用 PresentAuth，
        // 并把目标弹窗实例传入。
    });
}
