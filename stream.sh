#!/bin/bash

INPUT_URL="${INPUT_URL:-https://magselect-stirr.amagi.tv/playlist1080p.m3u8}"

if [[ -z "${SERVER_URL}" ]]; then
    echo "SERVER_URL is not set"
    exit 1
elif [[ -z "${STREAM_KEY}" ]]; then
   echo "STREAM_KEY is not set"
   exit 1
elif [[ $INPUT_URL =~ ^(https?\:\/\/)?(www\.)?(youtube\.com|youtu\.?be)\/.+$ ]]; then
    INPUT_URL=`youtube-dl -g $INPUT_URL`
    echo "GENERATED URL: $INPUT_URL \n"
fi

printf "PREPARING TO STREAM \n"
ffmpeg -i $INPUT_URL -preset veryfast -tune zerolatency -f flv -c:v libx264 -c:a aac -r 30 -crf 24 -vf "scale=-1:1080" $SERVER_URL$STREAM_KEY
