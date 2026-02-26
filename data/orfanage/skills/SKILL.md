---
name: orfanage
description: ORFanage identifies optimal open reading frames for transcripts by using reference annotations as templates. Use when user asks to find ORFs in novel transcripts, rescue truncated coding sequences, or annotate transcripts using known protein-coding evidence.
homepage: https://github.com/alevar/ORFanage
---


# orfanage

## Overview
ORFanage is a specialized bioinformatics tool designed to find the best-matching ORF for transcripts by using existing reference annotations as templates. Unlike ab initio predictors, it leverages evidence from known coding sequences (CDS) to guide the identification of ORFs in novel or modified transcripts. This makes it an essential tool for researchers working with alternative splicing, gene fusions, or genome re-annotation where maintaining protein-level consistency with known genes is a priority.

## Installation
The recommended method for installation is via Bioconda:
```bash
conda install -c conda-forge -c bioconda orfanage
```

## Core CLI Usage
The basic syntax requires one or more template files (GTF/GFF) and a query file.

```bash
orfanage --query query.gtf --output output_prefix --reference genome.fa template.gtf
```

### Key Arguments and Options
- **Templates**: One or more GFF/GTF files containing the "known" coding exons to be used as a guide.
- **`--query`**: The GTF file containing the transcripts you want to find ORFs for.
- **`--output`**: The base name for the generated GTF and log files.
- **`--reference`**: The FASTA file of the genome. Required if using cleaning, rescue, or identity checks.
- **`--mode`**: Determines which CDS to report for each transcript:
    - `LONGEST_MATCH` (Default): The longest ORF that matches the template evidence.
    - `BEST`: The ORF with the highest similarity score.
    - `LONGEST`: The absolute longest ORF found.
    - `ALL`: Reports all potential candidates.

## Expert Workflows and Best Practices

### Ensuring Biological Validity
When working with high-quality annotations, use the cleaning flags to ensure the resulting ORFs are biologically plausible (i.e., they start with a start codon and end with a stop codon).
```bash
orfanage --query query.gtf \
         --reference hg38.fa \
         --cleanq \
         --cleant \
         --output validated_orfs \
         ref_annotation.gtf
```

### Rescuing Broken ORFs
If your query transcripts have truncated ends or minor assembly errors that break the ORF, use the `--rescue` flag. This allows ORFanage to search beyond the immediate transcript boundaries in the reference genome to find valid start/stop codons.
```bash
orfanage --query query.gtf --reference hg38.fa --rescue --output rescued_orfs template.gtf
```

### Filtering by Similarity
To ensure that ported ORFs are actually related to the templates, use the length percent difference (`--lpd`) or percent identity (`--pi`) filters.
- `--lpd 20`: Only keep ORFs within 20% length difference of the template.
- `--pi 95`: Perform sequence alignment and only keep ORFs with 95% identity (requires `--reference`).

### Performance Optimization
For large-scale transcriptomes (e.g., full human Iso-Seq datasets), always specify the thread count to utilize multi-core processing:
```bash
orfanage --threads 16 --query query.gtf --output fast_run template.gtf
```

### Comparing ORF Sets
Use the `orfcompare` utility (included with the package) to directly compare two different sets of ORF annotations to see how they differ in terms of coordinate overlaps and protein sequence identity.

## Reference documentation
- [ORFanage GitHub Repository](./references/github_com_alevar_ORFanage.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_orfanage_overview.md)