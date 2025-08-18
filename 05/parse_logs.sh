#!/bin/bash

[ "$#" -ne 0 ] && { echo "Ошибка: Скрипт не принимает параметров"; exit 1; }

logs=(nginx_*.log)
[ ${#logs[@]} -eq 0 ] && { echo "Ошибка: Логи не найдены"; exit 1; }

echo "Доступные отчеты:"
echo "1 - Топ IP-адресов"
echo "2 - Топ запрашиваемых URL"
echo "3 - Коды ответа"
echo "4 - Поиск по IP"
read -p "Выберите отчет (1-4): " report

case $report in
    1) awk '{print $1}' "${logs[@]}" | sort | uniq -c | sort -nr | head -10 ;;
    2) awk '{print $7}' "${logs[@]}" | sort | uniq -c | sort -nr | head -10 ;;
    3) awk '{print $9}' "${logs[@]}" | sort | uniq -c | sort -nr ;;
    4) read -p "Введите IP: " ip
       grep "^$ip " "${logs[@]}" | awk '{print $0}'
       ;;
    *) echo "Неверный выбор"; exit 1 ;;
esac
