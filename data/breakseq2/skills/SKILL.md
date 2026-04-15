---
name: breakseq2
description: BreakSeq2 characterizes structural variants at nucleotide resolution by aligning genomic reads to a breakpoint library of junction sequences. Use when user asks to identify structural variants, map breakpoint coordinates, or validate deletions using a breakpoint library.
homepage: http://bioinform.github.io/breakseq2
metadata:
  docker_image: "quay.io/biocontainers/breakseq2:2.2--py27_0"
---

# breakseq2

## Overview
BreakSeq2 is a specialized bioinformatics tool designed for the rapid and accurate characterization of structural variants at nucleotide resolution. Unlike general SV callers that infer variants from genomic alignments, BreakSeq2 utilizes a breakpoint library—a collection of sequences representing known or predicted junction sequences. By aligning reads directly to these junctions using BWA, it provides high-confidence validation and precise coordinate mapping for deletions and other structural rearrangements.

## Command Line Usage

The primary interface for the tool is the `run_breakseq2.py` script.

### Basic Execution Patterns

**Using a FASTA Breakpoint Library:**
```bash
run_breakseq2.py \
  --reference reference.fasta \
  --bams input.bam \
  --work output_dir \
  --bwa /path/to/bwa \
  --samtools /path/to/samtools \
  --bplib library.fa \
  --nthreads 4
```

**Using a GFF Breakpoint Library:**
When using GFF format, BreakSeq2 requires a corresponding insertion sequence file with the `.ins` suffix in the same directory as the GFF.
```bash
run_breakseq2.py \
  --reference reference.fasta \
  --bams input.bam \
  --work output_dir \
  --bwa /path/to/bwa \
  --samtools /path/to/samtools \
  --bplib_gff library.gff \
  --sample NA12878
```

### Key Arguments

| Argument | Description |
| :--- | :--- |
| `--reference` | Path to the reference genome in FASTA format. |
| `--bams` | One or more BAM files containing read alignments. |
| `--work` | Directory for intermediate files and final output. |
| `--bwa` | Path to the BWA executable. |
| `--samtools` | Path to the samtools executable. |
| `--bplib` | Breakpoint library in FASTA format. |
| `--bplib_gff` | Breakpoint library in GFF format (requires `.ins` file). |
| `--nthreads` | Number of threads to use for alignment steps. |
| `--sample` | Unique sample name (inferred from BAM if omitted). |

## Best Practices and Expert Tips

- **Version Compatibility**: BreakSeq2 is highly sensitive to dependency versions. It is specifically tested with `samtools` version 0.1.19 and `pysam` version 0.7.7. Using newer versions of these tools may lead to unexpected errors in alignment filtering or BAM parsing.
- **Library Preparation**: If you provide the library in GFF format, BreakSeq2 will automatically convert it to FASTA before processing. For repeated runs, providing the FASTA library directly (`--bplib`) saves initialization time.
- **Sample Identification**: If your BAM files do not have unique sample names in the `@RG` (Read Group) headers, or if you are merging multiple BAMs, always specify the `--sample` name explicitly to prevent execution failure.
- **Resource Management**: The `--nthreads` parameter primarily impacts the BWA alignment phase. Assigning 4-8 threads is typically sufficient for most human-scale datasets without hitting diminishing returns in I/O.
- **Output Inspection**: All results, including the final SV calls and intermediate alignments to the breakpoint library, are stored in the directory specified by `--work`.

## Reference documentation
- [BreakSeq2 Homepage](./references/bioinform_github_io_breakseq2.md)
- [Bioconda BreakSeq2 Overview](./references/anaconda_org_channels_bioconda_packages_breakseq2_overview.md)