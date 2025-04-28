# Используем базовый образ
FROM alpine:latest

# Копируем файл в контейнер
COPY . /app

# Переходим в директорию с приложением
WORKDIR /app

# Устанавливаем зависимости (если есть)
# RUN apk add --no-cache <package-name>

# Запускаем приложение
CMD ["echo", "Hello, World!"]
