FROM pytorch/pytorch:1.11.0-cuda11.3-cudnn8-devel
RUN mkdir /workspace/MakeItTalk
WORKDIR /workspace/MakeItTalk


# uncomment this if you have trouble downloading packages
# RUN rm /etc/apt/sources.list.d/cuda.list && \
#     rm /etc/apt/sources.list.d/nvidia-ml.list && \
#     sed -i "s@http://.*archive.ubuntu.com@https://mirrors.tuna.tsinghua.edu.cn@g" /etc/apt/sources.list && \
#     sed -i "s@http://.*security.ubuntu.com@https://mirrors.tuna.tsinghua.edu.cn@g" /etc/apt/sources.list && \
#     pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple

RUN apt-get -y update --fix-missing && \
    apt-get install -y libglib2.0-0 libxrender1 ffmpeg libsm6 && \
    pip install ffmpeg-python opencv-python face_alignment scikit-learn pydub pynormalize soundfile librosa pysptk pyworld resemblyzer tensorboardX matplotlib

# Downloading: "https://www.adrianbulat.com/downloads/python-fan/s3fd-619a316812.pth" to ckpts/s3fd-619a316812.pth
# Downloading: "https://www.adrianbulat.com/downloads/python-fan/3DFAN4-4a694010b9.zip" to ckpts/3DFAN4-4a694010b9.zip
# Downloading: "https://www.adrianbulat.com/downloads/python-fan/depth-6c4283c0e0.zip" to ckpts/checkpoints/depth-6c4283c0e0.zip
RUN mkdir -p  /root/.cache/torch/hub/checkpoints
COPY ckpts/s3fd-619a316812.pth /root/.cache/torch/hub/checkpoints/s3fd-619a316812.pth
COPY ckpts/3DFAN4-4a694010b9.zip /root/.cache/torch/hub/checkpoints/3DFAN4-4a694010b9.zip
COPY ckpts/depth-6c4283c0e0.zip /root/.cache/torch/hub/checkpoints/depth-6c4283c0e0.zip
