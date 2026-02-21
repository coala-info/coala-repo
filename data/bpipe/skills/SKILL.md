---
name: bpipe
description: Bpipe is a tool for managing data analysis pipelines, specifically designed for bioinformatics.
homepage: http://docs.bpipe.org/
---

# bpipe

## Overview
Bpipe is a tool for managing data analysis pipelines, specifically designed for bioinformatics. It acts as a wrapper for shell commands, providing automatic dependency tracking, transactional file management (cleaning up failed outputs), and systematic naming of intermediate files. Use this skill to transform fragile bash scripts into robust, restartable workflows that maintain an audit trail and support easy parallelism without manual file naming.

## Core Syntax and Workflow
Bpipe scripts use a Groovy-based syntax to define stages and a `run` block to define the execution order.

### Defining Stages
Wrap shell commands in a named block using the `exec` command.
```groovy
align = {
    exec "bwa aln $REFERENCE $input > $output.sai"
}
```
- Use triple quotes `"""` for multi-line commands.
- Bpipe handles multi-line commands without needing backslashes `\`.

### Input and Output Variables
Avoid hardcoding filenames. Use Bpipe's automatic variables:
- `$input`: The file(s) coming from the previous stage.
- `$output`: The file(s) to be created by the current stage.
- `$input.extension`: References an input with a specific extension (e.g., `$input.bam`).
- `$output.extension`: Tells Bpipe to name the output using the input's base name plus the new extension.

### Pipeline Execution
Define the flow at the bottom of the script:
```groovy
run { 
    align + sort + dedupe + index + call_variants 
}
```

## CLI Usage Patterns
- **Run a pipeline**: `bpipe run pipeline.txt <input_files>`
- **Test/Dry run**: `bpipe test pipeline.txt <input_files>` (shows what will run without executing).
- **Check status**: `bpipe status` (shows currently running jobs).
- **View history**: `bpipe history` (shows previous runs and audit trail).
- **Cleanup**: `bpipe cleanup` (removes intermediate files that are not final outputs).
- **Retry**: `bpipe retry` (restarts the pipeline from the point of failure).

## Best Practices
- **Forwarding**: If a stage produces a sidecar file (like an index `.bai`) that shouldn't be the primary input for the next stage, use `forward input` to pass the original BAM file along instead.
- **Variables**: Define tool paths and reference genomes at the top of the script for easy configuration.
- **Parallelism**: Bpipe handles parallelism automatically when multiple inputs are provided or when using the `multi` or `split` operators (e.g., `align + [stageA, stageB]`).
- **Transactional Safety**: If a command fails, Bpipe automatically deletes the partial `$output` file to prevent downstream stages from running on corrupted data.

## Reference documentation
- [Real Pipeline Tutorial](./references/docs_bpipe_org_Tutorials_RealPipelineTutorial.md)
- [Bpipe Overview and Features](./references/docs_bpipe_org_index.md)