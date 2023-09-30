#!/bin/bash
# папка, откуда будут браться видеофайлы
source_folder="/mnt/4tb/nonconverted/down/The.X.Files.BDRip.TV3"
intro="/home/milk/intro/720-400-24.mp4"
conv="/mnt/4tb/1CONVERTED/Xfiles"

# проверка наличия папки output
if [ ! -d "$conv" ]; then
echo "Output error. Creating output..."
mkdir "$conv"
fi

# поиск видеофайлов в папке
for video_file in "$source_folder"/*; do 

     # Извлекаем имя файла без расширения
    filename=$(basename -- "$video_file")
    extension="${filename##*.}"
    filename="${filename%.*}"

    # конвертирование файла в формат mp4
    ffmpeg -i "$intro" -i "$video_file" -filter_complex \
   "[0:v]scale=720:400,setdar=9/5,setpts=PTS-STARTPTS[v0]; \
    [1:v]scale=720:400,setdar=9/5,setpts=PTS-STARTPTS[v1]; \
    [v0][0:1][v1][1:1]concat=n=2:v=1:a=1[outv][outa]" \
     -map "[outv]" -map "[outa]" -c:v libx265 -n -crf 18 -c:a aac -r 24 "$conv/$filename.mp4"
 
       # проверка статуса выполнения команды
    if [ $? -eq 0 ]; then
        echo "File $video_file done"


    else
        echo "Error occurred while processing $video_file"
        exit 1
    fi
done
