---
name: tree-puzzle
description: The tree-puzzle tool implements the Tree of Thoughts framework to solve complex puzzles and benchmark reasoning strategies. Use when user asks to solve a Sudoku puzzle, run experiments comparing reasoning strategies, or benchmark puzzle-solving methods.
homepage: https://github.com/jieyilong/tree-of-thought-puzzle-solver
---


# tree-puzzle

## Overview
The tree-puzzle tool implements the Tree of Thoughts (ToT) framework to solve complex puzzles that typically challenge standard auto-regressive language models. It augments an LLM with a prompter agent, a checker module, and a controller to explore solutions as a tree. This allows the system to evaluate intermediate "thoughts," backtrack from dead ends, and explore alternative branches. It is primarily designed for Sudoku puzzles of varying sizes (3x3, 4x4, 5x5) and provides a benchmarking suite to compare ToT against Zero-shot and Chain-of-Thought (CoT) methods.

## Installation and Setup
Before running the solver, ensure the environment is prepared:
1. Install dependencies: `pip install -r requirements.txt`
2. Configure the environment: Create a `config.yaml` file in the root directory. You must specify the chatbot type (e.g., "openai"), the model name, and your API key.
3. Ensure you are using Python 3.9 or higher.

## Solving Puzzles
To solve a specific puzzle, use the `run_tot.py` script. The puzzle should be described in a format the LLM can interpret, typically using asterisks (*) for empty cells.

**Pattern for single puzzles:**
`python run_tot.py "your puzzle description here"`

**Example for a 4x4 Sudoku:**
`python run_tot.py "please solve this 4x4 sudoku puzzle [[*,1,*,*],[*,*,2,*],[*,*,*,4],[1,*,*,*]] where * represents a cell to be filled in."`

## Running Experiments and Benchmarks
The tool includes a benchmarking script, `run_expr.py`, to test different reasoning strategies against JSON-based problem sets.

**Command Syntax:**
`python run_expr.py <solver_type> <path_to_json>`

**Available Solver Types:**
- `zero_shot`: Standard prompt-to-answer.
- `one_shot_with_cot`: Single example with Chain-of-Thought reasoning.
- `few_shot_with_cot`: Multiple examples with Chain-of-Thought reasoning.
- `tot`: The full Tree of Thoughts framework with backtracking.

**Example Benchmark:**
`python run_expr.py tot data/benchmarks/sudoku/3x3_sudoku_puzzles.json`

## Expert Tips
- **Backtracking Logic**: The ToT controller automatically handles rollbacks based on the visit count of parent states. If the solver is stuck, check the `config.yaml` to ensure the `max_context_length` is sufficient for the conversation history.
- **Input Formatting**: For Sudoku, representing the grid as a nested list (matrix) is the most reliable way to ensure the checker module correctly parses the state.
- **Model Selection**: While the framework is model-agnostic, performance is highly dependent on the LLM's ability to follow the prompter's instructions and the checker's feedback. Use high-reasoning models for 5x5 puzzles or larger.

## Reference documentation
- [Tree of Thought Puzzle Solver README](./references/github_com_jieyilong_tree-of-thought-puzzle-solver.md)