#line 1 "/Users/macxk/Desktop/WC666/WC666/WC666.xm"


#if TARGET_OS_SIMULATOR
#error Do not support the simulator, please use the real iPhone Device.
#endif

#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import <QuartzCore/QuartzCore.h>


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


@interface DanmakuView : UIView
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, assign) CGFloat speed;
@property (nonatomic, assign) BOOL isAnimated; 
@property (nonatomic, assign) NSInteger effectType; 
+ (instancetype)danmakuWithContent:(NSString *)content;
- (void)start;
- (void)applySpecialEffect;
@end

@implementation DanmakuView

+ (instancetype)danmakuWithContent:(NSString *)content {
    DanmakuView *danmaku = [[DanmakuView alloc] init];
    danmaku.contentLabel.text = content;
    
    
    danmaku.isAnimated = (arc4random() % 100) < 30; 
    danmaku.effectType = arc4random() % 5; 
    
    return danmaku;
}

- (instancetype)init {
    if (self = [super init]) {
        _speed = 2.0 + (arc4random() % 5); 
        
        self.contentLabel = [[UILabel alloc] init];
        self.contentLabel.font = [UIFont boldSystemFontOfSize:18 + (arc4random() % 14)]; 
        self.contentLabel.textColor = [self randomColor]; 
        
        
        if ((arc4random() % 100) < 40) { 
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
        [UIColor colorWithRed:1.0 green:0.5 blue:0.0 alpha:1.0], 
        [UIColor colorWithRed:0.5 green:0.0 blue:0.5 alpha:1.0], 
        [UIColor colorWithRed:0.0 green:0.5 blue:0.5 alpha:1.0], 
        [UIColor colorWithRed:1.0 green:0.8 blue:0.0 alpha:1.0]  
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
    
    
    CGFloat randomY = (arc4random() % (int)(screenHeight * 0.8)) + 40;
    
    
    self.frame = CGRectMake(screenWidth, randomY, self.frame.size.width, self.frame.size.height);
    [window addSubview:self];
    
    
    if (self.isAnimated) {
        [self applySpecialEffect];
    }
    
    
    [UIView animateWithDuration:screenWidth / (40.0 * self.speed) delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.frame = CGRectMake(-self.frame.size.width, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)applySpecialEffect {
    switch (self.effectType) {
        case 0: 
            [self addScaleAnimation];
            break;
        case 1: 
            [self addRotationAnimation];
            break;
        case 2: 
            [self addBlinkAnimation];
            break;
        case 3: 
            [self addFloatAnimation];
            break;
        case 4: 
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
    rotationAnimation.toValue = @(M_PI * 0.1); 
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
    
    
    static char timerKey;
    objc_setAssociatedObject(self, &timerKey, timer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)removeFromSuperview {
    
    static char timerKey;
    dispatch_source_t timer = objc_getAssociatedObject(self, &timerKey);
    if (timer) {
        dispatch_source_cancel(timer);
    }
    
    [super removeFromSuperview];
}

@end


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
    
    
    if ([text containsString:@"6"]) {
        
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
        
        
        NSInteger count = 12 + (arc4random() % 13); 
        for (int i = 0; i < count; i++) {
            NSString *content = danmakuContents[arc4random() % danmakuContents.count];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * i * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self showDanmakuWithContent:content];
            });
        }
    }
}

@end



#include <substrate.h>
#if defined(__clang__)
#if __has_feature(objc_arc)
#define _LOGOS_SELF_TYPE_NORMAL __unsafe_unretained
#define _LOGOS_SELF_TYPE_INIT __attribute__((ns_consumed))
#define _LOGOS_SELF_CONST const
#define _LOGOS_RETURN_RETAINED __attribute__((ns_returns_retained))
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif

__asm__(".linker_option \"-framework\", \"CydiaSubstrate\"");

@class CMessageMgr; 
static void (*_logos_orig$_ungrouped$CMessageMgr$onNewSyncAddMessage$)(_LOGOS_SELF_TYPE_NORMAL CMessageMgr* _LOGOS_SELF_CONST, SEL, id); static void _logos_method$_ungrouped$CMessageMgr$onNewSyncAddMessage$(_LOGOS_SELF_TYPE_NORMAL CMessageMgr* _LOGOS_SELF_CONST, SEL, id); static void (*_logos_orig$_ungrouped$CMessageMgr$AddMsg$MsgWrap$)(_LOGOS_SELF_TYPE_NORMAL CMessageMgr* _LOGOS_SELF_CONST, SEL, id, id); static void _logos_method$_ungrouped$CMessageMgr$AddMsg$MsgWrap$(_LOGOS_SELF_TYPE_NORMAL CMessageMgr* _LOGOS_SELF_CONST, SEL, id, id); static void (*_logos_orig$_ungrouped$CMessageMgr$HandleSvrCmd$MsgWrap$)(_LOGOS_SELF_TYPE_NORMAL CMessageMgr* _LOGOS_SELF_CONST, SEL, id, id); static void _logos_method$_ungrouped$CMessageMgr$HandleSvrCmd$MsgWrap$(_LOGOS_SELF_TYPE_NORMAL CMessageMgr* _LOGOS_SELF_CONST, SEL, id, id); static void (*_logos_orig$_ungrouped$CMessageMgr$onNewSyncDeleteMessage$)(_LOGOS_SELF_TYPE_NORMAL CMessageMgr* _LOGOS_SELF_CONST, SEL, id); static void _logos_method$_ungrouped$CMessageMgr$onNewSyncDeleteMessage$(_LOGOS_SELF_TYPE_NORMAL CMessageMgr* _LOGOS_SELF_CONST, SEL, id); 

#line 338 "/Users/macxk/Desktop/WC666/WC666/WC666.xm"



static void _logos_method$_ungrouped$CMessageMgr$onNewSyncAddMessage$(_LOGOS_SELF_TYPE_NORMAL CMessageMgr* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id msgWrap) {
    _logos_orig$_ungrouped$CMessageMgr$onNewSyncAddMessage$(self, _cmd, msgWrap);
    if ([msgWrap isKindOfClass:NSClassFromString(@"CMessageWrap")]) {
        CMessageWrap *message = (CMessageWrap *)msgWrap;
        if ([message respondsToSelector:@selector(m_nsContent)]) {
            NSString *content = message.m_nsContent;
            [[DanmakuManager sharedInstance] checkAndShowDanmakuForText:content];
        }
    }
}



static void _logos_method$_ungrouped$CMessageMgr$AddMsg$MsgWrap$(_LOGOS_SELF_TYPE_NORMAL CMessageMgr* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1, id arg2) {
    _logos_orig$_ungrouped$CMessageMgr$AddMsg$MsgWrap$(self, _cmd, arg1, arg2);
    CMessageWrap *msgWrap = arg2;
    if ([msgWrap isKindOfClass:NSClassFromString(@"CMessageWrap")]) {
        if ([msgWrap respondsToSelector:@selector(m_nsContent)]) {
            NSString *content = msgWrap.m_nsContent;
            [[DanmakuManager sharedInstance] checkAndShowDanmakuForText:content];
        }
    }
}



static void _logos_method$_ungrouped$CMessageMgr$HandleSvrCmd$MsgWrap$(_LOGOS_SELF_TYPE_NORMAL CMessageMgr* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1, id arg2) {
    NSLog(@"[WC666 Anti-Revoke] HandleSvrCmd called.");
    CMessageWrap *msgWrap = arg2;
    if ([msgWrap isKindOfClass:NSClassFromString(@"CMessageWrap")]) {
        
        if ([msgWrap respondsToSelector:@selector(m_uiMessageType)]) {
             NSLog(@"[WC666 Anti-Revoke] MessageType: %u", msgWrap.m_uiMessageType);
        }
        
        if ([msgWrap respondsToSelector:@selector(m_nsContent)]) {
            NSLog(@"[WC666 Anti-Revoke] MessageContent: %@", msgWrap.m_nsContent);
        }

        
        if ([msgWrap respondsToSelector:@selector(m_uiMessageType)] && msgWrap.m_uiMessageType == 10002) {
            if ([msgWrap respondsToSelector:@selector(m_nsContent)]) {
                NSString *content = msgWrap.m_nsContent;
                
                if (content && [content containsString:@"<revokemsg>"]) {
                    
                    NSLog(@"[WC666 Anti-Revoke] Revoke message detected and BLOCKED!");
                    return;
                }
            }
        }
    }
    
    NSLog(@"[WC666 Anti-Revoke] Calling original HandleSvrCmd.");
    _logos_orig$_ungrouped$CMessageMgr$HandleSvrCmd$MsgWrap$(self, _cmd, arg1, arg2);
}


static void _logos_method$_ungrouped$CMessageMgr$onNewSyncDeleteMessage$(_LOGOS_SELF_TYPE_NORMAL CMessageMgr* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1) {
    NSLog(@"[WC666 Anti-Revoke] onNewSyncDeleteMessage called with arg: %@", arg1);
    
    _logos_orig$_ungrouped$CMessageMgr$onNewSyncDeleteMessage$(self, _cmd, arg1);
}


static __attribute__((constructor)) void _logosLocalInit() {
{Class _logos_class$_ungrouped$CMessageMgr = objc_getClass("CMessageMgr"); { MSHookMessageEx(_logos_class$_ungrouped$CMessageMgr, @selector(onNewSyncAddMessage:), (IMP)&_logos_method$_ungrouped$CMessageMgr$onNewSyncAddMessage$, (IMP*)&_logos_orig$_ungrouped$CMessageMgr$onNewSyncAddMessage$);}{ MSHookMessageEx(_logos_class$_ungrouped$CMessageMgr, @selector(AddMsg:MsgWrap:), (IMP)&_logos_method$_ungrouped$CMessageMgr$AddMsg$MsgWrap$, (IMP*)&_logos_orig$_ungrouped$CMessageMgr$AddMsg$MsgWrap$);}{ MSHookMessageEx(_logos_class$_ungrouped$CMessageMgr, @selector(HandleSvrCmd:MsgWrap:), (IMP)&_logos_method$_ungrouped$CMessageMgr$HandleSvrCmd$MsgWrap$, (IMP*)&_logos_orig$_ungrouped$CMessageMgr$HandleSvrCmd$MsgWrap$);}{ MSHookMessageEx(_logos_class$_ungrouped$CMessageMgr, @selector(onNewSyncDeleteMessage:), (IMP)&_logos_method$_ungrouped$CMessageMgr$onNewSyncDeleteMessage$, (IMP*)&_logos_orig$_ungrouped$CMessageMgr$onNewSyncDeleteMessage$);}} }
#line 406 "/Users/macxk/Desktop/WC666/WC666/WC666.xm"
