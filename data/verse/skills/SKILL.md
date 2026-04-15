---
name: verse
description: The verse skill orchestrates AgentVerse, a framework for multi-agent collaboration, by deploying task-solving systems and simulation environments. Use when user asks to run a CLI simulation, launch a GUI simulation, execute a specific task, or run benchmarks.
homepage: https://github.com/OpenBMB/AgentVerse
metadata:
  docker_image: "quay.io/biocontainers/verse:0.1.5--h577a1d6_9"
---

# verse

## Overview
The verse skill facilitates the orchestration of AgentVerse, a framework designed for multi-agent collaboration. It allows for the deployment of two distinct agent architectures: Task-solving systems, where multiple agents collaborate as a unified system to achieve a specific goal, and Simulation environments, where agents interact within a sandbox to observe social behaviors. This skill provides the necessary command-line patterns to initialize these environments, run benchmarks, and manage agent interactions.

## CLI Usage Patterns

### Simulation Framework
Use these commands to launch environments where agents interact in social scenarios, such as classrooms or games.

- **Run a CLI Simulation**:
  `agentverse-simulation --task simulation/nlp_classroom_9players`
- **Launch GUI Simulation**:
  `agentverse-simulation-gui --task simulation/nlp_classroom_9players`
  *Note: Once launched, the interface is typically available at http://127.0.0.1:7860/.*

### Task-Solving Framework
Use these commands for automated multi-agent systems designed to complete specific objectives.

- **Execute a Specific Task**:
  `agentverse-tasksolving --task tasksolving/brainstorming`
- **Run Benchmarks**:
  `agentverse-benchmark --task tasksolving/humaneval/gpt-3.5 --dataset_path data/humaneval/test.jsonl --overwrite`

## Setup and Best Practices

### Environment Configuration
Before executing verse commands, ensure the appropriate API keys are exported to your environment:

- **OpenAI**: `export OPENAI_API_KEY="your_api_key_here"`
- **Azure OpenAI**: 
  `export AZURE_OPENAI_API_KEY="your_api_key_here"`
  `export AZURE_OPENAI_API_BASE="your_api_base_here"`

### Local Model Support
If the task requires local LLMs (such as LLaMA or Vicuna) instead of API-based models, ensure the local dependencies are installed:
`pip install -r requirements_local.txt`

### Tool-Augmented Agents
- **Simulation Tools**: For cases involving tool usage (e.g., `nlp_classroom_3players_withtool`), BMTools must be installed and developed in the environment.
- **Task-Solving Tools**: For complex tasks requiring web browsers or code execution, ensure the XAgent ToolServer is built and running.

## Reference documentation
- [AgentVerse Main Repository](./references/github_com_OpenBMB_AgentVerse.md)