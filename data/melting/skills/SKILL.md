---
name: melting
description: Melting Pot provides a suite of test scenarios for evaluating the social interaction and cooperation capabilities of AI agents. Use when user asks to install the dm-meltingpot library, interactively explore substrates using human player scripts, or train agents using RLlib examples.
homepage: https://github.com/google-deepmind/meltingpot
metadata:
  docker_image: "biocontainers/melting:v5.2.0-1-deb_cv1"
---

# melting

## Overview
Melting Pot is a specialized suite of test scenarios designed by Google DeepMind to assess how AI agents navigate complex social interactions. It moves beyond simple competition to test cooperation, reciprocation, and trust across hundreds of unique scenarios. This skill enables users to set up the dm-meltingpot library, interactively explore substrates to understand game mechanics, and initiate training runs using provided examples.

## Installation and Setup
Melting Pot relies on DeepMind Lab2D. The easiest way to install the library is via PyPI:

```bash
pip install dm-meltingpot
```

For development or modifying the source code, use an editable installation:
1. Clone the repository: `git clone -b main https://github.com/google-deepmind/meltingpot`
2. Install with dev dependencies: `pip install --editable .[dev]`

**Note**: If your system architecture does not have a pre-built wheel for `dmlab2d`, you must build it from source before installing Melting Pot.

## Interactive Exploration
Before training agents, use the `human_players` scripts to understand the observation space and reward structures of a substrate.

### Running a Substrate
To play a specific game (e.g., "Clean Up"):
```bash
python meltingpot/human_players/play_clean_up.py
```

### Common Controls
- **Movement**: `W`, `A`, `S`, `D`
- **Turning**: `Q` (Left), `E` (Right)
- **Actions**: `1` (Zapper/Attack), `2` (Special/Cleaning Beam)
- **Switching Agents**: `TAB` (allows you to control different agents in the multi-agent setup)

### Selecting Variants
Many substrates have multiple levels or configurations. Use the `--level_name` flag to specify a variant:
```bash
python meltingpot/human_players/play_substrate.py --level_name <specific_level_name>
```

## Training Agents
Melting Pot is agnostic to the RL framework used, but provides a baseline implementation using Ray RLlib.

### RLlib Self-Play Workflow
1. Install example-specific requirements:
   ```bash
   pip install -r examples/requirements.txt
   ```
2. Run the self-play training script:
   ```bash
   cd examples/rllib
   python self_play_train.py
   ```

## Best Practices
- **Social Generalization**: Do not just train on a single substrate. The core value of Melting Pot is evaluating agents on "held-out" scenarios where they must interact with unfamiliar individuals.
- **Debugging**: If agents are not learning, use the `human_players` scripts to verify that the task is solvable and that the reward signals (visible in the HUD during play) are triggering as expected.
- **Environment Compatibility**: Use the provided GitHub Codespace configuration if you encounter dependency conflicts on local Linux or macOS environments, as it provides a pre-validated build of Lab2D.

## Reference documentation
- [Melting Pot Main README](./references/github_com_google-deepmind_meltingpot.md)
- [Documentation Index](./references/github_com_google-deepmind_meltingpot_tree_main_docs.md)