# TinyTask - 极简任务管理器

TinyTask 是一个简洁优雅的任务管理应用，专注于提供最核心的任务管理功能，让用户可以快速记录和管理日常任务。

## 功能特性

### 1. 任务管理
- 支持文字输入添加任务
- 支持语音输入添加任务（使用系统 API）
- 任务列表展示
  - 左滑删除任务
  - 右滑完成任务
  - 长按编辑任务内容
- 任务状态分类查看
  - 全部任务
  - 未完成任务（默认视图）
  - 已完成任务

### 2. 用户体验
- 流畅的动画效果
  - 任务添加时的渐入动画
  - 任务完成时的划线动效
- 空状态友好提示
- 触感反馈（完成任务时）

### 3. 技术实现
- 使用 Flutter 框架开发，支持 iOS 和 Android 平台
- 采用 Hive 数据库实现本地数据持久化
- 遵循 SOLID 设计原则，使用 Provider 状态管理
- 模块化架构，便于扩展和维护

## 项目结构
