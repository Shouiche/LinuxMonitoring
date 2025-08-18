#!/bin/bash
source ./log_generators.sh

init_log() {
    records=$((RANDOM % 901 + 100))  
    time_step=$((86400 / records))
}

create_day_log() {
    init_log
    log_name=$(echo "$1" | tr '/' '_')  
    > "$log_name.log"  
    
    for ((i=0; i<records; i++)); do
        time_shift=$((i * time_step))
        time_str=$(date -d "@$time_shift" "+%H:%M:%S %z")
        log_entry="[$1:$time_str]"
        make_log_entry "$log_entry" >> "$log_name.log"
    done
}

generate_logs() {
    current_month=$(date "+%b")
    current_year=$(date "+%Y")
    
    for day in {01..05}; do
        date_str="/$current_month/$current_year"
        create_day_log "$day$date_str"
    done
}

generate_logs

#? 2** Успешные ответы
#* 200 Запрос выполнен успешно
#* 201 Запрос выполнен успешно, в результате чего был создан новый ресурс
#? 4** Ошибки клиента
#* 400 Сервер не может или не будет обрабатывать запрос клиента
#* 401 Неавторизованный(не прошедший проверку) пользователь
#* 403 Нет прав доступа к контенту
#* 404 Сервер не может найти запрошенный ресурс
#? 5** Ошибки сервера
#* 500 Неизвестная ошибка сервера
#* 501 Метод запроса не потдерживается и не может быть обработан
#* 502 Сервер-шлюз в результате передачи запроса получил недопустимый ответ
#* 503 Сервер не готов обработать запрос (отключен или перегружен)
