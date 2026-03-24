# consensus-peaks/consensus-peaks-chip-sr CWL Workflow Report

### Metadata
- **Docker Image**: N/A
- **Homepage**: https://iwc.galaxyproject.org/
- **Package**: https://workflowhub.eu/workflows/561
- **Validation**: N/A

- **RO-Crate download**: https://workflowhub.eu/workflows/561/ro_crate?version=12
- **Conda**: N/A
- **Total Downloads**: 36.0K
- **Last updated**: 2026-02-20
- **GitHub**: N/A
- **Stars**: N/A
- **Version**: 12
- **License**: MIT
- **Workflow type**: Galaxy
- **Main workflow (WorkflowHub):** `consensus-peaks-chip-sr.ga` (Main Workflow)
- **Project**: Intergalactic Workflow Commission (IWC)
- **Views**: 14047
- **Creators**: Lucille Delisle

## Description

This workflow takes as input SR BAM from ChIP-seq. It calls peaks on each replicate and intersect them. In parallel, each BAM is subsetted to smallest number of reads. Peaks are called using both subsets combined. Only peaks called using a combination of both subsets which have summits intersecting the intersection of both replicates will be kept.
