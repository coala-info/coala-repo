---
name: gff3toddbj
description: gff3toddbj converts GFF3 and FASTA files into the specific annotation format required for submission to the DNA Data Bank of Japan. Use when user asks to prepare genomic data for DDBJ submission, translate GFF3 features to INSDC format, or generate DDBJ-compliant annotation files.
homepage: https://github.com/yamaton/gff3toddbj
---


# gff3toddbj

## Overview

gff3toddbj is a specialized bioinformatics utility designed to bridge the gap between standard GFF3/FASTA files and the specific annotation requirements of the DNA Data Bank of Japan (DDBJ). It functions as the DDBJ-specific equivalent to NCBI's table2asn or ENA's EMBLmyGFF3. The tool automates the translation of Sequence Ontology (SO) terms to INSDC features, handles complex coordinate joins for spliced features (like exons and CDS), and ensures that qualifiers like `/product` and `/gene` meet DDBJ's strict submission guidelines.

## Installation

The tool is primarily distributed via Bioconda:

```bash
conda create -n ddbj -c conda-forge -c bioconda gff3toddbj
conda activate ddbj
```

## Basic Usage

The core command requires a FASTA file, a GFF3 file, and a locus tag prefix assigned by BioSample.

```bash
gff3-to-ddbj \
  --fasta genome.fa \
  --gff3 annotations.gff3 \
  --locus_tag_prefix PREFIX_ \
  --output submission.ann
```

### Key Arguments
- `--fasta`: Path to the genomic sequence file (Required).
- `--gff3`: Path to the annotation file (Strongly recommended).
- `--locus_tag_prefix`: The prefix assigned to your project by BioSample (Required for submission).
- `--transl_table`: Genetic code index. Use `1` for Standard (default) or `11` for Bacteria/Archaea.
- `--metadata`: Path to a TOML file containing submitter and reference information.

## Metadata Configuration (TOML)

To include submission-level information (Submitter, Reference, Comment) that is not present in GFF3 files, use a TOML metadata file.

```toml
[COMMON]
SUBMITTER = "Contact Name:Genome Taro"
REFERENCE = "Title:Genomic analysis of..."
COMMENT = "This sequence was assembled using..."

[source]
organism = "Escherichia coli"
strain = "K-12"
db_xref = "taxon:511145"

[assembly_gap]
estimated_length = "<COMPUTE>"
gap_type = "within scaffold"
linkage_evidence = "paired-ends"
```

## Expert Tips and Best Practices

### Handling Circular Genomes
If your sequence is circular (e.g., bacterial chromosomes or plasmids), ensure the GFF3 file contains the attribute `Is_circular=true`. The tool will automatically insert a `TOPOLOGY` feature and manage features that span the origin.

### Feature Joining Logic
The tool automatically merges features sharing a parent (like exons belonging to the same mRNA) into `join()` notation. Note that `exon` features are discarded after their coordinates are transferred to the parent RNA feature, unless the parent is a `gene`.

### DDBJ Compliance Checks
- **Product Names**: DDBJ allows only one `/product` per CDS. If multiple names exist in your GFF3, the tool picks the most representative one and moves others to `/note`.
- **Gene Qualifiers**: Multiple gene names are handled by moving secondary values to `/gene_synonym`.
- **Validation**: Always monitor `stderr` during execution. The tool logs all discarded features or qualifiers that violate the DDBJ usage matrix.

### Sequence Gaps
The tool automatically scans FASTA sequences for runs of "N" and generates `assembly_gap` features. You can configure the specific gap type and linkage evidence in the `[assembly_gap]` section of your metadata TOML.

## Reference documentation
- [gff3toddbj GitHub Repository](./references/github_com_yamaton_gff3toddbj.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_gff3toddbj_overview.md)