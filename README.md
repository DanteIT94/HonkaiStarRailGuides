# Honkai: Star Rail Character Guides
## Назначение и Цели Приложения
Это мобильное приложение создано как сборник гайдов для персонажей в игре Honkai: Star Rail.

## Цели приложения:
Обеспечение доступа к информации о различных персонажах игры.
Предоставление рекомендаций по топовым артефактам, оружиям и т.д.

## Краткое Описание Приложения
Главный Экран: Список всех доступных персонажей. Данные загружаются из FirebaseStorage и FirebaseRealtimeDatabase.


Экран Персонажа: Содержит всю информацию о персонаже, включая топовые артефакты и оружия. Используется scrollView для удобства просмотра.


Экран Настройки: Создан на SwiftUI, позволяет выбрать темную тему и посмотреть информацию о разработчике.

## Архитектуры
MVP: Используется для организации всех экранов приложения.

## Инструменты и Технологии
UIKit: Используется для большинства UI компонентов, включая TableView на главном экране.


FirebaseStorage и FirebaseRealtimeDatabase: Для хранения и синхронизации данных персонажей.


SwiftUI: Используется для экрана настроек.


ScrollView: Для удобства просмотра информации на экране персонажа.


Swift Package Manager (SPM): Для управления зависимостями проекта.

## Скриншоты
Main Screen

![MainScreen](https://github.com/DanteIT94/HonkaiStarRailGuides/blob/main/CharactersList.png)

Character Screen

![CharacterView](https://github.com/DanteIT94/HonkaiStarRailGuides/blob/main/CharacterView.png)


Лицензия
MIT
