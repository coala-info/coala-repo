---
name: ibdne
description: The ibdne tool estimates the historical effective population size of specific ancestral components within an admixed population by integrating local ancestry inference with IBD segment analysis. Use when user asks to reconstruct demographic histories for distinct lineages, estimate ancestral effective population size, or analyze IBD segments in admixed cohorts.
homepage: https://github.com/hennlab/AS-IBDNe
---


# ibdne

## Overview
The ibdne skill provides a specialized workflow for estimating the historical effective population size ($N_e$) of specific ancestral components within an admixed population. By integrating local ancestry inference (LAI) with IBD segment analysis, the pipeline allows for the reconstruction of demographic histories for distinct lineages that have merged in recent history. This tool is essential for researchers working with complex, multi-way admixed cohorts where standard IBDne approaches would fail to distinguish between ancestral sources.

## Environment Setup
The pipeline relies on a specific Conda environment to manage its bioinformatics dependencies.
1. Create the environment: `conda create -n IBDne-env`
2. Activate the environment: `conda activate IBDne-env`
3. Install core dependencies:
   - Bioconda: `htslib`, `tabix`, `bcftools`, `rfmix`, `shapeit`
   - R: `r-magrittr`, `r-doparallel`
   - Python: `pandas`, `matplotlib`
   - Other: `brewer2mpl`

## Directory Structure and Inputs
The workflow requires a specific organizational structure in the working directory. Ensure the following components are present:
- **Snakefile**: The primary workflow definition file.
- **data/**: Contains the input fileset in PLINK format (`{dataset}.bim`, `{dataset}.bed`, `{dataset}.fam`). This fileset must contain both admixed and reference individuals.
- **scripts/**: Contains the utility scripts for processing RFMix output and formatting IBD data (e.g., `shapeit_to_germline.py`, `msp_to_vit.py`, `plot_ibdne.R`).
- **progs/**: Contains the required Java executables: `ibdne.05May18.1c3.jar`, `refined-ibd.17Jan20.102.jar`, and `filtercolumns.jar`.

## Configuration Parameters
The pipeline is controlled via a configuration file. Ensure the following parameters are defined (do not use YAML code blocks for the configuration itself):
- **dataset**: The prefix of your input PLINK files.
- **rfmix_genmap**: Path to the genetic map used for RFMix (columns: chromosome, bp, recombination rate).
- **smpmap**: A tab-delimited file mapping reference IDs to their respective ancestries.
- **admix_samples**: A single-column file listing the IDs of admixed individuals.
- **ref**: The path prefix for 1000 Genomes reference files (legend, hap, and sample files).
- **chr_gmap**: Path to individual chromosome genetic maps (columns: bp, Rate cM/Mb, Map cM).
- **mincM**: The minimum centimorgan length for IBD segments to be included in the $N_e$ estimation.
- **colors**: A comma-separated list of colors for output plots, assigned to ancestries in alphabetical order.

## Execution Workflow
1. **Pre-processing QC**: Run PLINK quality control on your merged dataset before starting the pipeline (e.g., `--geno 0.05 --mind 0.1 --make-bed`).
2. **Dry Run**: Always validate the execution plan first:
   `snakemake --configfile config.yaml -j [threads] -n`
3. **DAG Visualization**: To inspect the workflow logic:
   `snakemake --configfile config.yaml --rulegraph | dot -Tpng > rulegraph.png`
4. **Production Run**: Execute the pipeline using `nice` to manage system priority:
   `nice snakemake --configfile config.yaml -j [threads]`

## Expert Tips and Best Practices
- **Ancestry Validation**: For datasets with more than three reference populations, it is recommended to run a global ancestry analysis (like ADMIXTURE) and compare the results with the RFMix-derived proportions to ensure local ancestry inference accuracy.
- **Color Consistency**: Because colors are assigned alphabetically by ancestry name, ensure your color list matches the sorted order of your reference populations to avoid misleading visualizations.
- **Phasing**: The pipeline utilizes SHAPEIT for phasing. Ensure your reference panel paths in the configuration are correctly formatted and do not include the chromosome number in the prefix if the pipeline expects to append it automatically.
- **Output Interpretation**: The pipeline generates individual karyograms for every admixed person and a consolidated IBDNe plot showing the $N_e$ estimates for each ancestral component.

## Reference documentation
- [AS-IBDNe Main Repository](./references/github_com_hennlab_AS-IBDNe.md)
- [Pipeline Scripts](./references/github_com_hennlab_AS-IBDNe_tree_main_scripts.md)