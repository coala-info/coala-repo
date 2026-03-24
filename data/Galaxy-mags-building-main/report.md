# mags-building/main CWL Workflow Report

### Metadata
- **Docker Image**: N/A
- **Homepage**: https://iwc.galaxyproject.org/
- **Package**: https://workflowhub.eu/workflows/1352
- **Validation**: N/A

- **RO-Crate download**: https://workflowhub.eu/workflows/1352/ro_crate?version=4
- **Conda**: N/A
- **Total Downloads**: 7.8K
- **Last updated**: 2025-11-27
- **GitHub**: N/A
- **Stars**: N/A
- **Version**: 4
- **License**: MIT
- **Workflow type**: Galaxy
- **Main workflow (WorkflowHub):** `MAGs-generation.ga` (Main Workflow)
- **Project**: Intergalactic Workflow Commission (IWC)
- **Views**: 3203
- **Creators**: Bérénice Batut, Paul Zierep, Mina Hojat Ansari, Patrick Bühler, Santino Faack

## Description

This workflow constructs Metagenome-Assembled Genomes (MAGs) using SPAdes or MEGAHIT as assemblers, followed by binning with four different tools and refinement using Binette. The resulting MAGs are dereplicated across the entire input sample set, then annotated and evaluated for quality.
You can provide pooled reads (for co-assembly/binning), individual read sets, or a combination of both. The input samples must consist of the original reads, which are used for abundance estimation. In all cases, reads should be trimmed, adapters removed, and cleaned of host or other contaminants before processing.
