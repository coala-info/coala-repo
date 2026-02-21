---
name: flash
description: FlashAttention is a suite of IO-aware attention algorithms designed to accelerate Transformer training and inference.
homepage: https://github.com/Dao-AILab/flash-attention
---

# flash

## Overview
FlashAttention is a suite of IO-aware attention algorithms designed to accelerate Transformer training and inference. By utilizing tiling and recomputation, it avoids the memory bottleneck of materializing the large $N \times N$ attention matrix, allowing for longer sequence lengths and faster computation. This skill covers the practical application of FlashAttention-2 for Ampere/Ada/Hopper GPUs and the beta FlashAttention-3 implementation specifically optimized for Hopper (H100) architectures.

## Installation Best Practices

### Standard Installation
For most users on Linux with CUDA 12.0+, use the pre-built wheels to avoid long compilation times:
```bash
pip install flash-attn --no-build-isolation
```

### Compiling from Source
If pre-built wheels are unavailable or you need specific optimizations:
1. Ensure `ninja` is installed (`pip install ninja`) to enable parallel compilation (reduces time from ~2 hours to ~5 minutes).
2. Use `MAX_JOBS` to prevent Out-of-Memory (OOM) errors on the host CPU if you have many cores but limited RAM (e.g., < 96GB):
   ```bash
   MAX_JOBS=4 pip install flash-attn --no-build-isolation
   ```

### FlashAttention-3 (Hopper/H100 Only)
To use the latest FP8/FP16/BF16 optimizations for H100 GPUs:
```bash
cd hopper
python setup.py install
```
*Requirement: CUDA >= 12.3 (12.8 recommended).*

## Core API Usage

### Packed QKV (Recommended for Performance)
If your Query, Key, and Value tensors are already stacked into a single tensor, use the packed function to avoid unnecessary memory copies:
```python
from flash_attn import flash_attn_qkvpacked_func

# qkv shape: (batch, seqlen, 3, nheads, headdim)
output = flash_attn_qkvpacked_func(
    qkv, 
    dropout_p=0.0, 
    softmax_scale=None, 
    causal=True
)
```

### Unpacked Q, K, V
Use this when tensors are separate:
```python
from flash_attn import flash_attn_func

# q, k, v shapes: (batch, seqlen, nheads, headdim)
output = flash_attn_func(q, k, v, dropout_p=0.1, causal=False)
```

## Hardware and Datatype Constraints

| Feature | Requirement |
| :--- | :--- |
| **FlashAttention-2** | Ampere, Ada, or Hopper (A100, RTX 3090/4090, H100) |
| **FlashAttention-3** | Hopper (H100/H800) |
| **Turing Support** | Use FlashAttention 1.x for T4/RTX 2080 |
| **BF16 Datatype** | Requires Ampere or newer |
| **Head Dimensions** | Supports up to 256; dimensions > 192 backward require A100/H100 |

## Expert Tips

- **Deterministic Mode**: If reproducible results are required (e.g., for debugging), set `deterministic=True`. Note that this may slightly impact performance.
- **Causal Masking**: Always set `causal=True` for decoder-only models (like GPT) to ensure the attention mask is applied correctly and efficiently at the kernel level.
- **Window Size**: For local attention patterns, use the `window_size=(left, right)` parameter to limit the attention scope and further improve speed.
- **AMD ROCm**: For MI200/MI300 GPUs, enable the Triton backend for better performance:
  ```bash
  export FLASH_ATTENTION_TRITON_AMD_ENABLE="TRUE"
  ```

## Reference documentation
- [FlashAttention Main README](./references/github_com_Dao-AILab_flash-attention.md)