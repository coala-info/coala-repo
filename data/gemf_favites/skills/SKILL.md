---
name: gemf_favites
description: This tool simulates stochastic epidemic processes on contact networks using the Generalized Epidemic Modeling Framework. Use when user asks to simulate disease spread, model state transitions in a contact network, or run GEMF simulations within the FAVITES ecosystem.
homepage: https://github.com/niemasd/GEMF
metadata:
  docker_image: "quay.io/biocontainers/gemf_favites:1.0.3--h7b50bb2_1"
---

# gemf_favites

## Overview
The `gemf_favites` skill provides a streamlined interface for running the Generalized Epidemic Modeling Framework (GEMF) within the FAVITES ecosystem. It simplifies the process of converting complex contact networks and transmission parameters into the specific formats required by the GEMF C engine. Use this tool to simulate stochastic epidemic processes where transitions between states (e.g., Susceptible to Exposed) are driven either by internal nodal logic or by contact with individuals in specific "inducer" states.

## Core CLI Usage
The primary command is `GEMF_FAVITES.py`. Ensure the `GEMF` executable is in your PATH or specified via `--gemf_path`.

```bash
GEMF_FAVITES.py -c network.tsv -s initial_states.tsv -i infected_states.txt -r rates.tsv -t 100 -o output_dir/
```

### Required Arguments
- `-c, --contact_network`: Path to the TSV contact network (FAVITES format).
- `-s, --initial_states`: TSV file mapping every node to its starting state at time 0.
- `-i, --infected_states`: A simple text file listing states considered "infected" (one per line).
- `-r, --rates`: TSV file defining the transmission model transitions.
- `-t, --end_time`: The simulation time limit.
- `-o, --output`: Directory where results and intermediate GEMF files will be stored.

## Input File Specifications

### State Transition Rates (-r)
This is the most critical file for defining your model. It uses a 4-column TSV format: `FromState`, `ToState`, `ByState`, `Rate`.
- **Nodal Transitions**: Set the `ByState` column to `None`. The transition occurs as a Poisson process with the specified rate.
- **Edge-based Transitions**: Specify an inducer state in the `ByState` column. The actual rate for a node $u$ is the specified rate multiplied by the number of $u$'s neighbors currently in that inducer state.

**Example (SEIR Model):**
```text
S	E	I	2.5
E	I	None	0.5
I	R	None	0.1
```

### Contact Network (-c)
Uses the FAVITES format. Ensure columns are separated by single tabs.
- `NODE	Label	Attributes`
- `EDGE	U	V	Attributes	d/u` (d=directed, u=undirected)

## Expert Tips and Best Practices
- **Reproducibility**: Always use the `--rng_seed` flag when running simulations for publication or debugging to ensure identical results across runs.
- **Performance**: For large networks or long timeframes, avoid `--output_all_transitions` unless you specifically need the full history of every state change, as it significantly increases I/O overhead and output size.
- **State Consistency**: Ensure every state mentioned in your `rates` file is accounted for in your `initial_states` file, even if zero individuals start in that state.
- **GEMF Pathing**: If you are running in a containerized or non-standard environment, use `--gemf_path` to point directly to the compiled GEMF C binary to avoid "command not found" errors.
- **Output Analysis**: The primary result is `transmission_network.txt`. If the simulation ends prematurely, check `log.txt` in the output directory for GEMF engine errors.

## Reference documentation
- [GEMF GitHub Repository](./references/github_com_niemasd_GEMF.md)
- [Bioconda gemf_favites Overview](./references/anaconda_org_channels_bioconda_packages_gemf_favites_overview.md)