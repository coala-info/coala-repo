---
name: pypiper
description: Pypiper is a development-oriented framework designed to wrap command-line tools into cohesive Python scripts.
homepage: http://pypiper.readthedocs.io/en/latest/
---

# pypiper

## Overview
Pypiper is a development-oriented framework designed to wrap command-line tools into cohesive Python scripts. It excels in environments where pipelines are under active development, providing "slick" features like automatic checkpointing (skipping completed steps), resource tracking (CPU/memory), and standardized logging without the overhead of complex DSLs or heavy workflow engines.

## Core Implementation Pattern
To build a pipeline, instantiate a `PipelineManager` and route shell commands through its `run` method.

```python
import pypiper

# 1. Initialize the manager
pm = pypiper.PipelineManager(name="my_pipeline", outfolder="results")

# 2. Define targets and commands
target = "results/processed_data.txt"
cmd = f"tool --input raw.dat --output {target}"

# 3. Execute with pypiper (automatically handles restartability)
pm.run(cmd, target)

# 4. Clean up
pm.stop_pipeline()
```

## Expert Tips & Best Practices

### 1. Effective Restartability
Pypiper determines whether to run a command based on the existence of the `target` file.
- **Always specify `target`**: If `target` is omitted, the command runs every time.
- **Multiple targets**: Pass a list of files if a command produces several outputs. Pypiper will only skip the step if *all* files exist.
- **Clean-up**: Use `pm.clean_intermediate_files()` to remove temporary files once the final target is secured.

### 2. Resource Monitoring
Pypiper automatically tracks the footprint of your pipeline.
- **Timestamps**: Use `pm.timestamp("Section Name")` to delineate stages in the log file.
- **Stats**: Report custom metrics (e.g., alignment rate, read counts) using `pm.report_stats("key", value)`.

### 3. Command-Line Integration
Pypiper automatically adds standard arguments to your script. When you run your Python script, you can use:
- `--recover`: Overwrite existing lock files if a previous run crashed.
- `--new-start`: Force the pipeline to start from the beginning, ignoring existing targets.
- `--stop-at [step]`: Run the pipeline only up to a specific named timestamp.
- `--halt-before [step]`: Stop just before a specific step.

### 4. Robust Error Handling
- **Lock Files**: Pypiper creates a `.lock` file in the output folder to prevent simultaneous runs.
- **Integrity**: If a command fails, Pypiper catches the shell return code and marks the pipeline as failed, preventing downstream steps from running on corrupted data.

## Common CLI Patterns
Once your script (e.g., `pipe.py`) is written, manage it via the terminal:
```bash
# View auto-generated help and available arguments
python pipe.py --help

# Run with a specific configuration file
python pipe.py --config config.yaml

# Force a fresh run even if targets exist
python pipe.py --new-start
```

## Reference documentation
- [Introduction to Pypiper](./references/pypiper_readthedocs_io_en_latest.md)
- [Pypiper Package Overview](./references/anaconda_org_channels_bioconda_packages_pypiper_overview.md)