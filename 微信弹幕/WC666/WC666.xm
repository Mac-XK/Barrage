// See http://iphonedevwiki.net/index.php/Logos

#if TARGET_OS_SIMULATOR
#error Do not support the simulator, please use the real iPhone Device.
#endif

#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import <QuartzCore/QuartzCore.h>

// --- 前向声明 ---
@class DanmakuManager;

@interface CMessageWrap : NSObject
@property (nonatomic, strong) NSString *m_nsContent;
@property (nonatomic) unsigned int m_uiCreateTime;
@property (nonatomic) unsigned int m_uiMessageType;
@end

@interface BaseMsgContentViewController : UIViewController
@property (nonatomic, readonly) CMessageWrap *m_msgWrap;
@end

@interface RichTextView : UIView
@end

@interface WCInputController : NSObject
- (void)textDidChange:(id)arg1;
- (NSString *)text;
@end

// 弹幕视图类
@interface DanmakuView : UIView
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, assign) CGFloat speed;
@property (nonatomic, assign) BOOL isAnimated; // 是否使用动画效果
@property (nonatomic, assign) NSInteger effectType; // 特效类型
+ (instancetype)danmakuWithContent:(NSString *)content;
- (void)start;
- (void)applySpecialEffect;
@end

@implementation DanmakuView

+ (instancetype)danmakuWithContent:(NSString *)content {
    DanmakuView *danmaku = [[DanmakuView alloc] init];
    danmaku.contentLabel.text = content;
    
    // 随机决定是否使用动画效果
    danmaku.isAnimated = (arc4random() % 100) < 30; // 30%概率使用动画
    danmaku.effectType = arc4random() % 5; // 随机特效类型
    
    return danmaku;
}

- (instancetype)init {
    if (self = [super init]) {
        _speed = 2.0 + (arc4random() % 5); // 更多速度变化
        
        self.contentLabel = [[UILabel alloc] init];
        self.contentLabel.font = [UIFont boldSystemFontOfSize:18 + (arc4random() % 14)]; // 18-32 随机字体大小
        self.contentLabel.textColor = [self randomColor]; // 随机颜色
        
        // 随机决定是否使用描边效果
        if ((arc4random() % 100) < 40) { // 40%概率使用描边
            self.contentLabel.layer.shadowColor = [UIColor blackColor].CGColor;
            self.contentLabel.layer.shadowOffset = CGSizeMake(1.0, 1.0);
            self.contentLabel.layer.shadowRadius = 1.0;
            self.contentLabel.layer.shadowOpacity = 0.8;
        }
        
        [self addSubview:self.contentLabel];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.contentLabel sizeToFit];
    self.contentLabel.frame = CGRectMake(0, 0, self.contentLabel.frame.size.width, self.contentLabel.frame.size.height);
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.contentLabel.frame.size.width, self.contentLabel.frame.size.height);
}

- (UIColor *)randomColor {
    NSArray *colors = @[
        [UIColor redColor],
        [UIColor greenColor],
        [UIColor blueColor],
        [UIColor yellowColor],
        [UIColor purpleColor],
        [UIColor orangeColor],
        [UIColor cyanColor],
        [UIColor magentaColor],
        [UIColor brownColor],
        [UIColor colorWithRed:1.0 green:0.5 blue:0.0 alpha:1.0], // 橙红色
        [UIColor colorWithRed:0.5 green:0.0 blue:0.5 alpha:1.0], // 深紫色
        [UIColor colorWithRed:0.0 green:0.5 blue:0.5 alpha:1.0], // 青绿色
        [UIColor colorWithRed:1.0 green:0.8 blue:0.0 alpha:1.0]  // 金黄色
    ];
    return colors[arc4random() % colors.count];
}

