#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Ошибка: Скрипт требует ровно 1 параметр (1-4)"
    exit 1
fi

if ! [[ "$1" =~ ^[1-4]$ ]]; then
    echo "Ошибка: Параметр должен быть числом от 1 до 4"
    exit 1
fi

LOG_DIR="../04"
LOG_FILES=("$LOG_DIR"/[0-9][0-9]_*_2025.log)

if [ ! -d "$LOG_DIR" ]; then
    echo "Ошибка: Директория $LOG_DIR не существует"
    exit 1
fi

if [ ${#LOG_FILES[@]} -eq 0 ]; then
    echo "Ошибка: В $LOG_DIR не найдены файлы логов"
    exit 1
fi

TMP_FILE="combined_logs.tmp"
> "$TMP_FILE"

for file in "${LOG_FILES[@]}"; do
    if [ -f "$file" ]; then
        cat "$file" >> "$TMP_FILE"
    fi
done

case $1 in
    1)
        sort -k9 "$TMP_FILE"
        ;;
    2)
        awk '{print $1}' "$TMP_FILE" | sort -u
        ;;
    3)
        awk '$9 ~ /^[45][0-9]{2}$/' "$TMP_FILE"
        ;;
    4)
        awk '$9 ~ /^[45][0-9]{2}$/ {print $1}' "$TMP_FILE" | sort -u
        ;;
esac

rm -f "$TMP_FILE"
