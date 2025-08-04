# WC666 - WeChat Danmaku & Anti-Revoke Plugin

<div align="center">

![Language](https://img.shields.io/badge/Language-Objective--C-blue.svg)
![Platform](https://img.shields.io/badge/Platform-iOS-lightgrey.svg)
![License](https://img.shields.io/badge/License-MIT-green.svg)
![Version](https://img.shields.io/badge/Version-1.0.0-orange.svg)

**[中文](#中文文档) | [English](#english-documentation)**

</div>

---

## 中文文档

### 📖 项目简介

WC666 是一个功能强大的微信插件，为微信聊天界面添加了炫酷的弹幕效果和防撤回功能。当聊天中出现包含"6"的消息时，会自动触发华丽的弹幕动画，让聊天变得更加有趣和生动。

### ✨ 主要功能

#### 🎆 弹幕系统
- **智能触发**: 当消息包含"6"字符时自动触发弹幕
- **丰富内容**: 45+ 种不同的弹幕文本，包括表情符号和中文短语
- **视觉特效**: 5种不同的动画效果（缩放、旋转、闪烁、浮动、彩虹色变）
- **随机化**: 随机颜色、字体大小、移动速度和特效类型
- **批量显示**: 每次触发显示12-24个弹幕，营造热烈氛围

#### 🛡️ 防撤回功能
- **消息保护**: 阻止他人撤回已发送的消息
- **透明运行**: 在后台静默工作，不影响正常使用
- **完整日志**: 详细的调试日志便于问题排查

### 🔧 技术特性

#### 弹幕视觉效果
- **动态颜色**: 13种预设颜色随机选择
- **字体变化**: 18-32px 随机字体大小
- **阴影效果**: 40%概率添加文字描边阴影
- **移动轨迹**: 从屏幕右侧滑动到左侧
- **位置随机**: 垂直位置随机分布

#### 特效系统
1. **缩放动画**: 0.8x - 1.2x 循环缩放
2. **旋转效果**: 轻微的摆动旋转
3. **透明闪烁**: 1.0 - 0.6 透明度变化
4. **上下浮动**: ±5px 垂直浮动
5. **彩虹变色**: 定时器驱动的颜色变换

### 📱 系统要求

- **平台**: iOS 设备（不支持模拟器）
- **越狱**: 需要已越狱的 iOS 设备
- **框架**: 需要安装 Cydia Substrate
- **微信**: 兼容主流微信版本

### 🚀 安装指南

1. **环境准备**
   ```bash
   # 确保设备已越狱并安装了 Cydia Substrate
   # 安装 Theos 开发环境
   ```

2. **编译项目**
   ```bash
   cd WC666
   make package install
   ```

3. **重启微信**
   - 关闭微信应用
   - 重新启动微信
   - 插件将自动生效

### 📂 项目结构

```
WC666/
├── WC666.xm           # 主要插件代码（Logos语法）
├── WC666.mm           # 编译后的Objective-C代码
├── WC666-Prefix.pch   # 预编译头文件
├── CMessageMgr.h      # 消息管理器头文件
└── Package/           # 打包相关文件
```

### 🎯 核心类说明

#### DanmakuView
弹幕视图类，负责单个弹幕的显示和动画
- `contentLabel`: 显示弹幕文本的标签
- `speed`: 弹幕移动速度（2.0-7.0）
- `isAnimated`: 是否启用特效（30%概率）
- `effectType`: 特效类型（0-4）

#### DanmakuManager
弹幕管理器，单例模式管理所有弹幕
- `sharedInstance`: 获取单例实例
- `showDanmakuWithContent:`: 显示指定内容的弹幕
- `checkAndShowDanmakuForText:`: 检查文本并触发弹幕

### 🔍 Hook 机制

插件通过 Logos 框架 Hook 微信的消息管理类：

1. **onNewSyncAddMessage**: 接收新消息时触发
2. **AddMsg:MsgWrap**: 添加消息时触发
3. **HandleSvrCmd:MsgWrap**: 处理服务器命令（防撤回）

### ⚠️ 注意事项

- 仅在真机上运行，不支持模拟器
- 需要越狱环境和相应权限
- 使用前请备份重要数据
- 遵守相关法律法规，合理使用

### 👨‍💻 开发者

**MacXK** - 项目创建者和主要开发者

### 📄 许可证

本项目采用 MIT 许可证 - 查看 [LICENSE](LICENSE) 文件了解详情

---

## English Documentation

### 📖 Project Overview

WC666 is a powerful WeChat plugin that adds stunning danmaku (bullet screen) effects and anti-revoke functionality to WeChat chat interfaces. When messages containing "6" appear in conversations, it automatically triggers gorgeous danmaku animations, making chats more interesting and lively.

### ✨ Key Features

#### 🎆 Danmaku System
- **Smart Trigger**: Automatically triggers danmaku when messages contain "6"
- **Rich Content**: 45+ different danmaku texts including emojis and Chinese phrases
- **Visual Effects**: 5 different animation effects (scale, rotation, blink, float, rainbow)
- **Randomization**: Random colors, font sizes, movement speeds, and effect types
- **Batch Display**: Shows 12-24 danmaku per trigger for lively atmosphere

#### 🛡️ Anti-Revoke Feature
- **Message Protection**: Prevents others from revoking sent messages
- **Transparent Operation**: Works silently in background without affecting normal usage
- **Complete Logging**: Detailed debug logs for troubleshooting

### 🔧 Technical Features

#### Danmaku Visual Effects
- **Dynamic Colors**: Random selection from 13 preset colors
- **Font Variation**: Random font sizes from 18-32px
- **Shadow Effects**: 40% chance of adding text stroke shadows
- **Movement Path**: Slides from right side to left side of screen
- **Random Positioning**: Randomly distributed vertical positions

#### Effect System
1. **Scale Animation**: 0.8x - 1.2x cyclic scaling
2. **Rotation Effect**: Subtle swaying rotation
3. **Opacity Blink**: 1.0 - 0.6 opacity changes
4. **Vertical Float**: ±5px vertical floating
5. **Rainbow Color**: Timer-driven color transformation

### 📱 System Requirements

- **Platform**: iOS devices (simulator not supported)
- **Jailbreak**: Requires jailbroken iOS device
- **Framework**: Cydia Substrate installation required
- **WeChat**: Compatible with mainstream WeChat versions

### 🚀 Installation Guide

1. **Environment Setup**
   ```bash
   # Ensure device is jailbroken with Cydia Substrate installed
   # Install Theos development environment
   ```

2. **Compile Project**
   ```bash
   cd WC666
   make package install
   ```

3. **Restart WeChat**
   - Close WeChat application
   - Restart WeChat
   - Plugin will activate automatically

### 📂 Project Structure

```
WC666/
├── WC666.xm           # Main plugin code (Logos syntax)
├── WC666.mm           # Compiled Objective-C code
├── WC666-Prefix.pch   # Precompiled header file
├── CMessageMgr.h      # Message manager header file
└── Package/           # Packaging related files
```

### 🎯 Core Classes

#### DanmakuView
Danmaku view class responsible for individual danmaku display and animation
- `contentLabel`: Label displaying danmaku text
- `speed`: Danmaku movement speed (2.0-7.0)
- `isAnimated`: Whether effects are enabled (30% probability)
- `effectType`: Effect type (0-4)

#### DanmakuManager
Danmaku manager using singleton pattern to manage all danmaku
- `sharedInstance`: Get singleton instance
- `showDanmakuWithContent:`: Display danmaku with specified content
- `checkAndShowDanmakuForText:`: Check text and trigger danmaku

### 🔍 Hook Mechanism

Plugin hooks WeChat's message management class through Logos framework:

1. **onNewSyncAddMessage**: Triggered when receiving new messages
2. **AddMsg:MsgWrap**: Triggered when adding messages
3. **HandleSvrCmd:MsgWrap**: Handle server commands (anti-revoke)

### ⚠️ Important Notes

- Runs only on real devices, simulator not supported
- Requires jailbreak environment and appropriate permissions
- Please backup important data before use
- Comply with relevant laws and regulations, use responsibly

### 👨‍💻 Developer

**MacXK** - Project creator and main developer

### 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details

---

## 🛠️ 开发指南 / Development Guide

### 中文开发指南

#### 代码架构

**弹幕系统架构**
```
触发检测 → 内容生成 → 视图创建 → 动画执行 → 自动销毁
    ↓           ↓           ↓           ↓           ↓
检查"6"字符  随机选择文本  DanmakuView  特效动画    removeFromSuperview
```

**Hook 流程**
```
微信消息 → CMessageMgr → Hook方法 → 内容检测 → 弹幕触发
```

#### 自定义配置

**修改触发条件**
```objective-c
// 在 checkAndShowDanmakuForText 方法中修改
if ([text containsString:@"6"]) {  // 改为其他触发词
```

**调整弹幕数量**
```objective-c
NSInteger count = 12 + (arc4random() % 13); // 12-24个，可自定义范围
```

**添加新的弹幕内容**
```objective-c
NSArray *danmakuContents = @[
    @"666",
    @"你的自定义内容",  // 添加新内容
    // ... 更多内容
];
```

#### 调试技巧

1. **查看日志**
   ```bash
   # 实时查看系统日志
   tail -f /var/log/syslog | grep WC666
   ```

2. **调试弹幕显示**
   ```objective-c
   NSLog(@"[WC666] Danmaku triggered with content: %@", content);
   ```

3. **性能监控**
   ```objective-c
   // 监控弹幕创建和销毁
   NSLog(@"[WC666] DanmakuView created/destroyed");
   ```

### English Development Guide

#### Code Architecture

**Danmaku System Architecture**
```
Trigger Detection → Content Generation → View Creation → Animation Execution → Auto Destruction
        ↓                   ↓                 ↓                 ↓                 ↓
Check "6" character    Random text selection   DanmakuView    Effect animation   removeFromSuperview
```

**Hook Flow**
```
WeChat Message → CMessageMgr → Hook Method → Content Detection → Danmaku Trigger
```

#### Custom Configuration

**Modify Trigger Condition**
```objective-c
// Modify in checkAndShowDanmakuForText method
if ([text containsString:@"6"]) {  // Change to other trigger words
```

**Adjust Danmaku Count**
```objective-c
NSInteger count = 12 + (arc4random() % 13); // 12-24 pieces, customizable range
```

**Add New Danmaku Content**
```objective-c
NSArray *danmakuContents = @[
    @"666",
    @"Your custom content",  // Add new content
    // ... more content
];
```

#### Debugging Tips

1. **View Logs**
   ```bash
   # Real-time system log viewing
   tail -f /var/log/syslog | grep WC666
   ```

2. **Debug Danmaku Display**
   ```objective-c
   NSLog(@"[WC666] Danmaku triggered with content: %@", content);
   ```

3. **Performance Monitoring**
   ```objective-c
   // Monitor danmaku creation and destruction
   NSLog(@"[WC666] DanmakuView created/destroyed");
   ```

---

## 🔧 高级配置 / Advanced Configuration

### 中文高级配置

#### 性能优化设置

**内存管理**
- 弹幕视图自动销毁机制
- 定时器资源清理
- 弱引用防止循环引用

**动画性能**
- 使用 CABasicAnimation 硬件加速
- 合理的动画时长设置
- 避免过多同时动画

#### 兼容性配置

**iOS 版本适配**
```objective-c
if (@available(iOS 13.0, *)) {
    // iOS 13+ 的窗口获取方式
} else {
    // 旧版本兼容代码
}
```

**微信版本兼容**
- 动态类名检测
- 方法存在性验证
- 安全的消息类型判断

### English Advanced Configuration

#### Performance Optimization Settings

**Memory Management**
- Automatic danmaku view destruction mechanism
- Timer resource cleanup
- Weak references to prevent retain cycles

**Animation Performance**
- Hardware acceleration using CABasicAnimation
- Reasonable animation duration settings
- Avoid excessive simultaneous animations

#### Compatibility Configuration

**iOS Version Adaptation**
```objective-c
if (@available(iOS 13.0, *)) {
    // Window acquisition method for iOS 13+
} else {
    // Legacy version compatibility code
}
```

**WeChat Version Compatibility**
- Dynamic class name detection
- Method existence verification
- Safe message type judgment

---

## 📊 技术细节 / Technical Details

### 弹幕内容列表 / Danmaku Content List

| 类型 Type | 内容 Content | 概率 Probability |
|-----------|--------------|------------------|
| 数字 Numbers | 666, 666666 | 高 High |
| 中文短语 Chinese | 牛批, 太强了, 厉害了 | 高 High |
| 表情符号 Emojis | 🔥🔥🔥, 👍👍👍, 🎉🎉🎉 | 中 Medium |
| 组合内容 Combined | 🌟 闪闪发光 🌟 | 低 Low |

### 动画参数表 / Animation Parameters

| 效果 Effect | 参数 Parameters | 持续时间 Duration |
|-------------|-----------------|-------------------|
| 缩放 Scale | 0.8x - 1.2x | 0.5s |
| 旋转 Rotation | 0 - 0.1π | 0.3s |
| 闪烁 Blink | 1.0 - 0.6 opacity | 0.3s |
| 浮动 Float | ±5px vertical | 0.5s |
| 变色 Color | 0.3s interval | Continuous |

---

## 🚨 故障排除 / Troubleshooting

### 中文故障排除

#### 常见问题

**Q: 弹幕不显示怎么办？**
A:
1. 确认设备已正确越狱
2. 检查 Cydia Substrate 是否正常工作
3. 重启微信应用
4. 查看系统日志是否有错误信息

**Q: 弹幕显示位置不正确？**
A:
1. 检查屏幕方向设置
2. 确认窗口获取逻辑正常
3. 调整随机位置算法参数

**Q: 防撤回功能不生效？**
A:
1. 确认 Hook 方法正确注入
2. 检查微信版本兼容性
3. 查看日志中的撤回检测信息

#### 调试步骤

1. **检查插件加载**
   ```bash
   ps aux | grep WeChat  # 确认微信进程
   ```

2. **查看 Hook 状态**
   ```objective-c
   NSLog(@"[WC666] Plugin loaded successfully");
   ```

3. **测试弹幕触发**
   - 发送包含"6"的测试消息
   - 观察是否有弹幕出现
   - 检查控制台日志

### English Troubleshooting

#### Common Issues

**Q: Danmaku not displaying?**
A:
1. Confirm device is properly jailbroken
2. Check if Cydia Substrate is working normally
3. Restart WeChat application
4. Check system logs for error messages

**Q: Danmaku displaying in wrong position?**
A:
1. Check screen orientation settings
2. Confirm window acquisition logic is normal
3. Adjust random position algorithm parameters

**Q: Anti-revoke feature not working?**
A:
1. Confirm Hook methods are properly injected
2. Check WeChat version compatibility
3. Review revoke detection information in logs

#### Debugging Steps

1. **Check Plugin Loading**
   ```bash
   ps aux | grep WeChat  # Confirm WeChat process
   ```

2. **View Hook Status**
   ```objective-c
   NSLog(@"[WC666] Plugin loaded successfully");
   ```

3. **Test Danmaku Trigger**
   - Send test message containing "6"
   - Observe if danmaku appears
   - Check console logs

---

## 📈 版本历史 / Version History

### v1.0.0 (Current)
**中文更新日志**
- ✅ 实现基础弹幕系统
- ✅ 添加5种视觉特效
- ✅ 集成防撤回功能
- ✅ 支持45+种弹幕内容
- ✅ 优化性能和内存管理

**English Changelog**
- ✅ Implemented basic danmaku system
- ✅ Added 5 visual effects
- ✅ Integrated anti-revoke functionality
- ✅ Support for 45+ danmaku contents
- ✅ Optimized performance and memory management

### 未来计划 / Future Plans

**v1.1.0 (计划中 / Planned)**
- 🔄 自定义触发词设置
- 🔄 弹幕样式主题切换
- 🔄 用户界面配置面板
- 🔄 更多动画效果

**v1.2.0 (规划中 / In Planning)**
- 🔄 多语言弹幕内容
- 🔄 群聊特殊效果
- 🔄 声音效果支持
- 🔄 云端内容同步

---

## 🤝 贡献指南 / Contributing Guide

### 中文贡献指南

#### 如何贡献

1. **Fork 项目**
   - 点击右上角 Fork 按钮
   - 克隆到本地开发环境

2. **创建功能分支**
   ```bash
   git checkout -b feature/your-feature-name
   ```

3. **提交更改**
   ```bash
   git commit -m "Add: 你的功能描述"
   ```

4. **推送并创建 PR**
   ```bash
   git push origin feature/your-feature-name
   ```

#### 代码规范

- 使用清晰的变量和方法命名
- 添加必要的注释说明
- 遵循 Objective-C 编码规范
- 确保代码兼容性

### English Contributing Guide

#### How to Contribute

1. **Fork the Project**
   - Click the Fork button in the top right
   - Clone to local development environment

2. **Create Feature Branch**
   ```bash
   git checkout -b feature/your-feature-name
   ```

3. **Commit Changes**
   ```bash
   git commit -m "Add: your feature description"
   ```

4. **Push and Create PR**
   ```bash
   git push origin feature/your-feature-name
   ```

#### Code Standards

- Use clear variable and method naming
- Add necessary comments
- Follow Objective-C coding standards
- Ensure code compatibility

---

## 📞 联系方式 / Contact

### 开发者联系 / Developer Contact

- **开发者 Developer**: MacXK
- **项目地址 Repository**: [GitHub Repository URL]
- **问题反馈 Issue Report**: [Issues Page URL]

### 社区支持 / Community Support

- **讨论区 Discussions**: 技术交流和使用心得分享
- **Wiki**: 详细的使用教程和开发文档
- **FAQ**: 常见问题快速解答

---

<div align="center">

**Made with ❤️ by MacXK**

*如有问题或建议，欢迎提交 Issue 或 Pull Request*
*For issues or suggestions, feel free to submit Issues or Pull Requests*

**⭐ 如果这个项目对你有帮助，请给个 Star！**
**⭐ If this project helps you, please give it a Star!**

</div>
