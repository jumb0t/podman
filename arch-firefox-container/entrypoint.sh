#!/bin/bash
set -e

# Проверка, что скрипт выполняется от имени root
if [[ "$EUID" -ne 0 ]]; then
  echo "Пожалуйста, запустите скрипт от имени root (используйте sudo)."
  exit 1
fi

# Установите владельца каталога профиля Firefox, если он еще не принадлежит firefoxuser
if [[ $(stat -c "%U:%G" /home/firefoxuser/.mozilla/firefox) != "firefoxuser:firefoxgroup" ]]; then
  chown -R firefoxuser:firefoxgroup /home/firefoxuser/.mozilla/firefox
  echo "Владелец каталога профиля Firefox изменен на firefoxuser:firefoxgroup."
else
  echo "Владелец каталога профиля Firefox уже установлен на firefoxuser:firefoxgroup."
fi

# Установите владельца и права доступа для dconf, если они еще не установлены
if [[ ! -d /run/user/1000/dconf ]]; then
  mkdir -p /run/user/1000/dconf
  chown -R firefoxuser:firefoxgroup /run/user/1000/dconf
  chmod -R 700 /run/user/1000/dconf
  echo "Директория /run/user/1000/dconf создана и настроена."
else
  echo "Директория /run/user/1000/dconf уже существует."
fi

# Запустите dbus, если он не запущен
if ! pgrep dbus-daemon > /dev/null; then
  dbus-daemon --system --fork
  echo "dbus-daemon запущен."
else
  echo "dbus-daemon уже запущен."
fi

# Запустите переданную команду (например, Firefox)
exec "$@"
