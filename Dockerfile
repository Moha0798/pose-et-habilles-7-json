# clean base image containing only comfyui, comfy-cli and comfyui-manager
FROM runpod/worker-comfyui:5.5.0-base

# install custom nodes into comfyui
RUN comfy node install --exit-on-fail comfyui-http@2.0.0
RUN comfy node install --exit-on-fail comfyui_controlnet_aux@1.1.3

# download models into comfyui
RUN comfy model download --url https://huggingface.co/Comfy-Org/Qwen-Image_ComfyUI/resolve/main/split_files/text_encoders/qwen_2.5_vl_7b_fp8_scaled.safetensors --relative-path models/text_encoders --filename qwen_2.5_vl_7b_fp8_scaled.safetensors
RUN comfy model download --url https://huggingface.co/aidiffuser/Qwen-Image-Edit-2509/blob/main/Qwen-Image-Edit-2509_fp8_e4m3fn.safetensors --relative-path models/diffusion_models --filename Qwen-Image-Edit-2509_fp8_e4m3fn.safetensors
RUN comfy model download --url https://huggingface.co/Comfy-Org/Qwen-Image_ComfyUI/resolve/main/split_files/vae/qwen_image_vae.safetensors --relative-path models/vae --filename qwen_image_vae.safetensors
RUN comfy model download --url https://huggingface.co/lightx2v/Qwen-Image-Lightning/resolve/main/Qwen-Image-Edit-Lightning-4steps-V1.0.safetensors --relative-path models/loras --filename Qwen-Image-Edit-Lightning-4steps-V1.0.safetensors

# copy all input data (like images or videos) into comfyui (uncomment and adjust if needed)
# COPY input/ /comfyui/input/
