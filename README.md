# 【iOS SwiftUI 手機應用程式設計入門 #06】期末 App：梨子習慣

## 簡介
透過**兌換獎勵**的機制，讓使用者更有動力持續打卡與養成習慣的**習慣養成 App**。

## 操作說明

### 1. 概念說明
<img width="1920" height="1080" alt="concept" src="https://github.com/user-attachments/assets/cda78d46-11bc-47c9-a63e-39ab271bc475" />

### 2. 操作 Demo
[梨子習慣 Demo](https://www.youtube.com/watch?v=XZh2EWlf-fw)
[Medium 文章](https://medium.com/台大-cs-x-ios-app-程式設計/ios-swiftui-手機應用程式設計入門-06-期末-app-梨子習慣-d7d817499689)

## 專案架構

```
📁 Components
   📁 Buttons
      ├── CheckinButton.swift
      └── RedeemButton.swift
   📁 RowView
      ├── CheckinRowView.swift
      ├── HabitRowView.swift
      └── RewardRowView.swift
   ├── CalendarView.swift
   ├── CheckinListCardView.swift
   └── PearCounterView.swift

📁 Screens
   📁 DetailsPage
      ├── HabitDetailView.swift
      └── RewardDetailView.swift
   ├── CheckinView.swift
   ├── HabitListView.swift
   ├── RewardListView.swift
   └── SettingsView.swift

📁 SetUp
   ├── AppModel.swift
   └── Models.swift

📁 Sheets
   ├── EditHabitView.swift
   ├── EditRewardView.swift
   ├── NewHabitView.swift
   └── NewRewardView.swift

📁 Style
   └── ViewModifiers.swift

├── ContentView.swift
└── pearcticleHabitsApp.swift
```
