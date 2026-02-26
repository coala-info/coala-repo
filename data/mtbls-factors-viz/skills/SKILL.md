---
name: mtbls-factors-viz
description: This tool generates Parallel Sets Hammock plots to visualize relationships and distributions between experimental factors in metabolomics study metadata. Use when user asks to visualize study design factors, identify metadata redundancies, or check for experimental imbalances in MetaboLights studies.
homepage: https://github.com/phnmnl/container-mtbls-factors-viz
---


# mtbls-factors-viz

## Overview

The `mtbls-factors-viz` tool provides a specialized R-based visualization for metabolomics study metadata. It transforms complex factor relationships into static Parallel Sets Hammock plots using the `ggparallel` package. This is essential for researchers needing to audit study designs, identify experimental imbalances, or detect redundant metadata fields (e.g., where "Dose" and "Treatment" provide identical information) within a MetaboLights study or an ISA-Tab document.

## Command Line Usage

The tool is primarily distributed as a Docker container. Ensure you mount your local working directory to the container's `/data` path to manage inputs and outputs.

### Basic Patterns

**Visualize via MetaboLights ID**
To pull metadata directly from the MetaboLights repository and generate a plot:
```bash
docker run -it -v $PWD:/data container-registry.phenomenal-h2020.eu/phnmnl/mtbls-factors-viz -s <MTBLS-ID> -o /data
```

**Visualize via Local JSON Input**
If you have already generated a factor summary JSON (e.g., from the `factors-summary` tool):
```bash
docker run -it -v $PWD:/data container-registry.phenomenal-h2020.eu/phnmnl/mtbls-factors-viz -i /data/factor_summary.json -o /data
```

### Argument Reference
- `-s <ID>`: The MetaboLights Study Identifier (e.g., MTBLS32).
- `-i <FILE>`: Path to an ISA-Tab factors table in JSON format.
- `-o <DIR>`: The output directory where the resulting plot will be saved.

## Best Practices and Expert Tips

- **Identify Redundancy**: Use the resulting plot to look for perfectly aligned flows between columns. If two factors (like "Treatment" and "Dose") show identical branching patterns, they are likely redundant in the metadata.
- **Sample Distribution**: The y-axis represents the number of samples. Use the width of the "hammock" strands to quickly estimate if your study groups are balanced (e.g., checking if one dose level has significantly fewer samples than others).
- **Workflow Integration**: This tool is most effective when used downstream of a factor extraction or summary tool. In a pipeline, pipe the JSON output of a metadata parser directly into the `-i` flag of this tool.
- **Volume Mounting**: Always use absolute paths or `$PWD` when mounting volumes in Docker to ensure the tool can correctly write the output files to your host machine.

## Reference documentation
- [MTBLS Factors Viz README](./references/github_com_phnmnl_container-mtbls-factors-viz.md)