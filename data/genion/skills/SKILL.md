---
name: genion
description: "genion detects gene fusions and readthrough events from long-read RNA-seq data by analyzing genomic mappings and gene annotations. Use when user asks to detect gene fusions, identify readthrough events, or filter false positive chimeric transcripts in long-read sequencing data."
homepage: https://github.com/vpc-ccg/genion
---


# genion

## Overview
genion is a specialized tool designed to detect gene fusions from long-read RNA-seq data. Unlike traditional short-read methods, genion utilizes the full-length information of long reads to provide more accurate fusion calls. It functions as a post-mapping analyzer that integrates genomic mappings, gene annotations, and homology data to calculate specific metrics like the ffigf-score and FiN-score, which help in filtering out false positives and categorizing events as either Gene Fusions (GF) or Readthroughs (RT).

## Installation and Setup
The most reliable way to use genion is via Bioconda or Docker to ensure all C++ dependencies (gcc >= 9, zlib) are met.

- **Conda**: `conda install -c bioconda genion`
- **Docker**: `docker run --user=$UID -v /path/to/data:/data genion:latest [args]`

## Required Input Files
To run a successful analysis, you must prepare five specific inputs:
1. **Long Reads (`-i`)**: FASTQ or FASTA format. Used for low-complexity sequence filtering.
2. **Genomic Mapping (`-g` or `--gpaf`)**: A PAF file of reads mapped to the genome. Use a splice-aware mapper like `minimap2` or `deSALT`. If your mapper outputs SAM, convert it to PAF using `paftools`.
3. **Gene Annotation (`--gtf`)**: Standard GTF file (e.g., ENSEMBL or GENCODE).
4. **Sequence Similarity (`-s`)**: A TSV file containing transcript pairs with high homology. This is critical for filtering false fusions between similar genes.
5. **Duplication Annotation (`-d`)**: Genomic segmental duplication file (e.g., `genomicSuperDups.txt` from UCSC).

## Command Line Usage
The basic execution pattern for genion is:

```bash
genion -i reads.fastq \
       -g mapping.paf \
       --gtf annotation.gtf \
       -s homology.tsv \
       -d genomicSuperDups.txt \
       -t [threads] \
       -o output.tsv
```

### Generating the Homology File (`-s`)
If you do not have a homology TSV, you must generate it by self-aligning your cDNA reference:
1. Align cDNA to itself: `minimap2 cdna.fa cdna.fa -X -t 8 -2 -c -o cdna.selfalign.paf`
2. Process the PAF into the required 2-column TSV:
   ```bash
   cat cdna.selfalign.paf | cut -f1,6 | sed 's/_/\t/g' | \
   awk 'BEGIN{OFS="\t";}{print substr($1,1,15),substr($2,1,15),substr($3,1,15),substr($4,1,15);}' | \
   awk '$1!=$3' | sort | uniq > cdna.self.tsv
   ```

## Interpreting Results
The primary output is a tab-separated file containing several key columns:
- **ffigf-score**: Ratio of fusion-supporting reads to total reads mapping to either gene. High scores indicate stronger evidence for a fusion over normal expression.
- **FiN-score**: Ratio of fusion reads to the sum of normal (non-chimeric) reads for both genes.
- **pass-fail-code**: 
    - `PASS:GF`: Confirmed Gene Fusion.
    - `PASS:RT`: Confirmed Readthrough event.
    - `FAIL::reason`: Filtered candidate (e.g., due to homology or duplication).
- **ranges**: Median genomic intervals of the expressed parts of the member genes.

## Expert Tips
- **Low Complexity Filtering**: genion automatically filters low-complexity sequences to reduce noise. If you get empty results, check if your reads are being flagged as low complexity in the `.log` file.
- **Memory Management**: For large datasets, ensure your system has sufficient RAM for the GTF and homology index loading.
- **Mapping Quality**: Since genion does not perform its own mapping, the quality of your fusion calls is highly dependent on the splice-aware accuracy of your initial PAF file.

## Reference documentation
- [genion GitHub Repository](./references/github_com_vpc-ccg_genion.md)
- [Bioconda genion Overview](./references/anaconda_org_channels_bioconda_packages_genion_overview.md)