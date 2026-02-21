---
name: megapath-nano
description: MegaPath-Nano is a specialized bioinformatics suite designed to handle the unique challenges of Oxford Nanopore Technologies (ONT) long-read metagenomic data.
homepage: https://github.com/HKU-BAL/MegaPath-Nano
---

# megapath-nano

## Overview
MegaPath-Nano is a specialized bioinformatics suite designed to handle the unique challenges of Oxford Nanopore Technologies (ONT) long-read metagenomic data. While ONT provides long reads that improve alignment specificity, the high error rate can complicate pathogen identification and AMR detection. MegaPath-Nano solves this by using global optimization for read reassignment and a consensus-based AMR detection approach that integrates multiple databases and tools. It provides a streamlined workflow for data cleansing, taxonomic profiling down to the strain level, and comprehensive AMR reporting.

## Installation and Database Setup
Before running analysis, ensure the environment is configured and databases are initialized.

### Environment Setup (Bioconda)
```bash
conda create -n mpn -c bioconda megapath-nano
conda activate mpn
```

### Essential Database Initialization
The tool requires specific databases for taxonomic and AMR modules.
1. **Taxon Database**: Download and extract the pre-built database into the tool directory.
2. **AMR Databases**:
   - **RGI/CARD**: `rgi load --card_json bin/amr_db/card/card.json`
   - **AMRFinderPlus**: `amrfinder -u`

## Common CLI Patterns

### 1. Full Metagenomic Workflow
Performs data cleansing, taxonomic profiling, and AMR detection in a single run.
```bash
python megapath_nano.py --query sample.fastq --output_folder ./results --max_aligner_thread 16
```

### 2. Module-Specific Execution
If only one type of analysis is required, use the following flags to save time and compute resources:
- **Taxonomic Profiling Only**: `python megapath_nano.py --query sample.fastq --taxon_module_only`
- **AMR Detection Only (from reads)**: `python megapath_nano.py --query sample.fastq --AMR_module_only`
- **Data Filtering Only**: `python megapath_nano.py --query sample.fastq --filter_fq_only`
  - *Note: This performs adaptor trimming, human/decoy read filtering, and general quality trimming.*

### 3. AMR Detection from BAM
If you have already aligned your reads, run the AMR module directly on the BAM file.
```bash
python megapath_nano_amr.py --query_bam aligned_reads.bam --output_folder ./amr_results --threads 8
```

### 4. Amplicon Data Filtering
For metagenomic amplicon data, use the dedicated filtering module:
```bash
./MegaPath-Nano/bin/runMegaPath-Nano-Amplicon.sh -r sample.fastq
```

## Expert Tips and Best Practices
- **Thread Optimization**: Use `--max_aligner_thread` to control CPU usage. The tool will automatically use the minimum of your specified value and the actual available cores.
- **Organism-Specific AMR**: When running `megapath_nano_amr.py`, use the `--taxon` flag (e.g., `--taxon Escherichia`) to enable curated organism-specific searches in AMRFinderPlus, which significantly improves detection accuracy for known pathogens.
- **Memory Management**: Ensure at least 80GB of storage is available for the full database suite.
- **Input Formats**: The main script accepts both `.fastq` and `.fasta` files. For AMR-only runs from assemblies, `.fasta` is preferred.
- **Output Interpretation**: 
  - The taxonomic report provides abundance estimates down to the strain level.
  - The AMR report is an integrated table combining results from multiple underlying tools, providing a "consensus" view of resistance.

## Reference documentation
- [MegaPath-Nano GitHub Repository](./references/github_com_HKU-BAL_MegaPath-Nano.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_megapath-nano_overview.md)