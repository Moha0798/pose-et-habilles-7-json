# FULL ComfyUI worker (not BASE!)
FROM runpod/worker-comfyui:5.5.0

# Install custom nodes
RUN comfy node install --exit-on-fail comfyui-http@2.0.0
RUN comfy node install --exit-on-fail comfyui_controlnet_aux@1.1.3

# Download Qwen models
RUN comfy model download \
  --url https://huggingface.co/Comfy-Org/Qwen-Image_ComfyUI/resolve/main/split_files/text_encoders/qwen_2.5_vl_7b_fp8_scaled.safetensors \
  --relative-path models/text_encoders

RUN comfy model download \
  --url https://huggingface.co/aidiffuser/Qwen-Image-Edit-2509/resolve/main/Qwen-Image-Edit-2509_fp8_e4m3fn.safetensors \
  --relative-path models/diffusion_models

RUN comfy model download \
  --url https://huggingface.co/Comfy-Org/Qwen-Image_ComfyUI/resolve/main/split_files/vae/qwen_image_vae.safetensors \
  --relative-path models/vae

RUN comfy model download \
  --url https://huggingface.co/lightx2v/Qwen-Image-Lightning/resolve/main/Qwen-Image-Edit-Lightning-4steps-V1.0.safetensors \
  --relative-path models/loras