- (void)start {
    UIWindow *window = nil;
    if (@available(iOS 13.0, *)) {
        for (UIWindowScene *windowScene in [UIApplication sharedApplication].connectedScenes) {
            if (windowScene.activationState == UISceneActivationStateForegroundActive) {
                window = windowScene.windows.firstObject;
                break;
            }
        }
    }
    
    if (!window) {
        #pragma clang diagnostic push
        #pragma clang diagnostic ignored "-Wdeprecated-declarations"
        window = [UIApplication sharedApplication].keyWindow;
        #pragma clang diagnostic pop
    }
    
    if (!window) return;

    CGFloat screenWidth = window.bounds.size.width;
    CGFloat screenHeight = window.bounds.size.height;
    
    // 随机高度位置，更广范围
    CGFloat randomY = (arc4random() % (int)(screenHeight * 0.8)) + 40;
    
    // 设置初始位置（屏幕右侧外）
    self.frame = CGRectMake(screenWidth, randomY, self.frame.size.width, self.frame.size.height);
    [window addSubview:self];
    
    // 应用特殊效果
    if (self.isAnimated) {
        [self applySpecialEffect];
    }
    
    // 动画移动到屏幕左侧外
    [UIView animateWithDuration:screenWidth / (40.0 * self.speed) delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.frame = CGRectMake(-self.frame.size.width, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)applySpecialEffect {
    switch (self.effectType) {
        case 0: // 缩放效果
            [self addScaleAnimation];
            break;
        case 1: // 旋转效果
            [self addRotationAnimation];
            break;
        case 2: // 透明度闪烁
            [self addBlinkAnimation];
            break;
        case 3: // 上下浮动
            [self addFloatAnimation];
            break;
        case 4: // 彩虹色变换
            [self addColorChangeAnimation];
            break;
        default:
            break;
    }
}

- (void)addScaleAnimation {
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = @(0.8);
    scaleAnimation.toValue = @(1.2);
    scaleAnimation.duration = 0.5;
    scaleAnimation.autoreverses = YES;
    scaleAnimation.repeatCount = HUGE_VALF;
    [self.layer addAnimation:scaleAnimation forKey:@"scaleAnimation"];
}

- (void)addRotationAnimation {
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    rotationAnimation.fromValue = @(0);
    rotationAnimation.toValue = @(M_PI * 0.1); // 轻微旋转
    rotationAnimation.duration = 0.3;
    rotationAnimation.autoreverses = YES;
    rotationAnimation.repeatCount = HUGE_VALF;
    [self.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

- (void)addBlinkAnimation {
    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.fromValue = @(1.0);
    opacityAnimation.toValue = @(0.6);
    opacityAnimation.duration = 0.3;
    opacityAnimation.autoreverses = YES;
    opacityAnimation.repeatCount = HUGE_VALF;
    [self.layer addAnimation:opacityAnimation forKey:@"opacityAnimation"];
}

- (void)addFloatAnimation {
    CABasicAnimation *positionAnimation = [CABasicAnimation animationWithKeyPath:@"position.y"];
    positionAnimation.fromValue = @(self.layer.position.y - 5);
    positionAnimation.toValue = @(self.layer.position.y + 5);
    positionAnimation.duration = 0.5;
    positionAnimation.autoreverses = YES;
    positionAnimation.repeatCount = HUGE_VALF;
    [self.layer addAnimation:positionAnimation forKey:@"positionAnimation"];
}

- (void)addColorChangeAnimation {
    // 创建一个定时器来改变文本颜色
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 0.3 * NSEC_PER_SEC, 0.1 * NSEC_PER_SEC);
    
    __weak typeof(self) weakSelf = self;
    dispatch_source_set_event_handler(timer, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            if (weakSelf && weakSelf.contentLabel) {
                weakSelf.contentLabel.textColor = [weakSelf randomColor];
            } else {
                dispatch_source_cancel(timer);
            }
        });
    });
    dispatch_resume(timer);
    
    // 保存定时器引用
    static char timerKey;
    objc_setAssociatedObject(self, &timerKey, timer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)removeFromSuperview {
    // 取消定时器
    static char timerKey;
    dispatch_source_t timer = objc_getAssociatedObject(self, &timerKey);
    if (timer) {
        dispatch_source_cancel(timer);
    }
    
    [super removeFromSuperview];
}

@end

// 弹幕管理类
@interface DanmakuManager : NSObject
+ (instancetype)sharedInstance;
- (void)showDanmakuWithContent:(NSString *)content;
- (void)checkAndShowDanmakuForText:(NSString *)text;
@end

@implementation DanmakuManager

+ (instancetype)sharedInstance {
    static DanmakuManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[DanmakuManager alloc] init];
    });
    return instance;
}

- (void)showDanmakuWithContent:(NSString *)content {
    dispatch_async(dispatch_get_main_queue(), ^{
        DanmakuView *danmaku = [DanmakuView danmakuWithContent:content];
        [danmaku start];
    });
}

