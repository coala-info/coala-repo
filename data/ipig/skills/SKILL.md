---
name: ipig
description: IPIGuard protects LLM agents from indirect prompt injections by analyzing tool calls through a Tool Dependency Graph. Use when user asks to benchmark agent robustness, simulate adversarial attacks, or validate defense strategies against malicious instructions.
homepage: https://github.com/Greysahy/ipiguard
---


# ipig

## Overview

IPIGuard is a defense mechanism designed to protect LLM agents from malicious instructions embedded in third-party data (indirect prompt injections). It utilizes a Tool Dependency Graph to analyze and intercept unauthorized tool calls triggered by adversarial prompts. This skill enables users to benchmark agent robustness, simulate specific attack types like "Important Instructions" or "Tool Knowledge" injections, and validate the performance of the IPIGuard defense strategy compared to standard execution.

## Environment Setup

To initialize the IPIGuard environment, follow these steps:

1. **Clone and Navigate**:
   ```bash
   git clone https://github.com/Greysahy/ipiguard.git
   cd ipiguard
   ```

2. **Dependency Management**:
   Create a Python 3.10 environment and install the core `agentdojo` dependency in editable mode:
   ```bash
   conda create -n ipiguard python=3.10 -y
   conda activate ipiguard
   cd agentdojo
   pip install -e .
   cd ..
   ```

3. **API Configuration**:
   Export your credentials before running evaluations:
   ```bash
   export OPENAI_API_KEY='your_api_key'
   export OPENAI_BASE_URL='your_base_url' # Optional: use for proxies
   ```

## Running Evaluations

The primary interface for IPIGuard is the `eval.sh` script. It requires specific positional arguments to define the agent, attack vector, and defense mode.

### Command Syntax
```bash
bash eval.sh <agent_model> <attack_name> <defense_name> <suite_name> <mode> <output_dir>
```

### Argument Reference
- **agent_model**: The LLM identifier (e.g., `gpt-4o-mini-2024-07-18`).
- **attack_name**: The adversarial strategy:
  - `important_instructions`
  - `ignore_previous`
  - `inject_agent`
  - `tool_knowledge`
- **defense_name**: Set to `ipiguard` to enable the defense or `none` for baseline testing.
- **suite_name**: The task domain: `workspace`, `slack`, `travel`, or `banking`.
- **mode**: Use `benign` for standard tasks or `attack` for tasks containing injections.
- **output_dir**: Path to save JSON results and logs.

## Common CLI Patterns

### Baseline Benign Testing
To verify standard agent performance without attacks or defenses:
```bash
bash eval.sh gpt-4o-mini-2024-07-18 none none workspace benign ./results/baseline
```

### Defending Against Injections
To evaluate IPIGuard's effectiveness against the "Important Instructions" attack in the Slack domain:
```bash
bash eval.sh gpt-4o-mini-2024-07-18 important_instructions ipiguard slack attack ./results/defended
```

### Resuming Interrupted Runs
If an evaluation is interrupted, use the optional ID flags to resume from a specific point:
```bash
bash eval.sh gpt-4o-mini-2024-07-18 inject_agent ipiguard travel attack ./results/resume --uid <user_id> --iid <injection_id>
```

## Expert Tips

- **Metric Interpretation**: Focus on **ASR** (Attack Success Rate) and **UA** (Utility Accuracy). A successful defense should significantly lower ASR while maintaining high UA in benign scenarios.
- **Domain Specifics**: The `banking` suite typically shows higher vulnerability to injections; prioritize testing this domain when validating new defense configurations.
- **Model Selection**: When testing defenses, use consistent model versions (e.g., specific snapshots like `gpt-4o-mini-2024-07-18`) to ensure results are comparable across different attack types.

## Reference documentation
- [IPIGuard Main Repository](./references/github_com_Greysahy_ipiguard.md)