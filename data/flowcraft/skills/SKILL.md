---
name: flowcraft
description: FlowCraft is a pipeline composer that builds reproducible genomics workflows by stitching together bioinformatics components into Nextflow files. Use when user asks to build a sequencing pipeline, generate a Nextflow workflow from specific tools, or inspect and report on active genomic analysis runs.
homepage: https://github.com/assemblerflow/flowcraft
---

# flowcraft

## Overview
FlowCraft is a specialized pipeline composer designed for omics analysis. It allows you to build complex, reproducible genomics workflows by stitching together pre-defined components (like Trimmomatic, SPAdes, or FastQC) into a single Nextflow pipeline. This skill provides the necessary CLI patterns to transition from a list of desired bioinformatics tools to a fully functional, containerized pipeline ready for local or cluster execution.

## Core Workflows

### Building a Pipeline
The primary function of FlowCraft is the `build` mode. It takes a string of components and generates a `.nf` Nextflow file.

- **Basic Assembly**: `flowcraft build -t "component1 component2 component3" -o pipeline_name.nf`
- **Named Pipelines**: Use `-n "Project Name"` to add a custom header to the generated pipeline.
- **Component Selection**: Ensure the output type of one component matches the input type of the next (e.g., FastQ -> Assembly -> Annotation).

### Running the Generated Pipeline
Once built, the pipeline is executed via Nextflow. FlowCraft pipelines are designed to use Docker or Singularity by default.

- **Local Execution**: `nextflow run my_pipeline.nf --fastq "path/to/reads/*_{1,2}.*"`
- **Cluster Execution (SLURM)**: `nextflow run my_pipeline.nf --fastq "path/to/reads/*_{1,2}.*" -profile slurm_sing`
- **Input Patterns**: Always provide the path expression for paired-end files using the `{1,2}` glob pattern to ensure correct sample pairing.

### Inspection and Reporting
FlowCraft provides built-in tools to monitor and visualize results without manually parsing log files.

- **Real-time Inspection**: Run `flowcraft inspect` in the directory where a pipeline is currently running to view a terminal-based progress dashboard.
- **Generating Reports**: Use the `report` mode to compile component-specific results into a visual format compatible with the FlowCraft web app.

## Expert Tips and Best Practices

- **Parameter Discovery**: Every generated pipeline has a dynamic help menu. Run `nextflow run my_pipeline.nf --help` to see the specific flags for every component in your string (e.g., `--trimMinLength_1_2` for a Trimmomatic component at position 1.2).
- **Dependency Management**: Avoid installing individual bioinformatics tools. FlowCraft leverages Bioconda and containers; ensure either Docker or Singularity is installed and accessible in your environment.
- **Resource Control**: For large-scale runs, use the `clearInput` parameter (if available in your version) to remove temporary files between process steps and save disk space.



## Subcommands

| Command | Description |
|---------|-------------|
| flowcraft build | Build a pipeline using flowcraft. |
| flowcraft inspect | Inspect Nextflow runs |
| flowcraft_report | Generate a report from pipeline execution data. |

## Reference documentation
- [FlowCraft GitHub Overview](./references/github_com_assemblerflow_flowcraft.md)
- [FlowCraft Roadmap and Features](./references/github_com_assemblerflow_flowcraft_wiki_Roadmap.md)