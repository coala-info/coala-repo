---
name: medcon
description: The `medcon` skill facilitates the benchmarking of AI models against the MedConceptsQA dataset, an open-source framework designed to test medical concept knowledge.
homepage: https://github.com/nadavlab/MedConceptsQA
---

# medcon

## Overview
The `medcon` skill facilitates the benchmarking of AI models against the MedConceptsQA dataset, an open-source framework designed to test medical concept knowledge. This skill is used when you need to perform standardized medical QA evaluations, compare model performance on medical leaderboards, or run zero-shot and few-shot tests on HuggingFace or OpenAI models using the specific `med_concepts_qa` task.

## Execution Patterns

### HuggingFace Model Evaluation
To evaluate a model hosted on HuggingFace, use the `lm_eval` command. This requires the `lm-evaluation-harness` to be installed.

**Standard Evaluation Pattern:**
```bash
lm_eval --model hf \
    --model_args pretrained=<MODEL_ID> \
    --tasks med_concepts_qa \
    --device cuda:0 \
    --num_fewshot <SHOTS_NUM> \
    --batch_size auto \
    --limit 250 \
    --output_path <OUTPUT_DIR>
```

*   **Zero-shot**: Set `--num_fewshot 0`.
*   **Few-shot (Standard)**: Set `--num_fewshot 4`.
*   **Limit**: The benchmark typically uses a limit of 250 examples for standardized reporting.

### GPT-4 / OpenAI Evaluation
For proprietary models, use the `gpt4_runner.py` script provided in the repository.

**Command Pattern:**
```bash
# Ensure OPENAI_API_KEY is set in environment
python gpt4_runner.py \
    --model_id <MODEL_NAME> \
    --shots_num 4 \
    --total_eval_examples_num 250 \
    --output_results_dir_path <OUTPUT_DIR>
```

## Expert Tips & Best Practices

*   **Model Selection**: For the highest accuracy in medical concepts, refer to the leaderboard. Models like `gpt-4-0125-preview` and `Llama-3.1-70B-Instruct` currently lead in both zero-shot and few-shot performance.
*   **Device Management**: When running local HuggingFace models, ensure `--device cuda:0` is specified to utilize GPU acceleration, as medical LLMs are often large (70B+ parameters).
*   **Output Analysis**: The tool generates a CSV file in the specified `output_path`. This file contains the raw accuracy and Confidence Interval (CI) metrics required for academic or technical reporting.
*   **Few-shot Advantage**: Performance typically improves significantly (approx. 10-15% accuracy gain) when moving from zero-shot to 4-shot evaluation. Always prefer few-shot testing for a true representation of model capability.

## Reference documentation
- [MedConceptsQA README](./references/github_com_nadavlab_MedConceptsQA_blob_master_README.md)