---
name: nifflr
description: NIFFLR reconstructs and quantifies the transcriptome by aligning reference exons to long-read sequencing data to identify known and novel isoforms. Use when user asks to reconstruct the transcriptome, quantify transcript expression, identify novel isoforms, or detect high-confidence splicing events from long-read sequencing data.
homepage: https://github.com/alguoo314/NIFFLR
metadata:
  docker_image: "quay.io/biocontainers/nifflr:2.0.0--pl5321haf24da9_0"
---

# nifflr

## Overview
NIFFLR (Novel IsoForm Finder using Long RNASeq reads) is a bioinformatics tool designed to reconstruct and quantify the transcriptome using the structural evidence provided by long-read sequencing. Unlike tools that rely solely on de novo assembly or reference mapping, NIFFLR aligns exons from a reference annotation to long reads to recover known transcripts and identify novel isoforms. It is particularly effective for researchers who need to discover high-confidence novel splicing events and quantify transcript expression levels in a single workflow.

## Command Line Usage
The primary executable is `nifflr.sh`. It requires a reference genome, a corresponding GTF annotation, and the long-read sequence data.

### Basic Execution
```bash
nifflr.sh -f reads.fastq -r genome.fasta -g annotation.gtf -p my_analysis
```

### Input Handling
- **Multiple Files**: If you have multiple input files, they must be passed as a single string enclosed in single quotes.
  ```bash
  nifflr.sh -f 'run1.fastq run2.fastq run3.fastq' -r ref.fa -g genes.gtf -p combined_sample
  ```
- **Format Support**: The tool accepts both FASTA and FASTQ formats, and files can be gzipped (.gz).

## Parameter Tuning and Best Practices
- **Novelty Filtering**: The `-n` (novel) and `-k` (known) flags control the minimum intron junction coverage required for detection. 
    - The default for novel transcripts is `2.0`. In high-coverage datasets, increase this (e.g., `-n 5.0`) to filter out low-evidence noise.
    - The default for known transcripts is `0.0`, allowing detection of any annotated isoform with even minimal read support.
- **Alignment Sensitivity**:
    - **K-mer Size (`-m`)**: Default is 12. 
    - **Exon Base Match (`-B`)**: Default is 35.0. This represents the minimum percentage of exon bases that must match K-mers. Lowering this value may increase sensitivity for very noisy reads but can lead to false positive isoform calls.
- **Structural Constraints**: The `-e` parameter (default 15) defines the maximum allowed gap or overlap between adjacent aligned exons. Adjust this if working with species known for non-standard splice site distances or if using specific library prep methods that introduce consistent artifacts.
- **Performance**: NIFFLR defaults to 16 threads (`-t 16`). Ensure your environment matches this or adjust accordingly to prevent resource contention.

## Output Analysis
NIFFLR produces two main output files based on the provided `--prefix`:

1.  **`<prefix>.quantify.tsv`**: A four-column tab-separated file.
    - `transcript_id`: Reference ID or `TCONS_*` for novel isoforms.
    - `read_count`: Number of reads assigned to that specific transcript.
    - `intron chain`: The specific sequence of introns defining the isoform.
    - `min_junction_count`: The lowest read support found across any single junction in that transcript.
2.  **`<prefix>.transcripts.gtf`**: A standard GTF file containing the structures of all detected transcripts. 
    - **Pro Tip**: To quickly extract only the novel isoforms discovered by NIFFLR, grep for the "nifflr" source tag in the second column of the GTF.

## Reference documentation
- [NIFFLR Overview](./references/anaconda_org_channels_bioconda_packages_nifflr_overview.md)
- [NIFFLR GitHub Documentation](./references/github_com_alguoo314_NIFFLR.md)