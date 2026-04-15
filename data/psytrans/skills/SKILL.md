---
name: psytrans
description: The psytrans tool separates mixed transcriptomes into host and symbiont sequences using a combination of BLASTX homology and SVM classification. Use when user asks to partition holobiont assemblies, separate host and symbiont reads, or classify ambiguous sequences in mixed transcriptomic data.
homepage: https://github.com/rivera10/psytrans
metadata:
  docker_image: "quay.io/biocontainers/psytrans:2.0.0--hdfd78af_1"
---

# psytrans

## Overview
The `psytrans` tool is designed for researchers working with holobiont transcriptomes or infected tissues where the resulting assembly is a mixture of multiple organisms. It performs sequence separation by comparing the mixed assembly against protein databases of related host and symbiont species. While BLASTX provides the initial homology-based sorting, `psytrans` utilizes SVM classification to resolve ambiguous sequences that do not have clear hits, ensuring a more complete partitioning of the data.

## Installation and Environment
The most reliable way to use `psytrans` is via Conda to ensure all dependencies (NCBI BLAST+ and libsvm) are correctly configured.

```bash
conda create -n psytrans -c bioconda psytrans
conda activate psytrans
```

## Common CLI Patterns

### Standard Separation
To separate a mixed assembly (`mixed.fasta`) using related host proteins (`host_ref.protein.fasta`) and related symbiont proteins (`symb_ref.protein.fasta`):

```bash
python psytrans.py mixed.fasta -H host_ref.protein.fasta -S symb_ref.protein.fasta
```

### High-Performance Execution
For large transcriptomes, always specify the number of threads to accelerate BLAST searches and SVM training.

```bash
python psytrans.py mixed.fasta -H host_ref.fasta -S symb_ref.fasta -p 8 -t /path/to/large_tmp_dir
```

### Stage-Specific Execution
Use the `-z` flag to stop the process after specific milestones. This is useful for verifying intermediate results or debugging.

*   **db**: Stop after creating BLAST databases.
*   **runBlast**: Stop after completing BLASTX searches.
*   **parseBlast**: Stop after initial sequence partitioning.
*   **kmers**: Stop after preparing SVM input features.
*   **SVM**: Stop after training and prediction.

```bash
python psytrans.py mixed.fasta -H host_ref.fasta -S symb_ref.fasta -z parseBlast
```

## Expert Tips and Best Practices

*   **Reference Selection**: The accuracy of the separation depends heavily on the quality and phylogenetic proximity of the protein files provided to `-H` and `-S`. Use the most closely related species available.
*   **Memory Management**: The SVM training phase can be memory-intensive. If the process crashes during the `kmers` or `SVM` stages, try reducing the number of training sequences using the `-n` flag (default is often sufficient, but lowering it can save RAM).
*   **E-value Thresholds**: Use the `-e` (`--maxBestEvalue`) flag to tighten or loosen the homology requirements for "unambiguous" sequences. A smaller E-value (e.g., `1e-10`) ensures higher confidence in the initial training set.
*   **K-mer Tuning**: If the organisms have very similar GC content or codon usage, you may need to experiment with the k-mer sizes using `-c` (min) and `-k` (max) to improve SVM discrimination.
*   **Restarting**: If a run is interrupted, use the `-R` or `--restart` flag to resume from the last successful checkpoint rather than starting from scratch.
*   **Cleanup**: Use `-X` or `--clearTemp` to automatically delete the temporary directory upon successful completion, which is helpful when working with limited disk space.

## Reference documentation
- [Bioconda psytrans Overview](./references/anaconda_org_channels_bioconda_packages_psytrans_overview.md)
- [psytrans GitHub Repository](./references/github_com_rivera10_psytrans.md)