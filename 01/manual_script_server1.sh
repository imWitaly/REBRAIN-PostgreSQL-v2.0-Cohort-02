#!/bin/bash

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

# Проверка порта
grep "^port" /etc/postgresql/16/main/postgresql.conf


#  проверки
echo "\n"
sudo systemctl status postgresql
echo "\n"
ss -tuln | grep 5432
