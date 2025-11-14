# ------------------------------------------------------------------------------
# Base image : worker-comfyui minimal (propre, optimisé pour serverless RunPod)
# ------------------------------------------------------------------------------
FROM runpod/worker-comfyui:5.5.0-base

# ------------------------------------------------------------------------------
# Install required custom nodes for your Qwen workflow
# ------------------------------------------------------------------------------

# 1. comfyui-http → provides HTTPImageLoader
RUN comfy node install --exit-on-fail comfyui-http@2.0.0

# 2. ControlNet auxiliary nodes → provides OpenPosePreprocessor
RUN comfy node install --exit-on-fail comfyui_controlnet_aux@1.1.3

# ------------------------------------------------------------------------------
# Download Qwen models required by your workflow
# ------------------------------------------------------------------------------

# Qwen Text Encoder (qwen_2.5_vl_7b_fp8)
RUN comfy model download \
  --url https://huggingface.co/Comfy-Org/Qwen-Image_ComfyUI/resolve/main/split_files/text_encoders/qwen_2.5_vl_7b_fp8_scaled.safetensors \
  --relative-path models/text_encoders \
  --filename qwen_2.5_vl_7b_fp8_scaled.safetensors

# Qwen UNet / diffusion model (must use /resolve/ not /blob/)
RUN comfy model download \
  --url https://huggingface.co/aidiffuser/Qwen-Image-Edit-2509/resolve/main/Qwen-Image-Edit-2509_fp8_e4m3fn.safetensors \
  --relative-path models/diffusion_models \
  --filename Qwen-Image-Edit-2509_fp8_e4m3fn.safetensors

# Qwen VAE
RUN comfy model download \
  --url https://huggingface.co/Comfy-Org/Qwen-Image_ComfyUI/resolve/main/split_files/vae/qwen_image_vae.safetensors \
  --relative-path models/vae \
  --filename qwen_image_vae.safetensors

# Qwen Lightning Lora (4-step)
RUN comfy model download \
  --url https://huggingface.co/lightx2v/Qwen-Image-Lightning/resolve/main/Qwen-Image-Edit-Lightning-4steps-V1.0.safetensors \
  --relative-path models/loras \
  --filename Qwen-Image-Edit-Lightning-4steps-V1.0.safetensors

# ------------------------------------------------------------------------------
# (Optional) Copy input files into ComfyUI, if workflow needs local images
# ------------------------------------------------------------------------------
# COPY input/ /comfyui/input/

# ------------------------------------------------------------------------------
# DONE – worker is now ready
# ------------------------------------------------------------------------------