- (void)checkAndShowDanmakuForText:(NSString *)text {
    if (!text || text.length == 0) return;
    
    // 检查文本中是否包含"6"
    if ([text containsString:@"6"]) {
        // 生成随机弹幕内容
        NSArray *danmakuContents = @[
            @"666",
            @"666666",
            @"牛批",
            @"太强了",
            @"厉害了",
            @"秀儿",
            @"溜了溜了",
            @"卧槽",
            @"6得一批",
            @"起飞",
            @"这也太6了",
            @"小K牛皮",
            @"🔥🔥🔥",
            @"👍👍👍",
            @"🎉🎉🎉",
            @"🚀🚀🚀",
            @"💯💯💯",
            @"🤣🤣🤣",
            @"✨✨✨",
            @"❤️❤️❤️",
            @"🌟 闪闪发光 🌟",
            @"🎮 游戏高手 🎮",
            @"🏆 大佬 🏆",
            @"⚡ 无敌了 ⚡",
            @"🔝 顶级玩家 🔝",
            @"🌈 秀翻全场 🌈",
            @"🤩 我酸了 🤩",
            @"🙌 膜拜大神 🙌",
            @"6到飞起",
            @"这波操作秀啊",
            @"我直接好家伙",
            @"绝了绝了",
            @"给力给力",
            @"这也太强了吧",
            @"简直神仙操作",
            @"我愿称你为最强",
            @"强无敌",
            @"大神带带我",
            @"这就是大佬吗",
            @"学到了学到了",
            @"这技术我吹爆",
            @"太秀了",
            @"这操作我跪了",
            @"6到没朋友"
        ];
        
        // 显示更多弹幕 (12-24个)
        NSInteger count = 12 + (arc4random() % 13); // 12-24个弹幕
        for (int i = 0; i < count; i++) {
            NSString *content = danmakuContents[arc4random() % danmakuContents.count];
            // 缩短弹幕出现间隔，使效果更密集
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * i * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self showDanmakuWithContent:content];
            });
        }
    }
}

@end

// --- Hooks ---
%hook CMessageMgr

// 优化: Hook更底层的消息接收方法以减少延迟
- (void)onNewSyncAddMessage:(id)msgWrap {
    %orig;
    if ([msgWrap isKindOfClass:NSClassFromString(@"CMessageWrap")]) {
        CMessageWrap *message = (CMessageWrap *)msgWrap;
        if ([message respondsToSelector:@selector(m_nsContent)]) {
            NSString *content = message.m_nsContent;
            [[DanmakuManager sharedInstance] checkAndShowDanmakuForText:content];
        }
    }
}


// 优化: Hook发送消息的更底层方法
- (void)AddMsg:(id)arg1 MsgWrap:(id)arg2 {
    %orig;
    CMessageWrap *msgWrap = arg2;
    if ([msgWrap isKindOfClass:NSClassFromString(@"CMessageWrap")]) {
        if ([msgWrap respondsToSelector:@selector(m_nsContent)]) {
            NSString *content = msgWrap.m_nsContent;
            [[DanmakuManager sharedInstance] checkAndShowDanmakuForText:content];
        }
    }
}


// 新增: Hook防撤回功能
- (void)HandleSvrCmd:(id)arg1 MsgWrap:(id)arg2 {
    NSLog(@"[WC666 Anti-Revoke] HandleSvrCmd called.");
    CMessageWrap *msgWrap = arg2;
    if ([msgWrap isKindOfClass:NSClassFromString(@"CMessageWrap")]) {
        
        if ([msgWrap respondsToSelector:@selector(m_uiMessageType)]) {
             NSLog(@"[WC666 Anti-Revoke] MessageType: %u", msgWrap.m_uiMessageType);
        }
        
        if ([msgWrap respondsToSelector:@selector(m_nsContent)]) {
            NSLog(@"[WC666 Anti-Revoke] MessageContent: %@", msgWrap.m_nsContent);
        }

        // 消息类型 10002 是系统消息
        if ([msgWrap respondsToSelector:@selector(m_uiMessageType)] && msgWrap.m_uiMessageType == 10002) {
            if ([msgWrap respondsToSelector:@selector(m_nsContent)]) {
                NSString *content = msgWrap.m_nsContent;
                // 撤回的系统消息中会包含 "<revokemsg>" 标签
                if (content && [content containsString:@"<revokemsg>"]) {
                    // 这是一条撤回指令，我们直接返回，不调用原始方法，从而阻止消息被撤回
                    NSLog(@"[WC666 Anti-Revoke] Revoke message detected and BLOCKED!");
                    return;
                }
            }
        }
    }
    // 对于所有其他的服务器指令，正常调用原始方法
    NSLog(@"[WC666 Anti-Revoke] Calling original HandleSvrCmd.");
    %orig;
}

// 新增: 调试 OnModMsg 方法
- (void)OnModMsg:(id)arg1 MsgWrap:(id)arg2 {
    CMessageWrap *msgWrap = arg2;
    NSString *content = @"";
    if ([msgWrap respondsToSelector:@selector(m_nsContent)]) {
        content = msgWrap.m_nsContent;
    }
    NSLog(@"[WC666 Anti-Revoke] OnModMsg called with content: %@", content);

    // 先不拦截，只打印日志
    %orig;
}

%end
