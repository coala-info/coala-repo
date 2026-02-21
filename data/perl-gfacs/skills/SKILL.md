---
name: perl-gfacs
description: The gFACs (Genome Filtering, Analysis, and Conversion) tool is a Perl-based utility designed to process genome annotation files.
homepage: https://gitlab.com/PlantGenomicsLab/gFACs
---

# perl-gfacs

## Overview
The gFACs (Genome Filtering, Analysis, and Conversion) tool is a Perl-based utility designed to process genome annotation files. It acts as a bridge between various gene prediction and alignment frameworks, allowing you to standardize formats, filter models based on specific criteria (like presence of start/stop codons), and extract sequences. Use this skill to streamline the transition from raw gene predictions to downstream analysis-ready datasets.

## Common CLI Patterns

### Basic Annotation Processing
To process an annotation file and generate basic statistics and a splice table:
```bash
gFACs.pl -f <format_code> --statistics --splice-table -O <output_directory> <input_annotation>
```

### Extracting Protein Sequences
To generate a protein FASTA file, you must provide the reference genome:
```bash
gFACs.pl -f <format_code> --get-protein-fasta --fasta <genome.fasta> -O <output_directory> <input_annotation>
```

### Supported Format Codes
Choosing the correct `-f` flag is critical for parsing. Common codes include:
- `braker_2.1.2_gtf`: For BRAKER2 outputs.
- `2.1.5_gtf`: Often compatible with newer BRAKER versions (including BRAKER3).
- `CoGe_1.0_gff`: General GFF format used by CoGe.
- `gffread`: For files previously processed or standardized by gffread.

## Expert Tips and Troubleshooting

### Handling Helixer GFF3 Files
Helixer files often contain comments in the data blocks that can cause parsing errors. 
- **Fix**: Pre-process the file to remove all lines starting with `#` except for the very first header line before running gFACs.

### Working with BRAKER3
While gFACs was developed before BRAKER3, the `2.1.5_gtf` format code is the recommended starting point. Always check the `statistics` output to ensure transcripts and genes are being counted and sorted correctly.

### Mikado Integration
There is no direct input format for Mikado in gFACs. 
- **Workaround**: Convert Mikado output using `gffread` first, then use the `gffread` format code in gFACs. Alternatively, try the `CoGe_1.0_gff` format.

### Dealing with Duplicates
If you encounter duplicate or empty protein entries (common in some BRAKER 2.1.6 outputs), verify the transcript IDs in your source GTF. gFACs relies heavily on unique `transcript_id` and `gene_id` tags to prevent record duplication.

## Reference documentation
- [gFACs Overview](./references/anaconda_org_channels_bioconda_packages_perl-gfacs_overview.md)
- [gFACs GitLab Activity and Issues](./references/gitlab_com_PlantGenomicsLab_gFACs.atom.md)
- [gFACs Project Repository](./references/gitlab_com_PlantGenomicsLab_gFACs.md)