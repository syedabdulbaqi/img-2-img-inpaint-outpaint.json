# clean base image containing only comfyui, comfy-cli and comfyui-manager
FROM runpod/worker-comfyui:5.5.1-base

# install custom nodes into comfyui (first node with --mode remote to fetch updated cache)
RUN comfy node install --exit-on-fail comfyui-inpaint-cropandstitch@3.0.7 --mode remote
RUN comfy node install --exit-on-fail comfyui-custom-scripts@1.2.5

# download models into comfyui
RUN comfy model download --url https://huggingface.co/JCTN/JCTN_LORAxl/resolve/9cde7a4715cadb257a6edb6164fe6bcb56275bcd/J_cartoon.safetensors --relative-path models/loras --filename J_cartoon.safetensors
RUN comfy model download \
  --url "https://civitai.com/api/download/models/456538?type=Model&format=SafeTensor&size=pruned&fp=fp16&token=0a1543d8a73857a9a326f76148498bd6" \
  --relative-path models/checkpoints \
  --filename juggernautXL_versionXInpaint.safetensors


# copy all input data (like images or videos) into comfyui (uncomment and adjust if needed)
# COPY input/ /comfyui/input/
