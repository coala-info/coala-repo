---
name: qfilt
description: Q-Filters is a training-free KV cache compression method that leverages the geometric relationship between Query (Q) and Key (K) vectors to identify and retain only the most critical information for generation.
homepage: https://github.com/NathanGodey/qfilters
---

# qfilt

## Overview

Q-Filters is a training-free KV cache compression method that leverages the geometric relationship between Query (Q) and Key (K) vectors to identify and retain only the most critical information for generation. By using a context-agnostic projection, it approximates attention scores without needing to compute full attention maps. This makes the tool uniquely compatible with FlashAttention and highly efficient for long-context retrieval and text generation. It serves as a superior alternative to Streaming-LLM for generation quality and is competitive with SnapKV for retrieval tasks.

## Environment Setup

Before running Q-Filters, ensure the environment is configured for Hugging Face access:

```bash
export HF_HOME=<path_to_cache>
export HF_TOKEN=<your_token>
```

## Pre-computing Filters

If a model does not have pre-computed filters, use `make_filters.py` to generate them. This process uses Singular Value Decomposition (SVD) on a calibration dataset.

### Common CLI Pattern
```bash
python make_filters.py \
  --model_name deepseek-ai/DeepSeek-R1-Distill-Qwen-1.5B \
  --model_cls Qwen2ForCausalLM \
  --max_seq_len 2048 \
  --num_sequences 10 \
  --num_svd_samples 3000 \
  --dataset_name PatrickHaller/fineweb-1B \
  --save_mode disk \
  --save_dir ./filters
```

### Parameter Best Practices
- **--model_cls**: Ensure the exact Transformers class name is provided (e.g., `LlamaForCausalLM`, `Qwen2ForCausalLM`).
- **--num_svd_samples**: Higher values (e.g., 3000+) improve filter quality but increase computation time.
- **--save_mode**: Use `disk` for local testing or `hub` to push directly to a Hugging Face repository.

## Integration with Hugging Face

To use Q-Filters during inference, replace the standard cache with `QFiltersCache`.

### Implementation Pattern
```python
from src.hf_cache import QFiltersCache

# Initialize the specialized cache
past_key_values = QFiltersCache(
    window_length=64, 
    max_length=128, 
    model_name="your-model-name"
)

# Pass to the generate method
out = model.generate(
    **inputs,
    past_key_values=past_key_values,
    max_new_tokens=4096
)
```

### Key Configuration Parameters
- **window_length**: The number of recent tokens to keep in the local "sliding window" (uncompressed).
- **max_length**: The total maximum size of the KV cache after compression.

## Expert Tips
- **FlashAttention Compatibility**: Unlike many pruning methods, Q-Filters does not require attention weights. You can keep FlashAttention enabled for maximum throughput.
- **Compression Levels**: Q-Filters can achieve up to 32x compression while maintaining ~99% accuracy on needle-in-a-haystack benchmarks.
- **Uploading Filters**: If you save filters to disk, you can upload them later using the CLI:
  `huggingface-cli upload <repo_id> ./local_path`

## Reference documentation
- [Q-Filters Main Repository](./references/github_com_Nathan_Godey_qfilters.md)