---
name: fermikit
description: FermiKit is a specialized pipeline that transforms raw Illumina short reads into unitigs through de novo assembly before calling variants.
homepage: https://github.com/lh3/fermikit
---

# fermikit

## Overview
FermiKit is a specialized pipeline that transforms raw Illumina short reads into unitigs through de novo assembly before calling variants. By mapping these assembled unitigs to a reference genome, it achieves variant calling accuracy comparable to standard mapping pipelines while excelling at identifying complex structural changes and novel sequences. It is designed for efficiency, capable of processing a 30x human genome in approximately 24 hours on a standard 16-core server.

## Core Workflow Patterns

### 1. De Novo Assembly
The first stage generates a Makefile for the assembly process. You must specify the estimated genome size and the average read length.

```bash
# Generate the assembly Makefile
# -s: genome size (e.g., 3g for human)
# -l: read length (e.g., 150)
# -t: number of threads
# -p: output prefix
fermi.kit/fermi2.pl unitig -s3g -t16 -l150 -p sample_name reads.fq.gz > sample_name.mak

# Execute the assembly
make -f sample_name.mak
```

### 2. Variant Calling
Once the assembly (`.mag.gz`) is produced, use the calling script to identify SNPs, INDELs, and SVs.

```bash
# Call variants and pipe to shell for execution
fermi.kit/run-calling -t16 bwa-indexed-ref.fa sample_name.mag.gz | sh
```

**Key Outputs:**
*   `prefix.mag.gz`: The final assembly.
*   `prefix.flt.vcf.gz`: Filtered SNPs and short INDELs.
*   `prefix.sv.vcf.gz`: Structural variations (long deletions, insertions, translocations).

### 3. Integrated Pre-processing
If raw data requires adapter trimming or merging of paired-end reads, FermiKit tools can be piped directly into the assembly generator.

```bash
fermi.kit/fermi2.pl unitig -s3g -t16 -l150 -p prefix \
  "fermi.kit/seqtk mergepe r1.fq r2.fq | fermi.kit/trimadap-mt -p4" > prefix.mak
```

### 4. Multi-sample Analysis
To call SNPs and INDELs across multiple samples simultaneously, use the `htsbox` utility.

```bash
# Generate a multi-sample raw VCF
fermi.kit/htsbox pileup -cuf ref.fa sample1.srt.bam sample2.srt.bam > multi.raw.vcf

# Filter and summarize the VCF
fermi.kit/k8 fermi.kit/hapdip.js vcfsum -f multi.raw.vcf > multi.flt.vcf
```

## Expert Tips and Best Practices

*   **Resource Management**: For a human genome (30x), ensure the system has at least 85GB-90GB of RAM available for the error correction phase.
*   **Genome Size Parameter**: The `-s` flag is crucial. Use suffixes like `k`, `m`, or `g` (e.g., `-s3g` for 3 Gigabases).
*   **Reproducibility**: Note that multi-threaded unitig construction and the BFC error correction phase have random factors. Running the same data twice may result in slightly different assemblies, though variant calls from those assemblies remain highly consistent.
*   **Paired-End Data**: FermiKit treats reads as single-end during assembly. For modern Illumina data with overlapping ends, it is recommended to merge them using `seqtk mergepe` before assembly to improve results.
*   **Reference Indexing**: Ensure the reference genome is indexed with BWA before running the `run-calling` script.

## Reference documentation
- [FermiKit Main Documentation](./references/github_com_lh3_fermikit.md)