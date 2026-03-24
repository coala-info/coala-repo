# Combined workflows for large genome assembly CWL Workflow Report

### Metadata
- **Docker Image**: N/A
- **Homepage**: https://usegalaxy.org.au/
- **Package**: https://workflowhub.eu/workflows/230
- **Validation**: N/A

- **RO-Crate download**: https://workflowhub.eu/workflows/230/ro_crate?version=1
- **Conda**: N/A
- **Total Downloads**: 881
- **Last updated**: 2023-01-16
- **GitHub**: N/A
- **Stars**: N/A
- **Version**: 1
- **License**: Apache-2.0
- **Workflow type**: Galaxy
- **Main workflow (WorkflowHub):** `Galaxy-Workflow-Combined_workflows_for_large_genome_assembly.ga` (Main Workflow)
- **Project**: Galaxy Australia
- **Views**: 8501
- **Creators**: Anna Syme

## Description

Combined workflow for large genome assembly

The tutorial document for this workflow is here: https://doi.org/10.5281/zenodo.5655813


What it does:  A workflow for genome assembly, containing subworkflows:
* Data QC
* Kmer counting
* Trim and filter reads
* Assembly with Flye
* Assembly polishing
* Assess genome quality

Inputs: 
* long reads and short reads in fastq format
* reference genome for Quast

Outputs: 
* Data information - QC, kmers
* Filtered, trimmed reads
* Genome assembly, assembly graph, stats
* Polished assembly, stats
* Quality metrics - Busco, Quast

Options
* Omit some steps - e.g. Data QC and kmer counting
* Replace a module with one using a different tool - e.g. change assembly tool

Infrastructure_deployment_metadata: Galaxy Australia (Galaxy)
