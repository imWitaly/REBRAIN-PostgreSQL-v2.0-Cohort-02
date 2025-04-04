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

# Проверка, что PostgreSQL слушает на порту 5432 (или другом, если изменил конфиг)
echo "\n"
ss -tuln | grep 5432
psql --version
