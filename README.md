# GalleryApp

## Конфигурация (Unsplash API / Secrets)
Приложение использует API: https://api.unsplash.com

Для работы приложения нужен Access Key. Ключ не хранится в репозитории и настраивается локально.

1) В корне проекта создайте файл Secrets.xcconfig со следующим содержимым:

UNSPLASH_ACCESS_KEY = YOUR_UNSPLASH_ACCESS_KEY
UNSPLASH_HOST = https://api.unsplash.com

2) Подключите Secrets.xcconfig в Xcode

PROJECT GalleryApp -> Info -> Configurations:

- Debug -> Secrets.xcconfig
- Release -> Secrets.xcconfig

3) Добавьте ключи в Info.plist

 TARGETS GalleryApp -> Info:

- Добавьте два поля (Type: String)

UNSPLASH_ACCESS_KEY = $UNSPLASH_ACCESS_KEY)  
UNSPLASH_HOST = $(UNSPLASH_HOST)