---
name: pigpen
description: PIGPEN is a bioinformatics suite designed to detect and quantify oxidative marks on RNA molecules by analyzing nucleotide conversions in sequencing data. Use when user asks to identify 8-oxoguanosine positions, quantify RNA localization at subcellular sites, or perform differential oxidation analysis.
homepage: https://github.com/TaliaferroLab/OINC-seq
metadata:
  docker_image: "quay.io/biocontainers/pigpen:0.0.9--pyhdfd78af_0"
---

# pigpen

## Overview
PIGPEN (Pipeline for Identification of Guanosine Positions Erroneously Notated) is a bioinformatics suite designed to detect and quantify oxidative marks on RNA molecules. It leverages the fact that guanosine oxidation (forming 8-oxoguanosine) causes predictable nucleotide conversions during reverse transcription. By using spatially restricted oxidation, PIGPEN allows users to quantify RNA localization and abundance at specific subcellular sites. The workflow transitions from raw sequencing reads to gene-level oxidation quantifications through a structured pipeline of alignment, transcript assignment, and error analysis.

## Installation and Environment
The most reliable way to deploy PIGPEN is via Bioconda. Note that `postmaster` (a Rust-based dependency) often requires a separate installation step.

```bash
# Install PIGPEN
conda install -c bioconda pigpen

# Install required postmaster dependency
cargo install --git https://github.com/COMBINE-lab/postmaster
```

## Core Workflow

### 1. Pre-processing (Alignment and Quantification)
Use `alignAndQuant` to generate the required directory structure and files. This tool runs STAR for alignment, Salmon for quantification, and Postmaster for posterior probabilities.

**Standard Command:**
```bash
alignAndQuant --forwardreads reads.r1.fq.gz \
              --reversereads reads.r2.fq.gz \
              --nthreads 32 \
              --STARindex /path/to/STARindex \
              --salmonindex /path/to/salmonindex \
              --samplename sample1
```

**Best Practices:**
*   **Strandedness:** PIGPEN requires stranded paired-end reads where Read 1 corresponds to the sense strand.
*   **Mapping Quality:** The pipeline only considers uniquely aligned reads (MAPQ 255) to minimize false-positive mutation calls from poor alignments.
*   **Indices:** Ensure STAR and Salmon indices are generated using the same reference genome version.

### 2. Identifying Conversions
Once `alignAndQuant` has processed all samples, run `pigpen` from the parent working directory.

**Standard Command:**
```bash
pigpen --samplenames sample1,sample2,sample3 \
       --controlsamples sample1 \
       --genome /path/to/genome.fa \
       --gff /path/to/annotation.gff
```

**Key Arguments:**
*   `--samplenames`: A comma-separated list of all samples to analyze.
*   `--controlsamples`: Samples where oxidation was not induced. These are critical for filtering out SNPs and background sequencing errors.
*   `--use_gffutils`: Recommended for handling complex gene annotations.

### 3. Statistical Analysis
Use `bacon` or `bacon_glm` to perform differential oxidation analysis between conditions.

```bash
bacon -h
# or
bacon_glm [options]
```

## Directory Structure Requirements
PIGPEN expects a specific nested directory format. `alignAndQuant` creates this automatically, but manual organization must follow this pattern:

```text
workingdir/
└── sample1/
    ├── STAR/       # BAM files and indices
    ├── salmon/     # quant.sf and salmon.bam
    └── postmaster/ # postmaster.bam
```

## Expert Tips
*   **SNP Filtering:** Always include high-quality control samples. Because 8-OG conversions are rare, failing to filter out biological SNPs will significantly skew localization results.
*   **Memory Management:** STAR alignment is memory-intensive. Ensure your environment has sufficient RAM (typically 30GB+ for human/mouse genomes) when running `alignAndQuant`.
*   **UMI Collapsing:** If your library uses Unique Molecular Identifiers, ensure `umi_tools` is in your PATH and use the appropriate flags during the alignment phase to remove PCR duplicates.

## Reference documentation
- [PIGPEN GitHub README](./references/github_com_TaliaferroLab_OINC-seq.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_pigpen_overview.md)