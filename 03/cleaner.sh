#!/bin/bash

clean_by_log() {
    [ ! -f ../02/log.log ] && { echo "Лог-файл не найден"; return 1; }
    paths=($(awk '{print $1}' ../02/log.log))
    delete_paths "${paths[@]}"
}

clean_by_mask() {
    read -p "Введите маску (без даты): " mask
    [[ -z "$mask" ]] && { echo "Маска не может быть пустой"; return 1; }
    paths=($(find / -name "*${mask}_*" 2>/dev/null))
    delete_paths "${paths[@]}"
}

clean_by_time() {
    read -p "Введите начало периода (YYYY-MM-DD HH:MM): " start
    read -p "Введите конец периода (YYYY-MM-DD HH:MM): " end
    
    validate_time "$start" || return 1
    validate_time "$end" || return 1
    
    start_sec=$(date -d "$start" +%s)
    end_sec=$(date -d "$end" +%s)
    
    [ $start_sec -ge $end_sec ] && {
        echo "Конец периода должен быть позже начала"
        return 1
    }
    
    paths=($(find / -newermt "$start" -not -newermt "$end" 2>/dev/null))
    delete_paths "${paths[@]}"
}

validate_time() {
    [[ $1 =~ ^[0-9]{4}-(0[1-9]|1[0-2])-(0[1-9]|[12][0-9]|3[01])\ ([01][0-9]|2[0-3]):([0-5][0-9])$ ]] || {
        echo "Неверный формат времени: $1"
        return 1
    }
    return 0
}

delete_paths() {
    for path in "$@"; do
        [[ "$path" =~ ^/(dev|bin|proc|sys) ]] && continue
        [ -e "$path" ] || continue
        
        if [ -d "$path" ]; then
            rm -rf "$path" && echo "Удалена папка: $path"
        else
            rm -f "$path" && echo "Удален файл: $path"
        fi
    done
}
