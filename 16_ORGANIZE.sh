#!/bin/bash
read -p "Path to directory to organize: " DIR
mkdir -p "$DIR/Images" "$DIR/Documents" "$DIR/Audio" "$DIR/Video" "$DIR/Archives" "$DIR/Others"
DIR_CONT="$(ls -l $DIR | grep -v '^d' | grep -v '^total 0')"
while IFS= read -r line; do
    extension="${line##*.}"
    #echo "$extension"
    case $extension in
    png | jpg | jpeg)
        mv $DIR/$line $DIR/Images
        ;;
    mp3)
        mv $DIR/$line $DIR/Audio
        ;;
    mp4)
        mv $DIR/$line $DIR/Video
        ;;
    txt)
        mv $DIR/$line $DIR/Documents
        ;;
    *)
        echo "hello"
        ;;
    esac
done <<<"$DIR_CONT"
