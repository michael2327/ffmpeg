#!/bin/bash

# Путь до заданной папки
path="/mnt/4tb/1CONVERTED/Xdone"
# Счетчик папок
folder_count=0
# Перебираем все папки в заданной папке
for folder in "$path"/*/; do
  ((folder_count++))
  
  # Счетчик файлов в текущей папке
  file_count=0
  
  # Перебираем все файлы в текущей папке
  for file in "$folder"/*; do
    ((file_count++))
    
    # Форматируем номер серии, чтобы был двузначным
    file_number=$(printf "%02d" $file_count)
    
    # Переименовываем файл в соответствии с количеством папок и файлов
	mv "$file" "${folder}Сезон $folder_count Серия $file_number.${file##*.}"
  done
  
done
echo "Переименование завершено!"

# Извлекаем все файлы из подпапок в основную папку
find "$path" -type f -print0 | xargs -0 -I{} mv -n {} "$path"
# Удаляем пустые папки внутри основной папки
find "$path" -type d -empty -delete
echo "Обработка завершена!"
