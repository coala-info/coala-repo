---
name: ruffus
description: Ruffus is a lightweight Python library designed to manage and automate computational pipelines by tracking file dependencies through decorators. Use when user asks to manage data processing workflows, track file dependencies between pipeline stages, run tasks in parallel, or generate pipeline flowcharts.
homepage: http://www.ruffus.org.uk/
---


# ruffus

## Overview

Ruffus is a lightweight Python library used to manage computational pipelines. It transforms standard Python functions into pipeline stages by using decorators or an Object-Oriented API to track file dependencies. It is best used when you have a series of data processing steps where the output of one script is the input to the next. Ruffus ensures that only the necessary parts of a pipeline are re-run if files change, supports parallel execution across multiple cores or clusters, and provides built-in support for command-line arguments and flowchart generation.

## Core Workflow Patterns

### 1. Defining Pipeline Stages
Ruffus uses decorators to link functions. The most common decorators include:

*   **@originate**: Generates initial data files that start the pipeline.
*   **@transform**: Performs a 1-to-1 mapping (e.g., converting `.fasta` to `.bam`).
*   **@merge**: Collapses multiple inputs into a single output (e.g., summarizing results).
*   **@split**: Breaks one input into multiple outputs (e.g., chunking a large file).
*   **@collate**: Groups files together based on a common naming pattern (e.g., grouping paired-end reads).
*   **@subdivide**: Splits a single task into multiple sub-tasks for parallel processing.

### 2. File Name Manipulation
Use `formatter()` and `regex()` within decorators to dynamically generate output paths based on input names. This is more robust than manual string manipulation.

```python
from ruffus import *

# Example: Transform .txt to .bak in a 'backup' directory
@transform("data/*.txt", 
            formatter(".*/(?P<FILE_NAME>.*)\.txt$"), 
            "backup/{FILE_NAME[0]}.bak")
def backup_files(input_file, output_file):
    with open(output_file, "w") as out:
        out.write(open(input_file).read())
```

### 3. Command Line Integration
Always use `ruffus.cmdline` to provide a standard interface for your pipeline scripts. This automatically adds flags for `--jobs` (parallelism), `--flowchart`, `--forced-tasks`, and `--verbose`.

```python
from ruffus import cmdline

parser = cmdline.get_argparse(description="My Pipeline")
options = parser.parse_args()

# Run the pipeline using the parsed options
cmdline.run(options)
```

### 4. Object-Oriented Syntax (v2.6+)
For modular pipelines or sub-pipelines, use the `Pipeline` class instead of global decorators. This allows you to define pipelines in separate modules and join them at runtime.

```python
my_pipeline = Pipeline(name="analysis")
my_pipeline.transform(task_func=process_data, 
                      input=starting_files, 
                      filter=suffix(".dat"), 
                      output=".result")
my_pipeline.run()
```

## Best Practices and Expert Tips

*   **Dry Runs**: Use `pipeline_printout(sys.stdout, [target_task])` to see which jobs will run without actually executing them.
*   **Visualization**: Use `pipeline_printout_graph("flowchart.png")` to generate a visual representation of your pipeline topology. This requires Graphviz (`dot`) to be installed.
*   **Checkpointing**: Ruffus relies on file modification times. If a task fails, the output file won't be created (or will be older than the input), ensuring the task runs again on the next attempt.
*   **Logging**: Use `ruffus.proxy_logger` when running in parallel to ensure log messages from different processes don't interleave and corrupt the output.
*   **Soft Linking**: For the first step of a pipeline, consider soft-linking original data into a "working" directory to keep raw data pristine while allowing the pipeline to manage its own file space.
*   **Resource Management**: Use `@jobs_limit(n)` on specific tasks that are memory-intensive to prevent them from overwhelming the system during parallel execution.

## Reference documentation
- [Ruffus Index](./references/www_ruffus_org_uk_index.md)
- [New Object Orientated Syntax](./references/www_ruffus_org_uk_tutorials_new_syntax.html.md)
- [Ruffus FAQ](./references/www_ruffus_org_uk_faq.html.md)
- [Installation Guide](./references/www_ruffus_org_uk_installation.html.md)