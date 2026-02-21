---
name: ervdetective
description: `ervdetective` is a Python-based command-line pipeline designed for the high-throughput discovery and characterization of Endogenous Retroviruses (ERVs).
homepage: https://github.com/ZhijianZhou01/ervdetective
---

# ervdetective

## Overview

`ervdetective` is a Python-based command-line pipeline designed for the high-throughput discovery and characterization of Endogenous Retroviruses (ERVs). It streamlines the complex process of ERV detection by integrating structural searches for Long Terminal Repeats (LTRs) and Target Site Duplications (TSDs) with homology-based protein domain detection. The tool utilizes established bioinformatic engines—specifically BLAST, GenomeTools (ltrharvest), and HMMER—to provide a comprehensive annotation of retroviral elements in genomic FASTA files.

## Core CLI Usage

The primary command is `ervdetective`. All operations require a host genome input and an output directory.

### Basic Execution
```bash
ervdetective -i genome.fasta -p project_prefix -n 8 -o ./results_folder
```

### Key Parameters
- `-i HOST`: Path to the host genome sequence (e.g., .fna, .fas, .fasta).
- `-o OUTPUT`: Path to the output folder for results.
- `-p PREFIX`: Prefix for output filenames (default: 'host').
- `-n THREADS`: Number of CPU threads to utilize (default: 1).

## Structural Detection Tuning

`ervdetective` identifies ERVs based on LTR structures. Adjust these parameters if the default retroviral architecture does not match your target organism.

- **LTR Dimensions**: Use `-l1` (min) and `-l2` (max) to set LTR length (default: 100-1000 bp).
- **LTR Similarity**: Use `-s` to set the percentage similarity between paired LTRs (default: 80).
- **Internal Distance**: Use `-d1` (min) and `-d2` (max) to define the distance between paired LTRs (default: 1000-15000 bp).
- **Motifs and TSDs**:
  - `-motif`: Specify start and end motifs (default: TGCA).
  - `-mis`: Allowed mismatches in the motif (default: 1).
  - `-t1` / `-t2`: Min/Max length for Target Site Duplications (default: 4-6 bp).

## Protein Domain Annotation

The tool uses HMMER to identify viral proteins. You can refine the sensitivity by adjusting e-values and minimum amino acid (aa) lengths for specific domains.

- **Search Sensitivity**:
  - `-eb`: BLAST e-value threshold (default: 1e-5).
  - `-ed`: HMMER e-value threshold (default: 1e-6).
- **Domain Length Thresholds**:
  - `--gag`: GAG protein (default: 250 aa).
  - `--pro`: Protease (default: 50 aa).
  - `--rt`: Reverse Transcriptase (default: 150 aa).
  - `--rh`: RNaseH (default: 65 aa).
  - `--int`: Integrase (default: 150 aa).
  - `--env`: Envelope protein (default: 250 aa).

## Expert Tips and Best Practices

1. **Environment Management**: Always run `ervdetective` within a dedicated Conda environment. This ensures that the specific versions of `blast`, `genometools`, and `hmmer` are correctly mapped to the system's environment variables, which the tool requires for direct calls.
   ```bash
   conda create -n ervdetective_env -c bioconda -c conda-forge ervdetective
   conda activate ervdetective_env
   ```
2. **Input Preparation**: Ensure your FASTA headers are concise. Extremely long or complex headers in the host genome file can sometimes cause issues with the underlying BLAST or HMMER parsers.
3. **Flanking Sequences**: If you need to analyze the genomic context of the insertion, use the `-f` parameter to adjust the length of the extended flank sequence extracted on either side of the hit (default: 15000 bp).
4. **Dependency Verification**: If the tool fails immediately, verify that `makeblastdb`, `tblastn`, `ltrharvest`, `hmmpress`, and `hmmscan` are accessible in your PATH.

## Reference documentation
- [ervdetective - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_ervdetective_overview.md)
- [GitHub - ZhijianZhou01/ervdetective: Identification of endogenous retroviruses (ERVs)](./references/github_com_ZhijianZhou01_ervdetective.md)