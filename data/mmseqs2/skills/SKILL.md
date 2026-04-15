---
name: mmseqs2
description: MMseqs2 is a high-performance software suite designed for rapid protein and nucleotide sequence searching, clustering, and taxonomic assignment. Use when user asks to search sequences against databases, cluster large datasets into representative groups, or assign taxonomy to metagenomic sequences.
homepage: https://github.com/soedinglab/mmseqs2
metadata:
  docker_image: "quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0"
---

# mmseqs2

## Overview
MMseqs2 (Many-against-Many sequence searching) is a highly optimized software suite designed for the analysis of massive sequence datasets. It provides a significant speed advantage—up to 10,000 times faster than BLAST—while maintaining high sensitivity. It is the industry standard for clustering protein sequences, performing profile-to-sequence searches, and assigning taxonomy to metagenomic data. The tool operates using a modular architecture, offering "easy" workflows for common tasks and granular modules for complex, multi-step pipelines.

## Core Workflows

### Sequence Searching
Use `easy-search` for direct FASTA/FASTQ queries against a target file or database.
```bash
# Basic search: query.fasta vs target.fasta
mmseqs easy-search query.fasta target.fasta alignment.m8 tmp

# Search against a pre-built database for better performance
mmseqs easy-search query.fasta targetDB alignment.m8 tmp
```

### Sequence Clustering
MMseqs2 offers two primary clustering modes depending on dataset size and requirements.
- **easy-cluster**: Standard cascaded clustering.
- **easy-linclust**: Linear-time clustering, recommended for datasets with millions of sequences.

```bash
# Standard clustering (50% identity, 80% coverage)
mmseqs easy-cluster sequences.fasta clusterRes tmp --min-seq-id 0.5 -c 0.8 --cov-mode 1

# Linear-time clustering for massive datasets
mmseqs easy-linclust sequences.fasta clusterRes tmp
```

### Taxonomic Assignment
Assign taxonomy to sequences using the `taxonomy` workflow, which utilizes the Lowest Common Ancestor (LCA) approach.
```bash
mmseqs taxonomy query.fasta targetDB taxonomyResult tmp
```

## Expert Tips and Performance Tuning

### Sensitivity Control
The `-s` parameter is the primary lever for balancing speed and sensitivity.
- **-s 1.0 to 4.0**: Very fast, suitable for high-identity matches.
- **-s 5.7**: Default; balances speed and sensitivity (similar to BLAST).
- **-s 7.5**: Maximum sensitivity, useful for remote homology detection.

### GPU Acceleration
If using a version compiled with CUDA support (Release 18+), add the `--gpu` flag to `easy-search` or `createdb` to significantly accelerate the prefiltering step.
```bash
mmseqs easy-search query.fasta targetDB aln.m8 tmp --gpu 1
```

### Coverage Modes (`--cov-mode`)
Adjust how sequence overlap is calculated:
- **0**: Bidirectional (both sequences must meet coverage threshold).
- **1**: Target coverage (target must be covered by query).
- **2**: Query coverage (query must be covered by target).
- **5**: Shortest sequence coverage (useful for clustering fragments).

### Database Management
For repetitive searches against the same target, always pre-compute the database and index to save time.
```bash
mmseqs createdb target.fasta targetDB
mmseqs createindex targetDB tmp
```

## Output Formats
The default output is a BLAST-tab formatted file (`.m8`). You can customize the output columns using `--format-output`.
- **Common fields**: `query,target,pident,alnlen,mismatch,gapopen,qstart,qend,tstart,tend,evalue,bits`

## Reference documentation
- [MMseqs2 GitHub Repository](./references/github_com_soedinglab_mmseqs2.md)
- [MMseqs2 User Guide (Wiki)](./references/github_com_soedinglab_mmseqs2_wiki.md)
- [MMseqs2 Release 18 Notes](./references/github_com_soedinglab_mmseqs2_releases_tag_18-8cc5c.md)