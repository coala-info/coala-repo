---
name: domainator
description: Domainator is a modular bioinformatics suite for domain-centric analysis and annotation of genetic data using HMM profiles. Use when user asks to annotate sequences with functional domains, extract genomic neighborhoods, search for specific domains, cluster sequences, or perform comparative genomics.
homepage: https://github.com/nebiolabs/domainator
---


# domainator

## Overview
Domainator is a modular bioinformatics suite designed for "domain-centric" analysis of genetic data. It treats HMM-profiles as first-class citizens and utilizes the GenBank format as a universal carrier for both sequence and annotation data. Use this skill to help users annotate sequences with functional domains, extract specific genomic neighborhoods (such as biosynthetic gene clusters), and perform comparative genomics based on domain architecture rather than just raw sequence identity.

## Core CLI Patterns
Domainator follows a consistent "Editor" logic where the file being modified is passed via `-i` and the reference criteria (HMMs or sequences) are passed via `-r`.

### Functional Annotation
To add domain annotations to unannotated sequences (GenBank or FASTA) using HMM profiles or reference proteins:
```bash
domainate.py -i input.gb -r pfam-A.hmm -o annotated.gb
```
*Expert Tip: You can provide multiple reference files (e.g., HMMs and FASTA proteins) in a single call to annotate with both simultaneously.*

### Domain-Based Searching
To subset a large database based on the presence of specific domain hits:
```bash
domain_search.py -i uniprot.fasta -r query.hmm -o hits.gb
```

### Neighborhood Extraction
To extract the genomic context (neighborhood) around a specific protein or domain of interest:
```bash
select_by_cds.py -i genome_contigs.gb -r anchor_domain.hmm -o neighborhoods.gb
```

### Sequence Clustering and Deduplication
To cluster sequences and keep only representatives using CD-HIT or usearch:
```bash
deduplicate_genbank.py -i input.gb -o representatives.gb
```

## Workflow Best Practices
- **GenBank as the Standard**: Always prefer GenBank (.gb) files for intermediate steps. Domainator stores all metadata and annotations within the GenBank features, ensuring data portability across the suite.
- **Piping and Streaming**: Many Domainator programs support streaming. Use standard UNIX pipes to chain editors together to avoid creating large intermediate files.
- **HMM Subsetting**: Use Domainator's HMM tools to subset large libraries (like Pfam) to only the profiles relevant to your specific search to increase performance.
- **Reporting**: Use "Record-wise report" programs to convert GenBank data into TSV format for final analysis in Excel, R, or Python (Pandas).

## Program Categories
- **Editors**: (`domainate`, `domain_search`, `select_by_cds`) Output format matches input format; used for transformations.
- **Comparison**: (`compare_contigs`, `seq_dist`) Generate distance or similarity matrices.
- **Summary**: Produce statistics and high-level graphs of the dataset.
- **Plotting**: Convert matrices into formats for Cytoscape or tree viewers.



## Subcommands

| Command | Description |
|---------|-------------|
| build_ssn.py | Generates Sequence Similarity Networks      Build a sequence similarity network and do analysis related to that. |
| domainator_compare_contigs.py | Calculates similarity metrics for gene neighborhoods |
| domainator_deduplicate_genbank.py | Remove redundant sequences from a genbank file |
| domainator_domain_search.py | Search for matches to hmm profiles |
| domainator_domainate.py | Annotate sequence files with hmm profiles |
| domainator_select_by_cds.py | Extract contigs regions around selected CDSs |

## Reference documentation
- [Domainator README](./references/github_com_nebiolabs_domainator_blob_main_README.md)
- [Documentation Index](./references/github_com_nebiolabs_domainator_blob_main_docs_README.md)
- [Developing Domainator](./references/github_com_nebiolabs_domainator_blob_main_docs_developing_domainator.md)