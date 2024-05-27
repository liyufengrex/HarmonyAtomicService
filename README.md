## HarmonyOS NEXT 元服务设计示例

基于 API11，开发的程序示例，适用于 NEXT 及以上版本运行。

项目包含如下：

+ 静态库+动态包+多模块设计
+ 状态管理
+ 统一路由管理（router+navPathStack）
+ 网络请求、Loading 等工具库封装
+ 自定义组件、自定义弹窗（解耦）
+ EventBus 事件通知
+ 扩展修饰器，实现 节流、防抖、权限申请


项目结构描述

#### 基础库

| 模块名称                | 描述                  | 备注                                                                                                           |
|---------------------|---------------------|--------------------------------------------------------------------------------------------------------------|
| **fast_util**       | 工具类                 | FastLog（日志打印）<br/>EventBus（消息通知）<br/>FastRouter（路由管理）<br/>ThrottleTool(节流、防抖) <br/>FastPermission(修饰器实现权限申请) |
| **fast_ui**         | 提供 UI 封装、样式、toast 等 | CommonText（统一文本）<br/>CommonButton（统一按键）<br/> FastToast <br/> FastLoading                                     |
| **global_constant** | 记录全局常量配置            | PagePathConstants(路由路径管理)                                                                                    |

#### 业务库
| 模块名称                | 描述                  | 备注 |
|---------------------|---------------------|--|
| **feature_home**    | 主要存放代码示例            | 静态包（har） |
| **feature_hsp_page**    | 存放动态包交互示例            | 动态包（hsp/share） |



# 持续更新中......
