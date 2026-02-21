---
name: aquila_umap
description: `aquila_umap` is a utility designed to calculate the uniqueness of genomic regions by identifying k-mers that map uniquely to a reference assembly.
homepage: https://github.com/maiziex/Aquila_Umap
---

# aquila_umap

## Overview
`aquila_umap` is a utility designed to calculate the uniqueness of genomic regions by identifying k-mers that map uniquely to a reference assembly. This tool is a prerequisite for the Aquila diploid assembly workflow, as it provides the necessary mapability information to distinguish between homologous sequences. It supports multi-threaded processing across chromosome ranges and allows users to define k-mer lengths and mapping quality thresholds.

## Command Line Usage

### Basic Syntax
The primary command for generating a uniqueness map is:

```bash
aquila_umap --fa_folder <input_dir> --fa_name <reference.fa> --out_dir <output_dir> [options]
```

### Required Parameters
- `--fa_folder`: The absolute path to the directory containing your reference FASTA files.
- `--fa_name`: The filename of the reference FASTA (e.g., `hg38.fa`).
- `--out_dir`: The directory where the resulting uniqueness maps will be stored.

### Optional Parameters and Tuning
- `--kmer_len`: (Default: 100) The length of the k-mers generated for uniqueness testing. Adjust based on the expected read length or complexity of the genome.
- `--mapq_thres`: (Default: 50000) The threshold used to define unique mapping. Note that in the context of this tool, this often refers to a length-based or score-based filter for unique k-mer segments.
- `--chr_thread`: (Default: 2) Number of threads to use for processing chromosomes in parallel. Increase this on high-performance systems to reduce runtime.
- `--chr_start` and `--chr_end`: Used to limit processing to a specific range of chromosomes. For example, `--chr_start 1 --chr_end 5` processes chromosomes 1 through 5. To process a single chromosome (e.g., chr 2), use `--chr_start 2 --chr_end 2`.

## Workflow Best Practices

### Input Preparation
Ensure your reference FASTA file is indexed and that the `--fa_folder` contains only the necessary genomic files to avoid processing overhead. The tool expects standard FASTA formatting.

### Parallelization Strategy
When working with large mammalian genomes (like Human or Rhesus macaque), utilize the `--chr_start` and `--chr_end` flags to batch process chromosomes if system memory is a constraint. For a full human genome run, ensure `--chr_end` is set to 23 (to include X) or 24 (to include Y), depending on the reference naming convention.

### Output Structure
The tool creates a subfolder named `Uniqness_map` within your specified `--out_dir`. The final results are stored as Python pickle files (`.p` extension), named according to the chromosome (e.g., `uniq_map_chr1.p`). These files are directly consumed by the main Aquila assembly stages.

## Reference documentation
- [Aquila_Umap README](./references/github_com_maiziex_Aquila_Umap_blob_master_README.md)
- [Aquila_Umap Overview](./references/anaconda_org_channels_bioconda_packages_aquila_umap_overview.md)