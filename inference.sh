# example of inference
base_dir='/mnt/disk_1/xiaoke/codes/talking_head/Wav2Lip/temp/data'
output_dir='/mnt/disk_1/xiaoke/codes/talking_head/MakeItTalk/examples'
save_dir='/mnt/disk_1/xiaoke/codes/talking_head/MakeItTalk/examples/outputs'
mkdir -p $save_dir
for i in `ls $base_dir`; do
    face_path="$base_dir/$i/val.png"
    audio_path="$base_dir/$i/aud.val.wav"

    output_face_path="$output_dir/$i.jpg"
    output_audio_path="$output_dir/$i.wav"
    convert $face_path -resize 256x256 $output_face_path
    cp $audio_path $output_audio_path

    docker run  --gpus all -e CUDA_VISIBLE_DEVICES=5 -it --rm --name makeittalk -v $(realpath .):/workspace/MakeItTalk --shm-size 8gb  makeittalk  python main_end2end.py --jpg "$(basename $output_face_path)"
    mv $output_dir/*.mp4 $save_dir
    rm -f $output_face_path $output_audio_path
done

