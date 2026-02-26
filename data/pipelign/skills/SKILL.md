---
name: pipelign
description: Pipelign is a bioinformatics pipeline designed to create high-quality alignments for diverse viral sequences and genomic fragments. Use when user asks to align viral sequences, handle partial genomic fragments, cluster sequences using profile HMMs, or convert GenBank files to FASTA format.
homepage: https://github.com/asmmhossain/pipelign/
---


# pipelign

## Overview

Pipelign is a specialized bioinformatics pipeline designed to address the complexities of viral sequence alignment, such as high genetic diversity and the presence of partial genomic fragments. It automates a multi-stage workflow that includes sequence clustering, profile HMM construction, and iterative refinement. By leveraging tools like MAFFT, HMMER3, and CD-HIT, it produces high-quality alignments that integrate fragments into a global framework based on their similarity to full-length clusters.

## Core CLI Usage

The basic syntax for running a full alignment is:

```bash
pipelign -i <input.fasta> -o <output_alignment.fasta> -d <output_directory>
```

### Essential Arguments
- `-i, --inFile`: Input sequences in FASTA format.
- `-o, --outFile`: Final FASTA formatted alignment.
- `-d, --outDir`: Directory to store intermediate files (required).
- `-a, --alphabet`: Specify sequence type: `dna` (default), `rna`, or `aa` (amino acids).
- `-q, --thread`: Number of CPU threads to utilize (default: 1).

## Common Workflow Patterns

### Handling Protein Sequences
When aligning viral proteins, explicitly set the alphabet to amino acids:
```bash
pipelign -i viral_proteins.fasta -o aligned_proteins.fasta -a aa -d protein_workdir
```

### Optimizing for Fragments
If your dataset contains many short fragments that might not cluster well, use the orphans flag to ensure they are not discarded:
```bash
pipelign -i mixed_data.fasta -o final_aln.fasta -d workdir -f -t 0.5
```
*Note: `-t 0.5` lowers the length threshold for "full" sequences to 50% of the median.*

### High-Performance Execution
For large datasets, use GNU Parallel (if installed) and multiple threads:
```bash
pipelign -i large_dataset.fasta -o output.fasta -d results -q 16 -r G
```

### Resuming or Running Specific Stages
You can limit the pipeline to specific stages using `-n`:
1. Cluster alignments and HMMs of long sequences.
2. Align long sequences only.
3. Assign fragments to clusters.
4. Make cluster alignments with fragments.
5. Align all sequences.

## Expert Tips and Best Practices

- **Data Preparation**: Use the included `gb2fas` utility to convert GenBank files into the plain FASTA format required by pipelign, using accessions as headers.
- **Clustering Sensitivity**: If sequences are highly divergent, decrease the similarity threshold with `-p` (default is 0.8). For example, `-p 0.6` for more inclusive clusters.
- **Refinement**: For difficult alignments, increase the number of refinement iterations for long sequences (`-s`) or merged alignments (`-m`).
- **Ambiguity Management**: If your sequences contain many 'N's or ambiguous characters, use `-b` to keep sequences that would otherwise be rejected by the default ambiguity filter (10%).
- **Cleanup**: Use the `-c` flag if you are re-running an analysis in the same output directory to clear existing intermediate files.

## Reference documentation
- [pipelign GitHub Repository](./references/github_com_asmmhossain_pipelign.md)
- [pipelign Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_pipelign_overview.md)