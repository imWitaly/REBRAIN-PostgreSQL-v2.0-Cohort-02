# Практическое задание

    На сервере psql-op-1-ubuntu-1 установите PostgreSQL версии 16 из репозиториев (порт 5432). Под пользователем postgres проверьте версию установленного PostgreSQL.
    На сервере psql-op-1-ubuntu-2 установите PostgreSQL версии 17 из репозиториев (порт 5433). Под пользователем postgres проверьте версию установленного PostgreSQL.
    Убедитесь, что задание выполнено корректно, и отправьте его на проверку.


## Задача: Нужно создать ansible playbook на основании BASH скриптов

## скрипт для psql-op-1-ubuntu-1

```sh
# Обновление списка пакетов
sudo apt update -y

# Установка PostgreSQL 16
sudo apt install postgresql-16 -y

# Задание порта
PORT=5432

# Проверка, что PostgreSQL установлен и работает
pg_isready -q
if [ $? -eq 0 ]; then
  echo "PostgreSQL доступен, продолжаем настройку"
else
  echo "PostgreSQL не доступен, проверка установки"
  exit 1
fi

# Замена строки port в конфиге PostgreSQL
sudo sed -i "s/^port = 5432\s*#.*$/port = $PORT/" /etc/postgresql/16/main/postgresql.conf

# Перезапуск PostgreSQL, чтобы изменения вступили в силу
sudo systemctl restart postgresql
```

## скрипт для psql-op-1-ubuntu-2

```sh
#!/bin/bash

# Обновление списка пакетов
sudo apt update -y

# Установка необходимых утилит
sudo apt install -y curl ca-certificates sudo

# Импорт ключа репозитория PostgreSQL
sudo curl -o /usr/share/postgresql-common/pgdg/apt.postgresql.org.asc --fail https://www.postgresql.org/media/keys/ACCC4CF8.asc

# Создание репозитория PostgreSQL
sudo sh -c 'echo "deb [signed-by=/usr/share/postgresql-common/pgdg/apt.postgresql.org.asc] https://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'

# Обновление списка пакетов после добавления нового репозитория
sudo apt update -y

# Установка PostgreSQL 17
sudo apt install -y postgresql-17

# Проверка, что PostgreSQL 17 установлен
pg_isready -q
if [ $? -eq 0 ]; then
  echo "PostgreSQL 17 успешно установлен и доступен."
else
  echo "Ошибка установки PostgreSQL 17."
  exit 1
fi

# Перезапуск PostgreSQL
sudo systemctl restart postgresql
```
