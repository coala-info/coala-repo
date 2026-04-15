---
name: aegean
description: The AEGeAn Toolkit provides a suite of programs for analyzing, evaluating, and standardizing genome annotations into intergenic and gene loci. Use when user asks to define genomic iLoci, compare different sets of annotations for similarity, or generate summary statistics for genome organization.
homepage: https://github.com/BrendelGroup/AEGeAn
metadata:
  docker_image: "quay.io/biocontainers/aegean:0.16.0--h71bfec9_5"
---

# aegean

## Overview

The AEGeAn Toolkit is a specialized suite of C libraries and CLI programs designed for the high-resolution Analysis and Evaluation of Genome Annotations. It is particularly effective for researchers who need to standardize genomic data into "iLoci" (intergenic and gene loci) to better understand genome organization. The toolkit provides robust workflows for comparing different annotation versions of the same genome and extracting meaningful statistics about gene spacing, exon-intron structures, and protein-coding sequences.

## Core CLI Programs

### LocusPocus
Used to define genomic loci (iLoci) from an annotation file.
- **Basic usage**: `locuspocus [options] gff3file`
- **Key function**: It groups overlapping or nested gene models into a single locus and defines the intergenic regions between them.

### ParsEval
Used for the parallel comparison of two different sets of annotations (e.g., comparing a de novo prediction against a reference).
- **Basic usage**: `parseval [options] reference.gff3 prediction.gff3`
- **Output**: Provides detailed similarity scores (Sensitivity, Specificity, and F-measure) at the nucleotide, exon, and gene levels.

### fidibus
A high-level workflow manager that automates the breakdown and analysis of genome content.
- **Standard Workflow**:
  ```bash
  fidibus --workdir=./output --numprocs=4 --local --label=MySpecies \
    --gdna=genome.fasta.gz --gff3=annotations.gff3.gz --prot=proteins.fasta.gz \
    download prep iloci breakdown stats
  ```
- **Tasks**:
  - `prep`: Validates and prepares input files.
  - `iloci`: Runs LocusPocus to define loci.
  - `breakdown`: Categorizes loci (e.g., protein-coding, RNA-coding, intergenic).
  - `stats`: Generates summary statistics.

## Expert Tips and Best Practices

### Resolving ID Mismatches
The most common error in AEGeAn (specifically within `fidibus`) is a mismatch between the protein IDs in the GFF3 file and the headers in the protein FASTA file.
- **Symptom**: An empty `*.prot.fa` file after running the workflow.
- **Fix**: Ensure the `Name=` or `ID=` tags in the GFF3 match the FASTA headers exactly. Use `sed` to clean headers (e.g., removing pipe `|` symbols which can cause issues in some environments).

### Handling Singularity Environments
AEGeAn is frequently distributed as a Singularity image. When running via Singularity, ensure you bind the working directory:
```bash
singularity exec -e -B /path/to/data aegean.simg fidibus [options]
```

### GFF3 Sanity Checks
Before running complex analyses, ensure your GFF3 follows these AEGeAn-compatible standards:
- Genes must have one or more mRNA subfeatures.
- mRNA features must fall within the range of their parent gene.
- CDS and UTR features must be consistent with exon coordinates.



## Subcommands

| Command | Description |
|---------|-------------|
| canon-gff3 | Clean up and canonicalize GFF3 data, including inferring missing gene features and resetting feature sources. |
| locuspocus | calculate locus coordinates for the given gene annotation |

## Reference documentation
- [AEGeAn Toolkit: analysis and evaluation of genome annotations](./references/github_com_BrendelGroup_AEGeAn.md)
- [AEGeAn FAQ](./references/github_com_BrendelGroup_AEGeAn_wiki_FAQ.md)
- [Automated testing and feature I/O](./references/github_com_BrendelGroup_AEGeAn_wiki_Automated-testing.md)