---
name: emblmygff3
description: emblmygff3 converts GFF3 annotation files and FASTA sequences into the EMBL flat file format required for ENA submissions. Use when user asks to convert GFF3 to EMBL format, prepare genomic data for ENA submission, or map genomic features to INSDC standards.
homepage: https://github.com/NBISweden/EMBLmyGFF3
metadata:
  docker_image: "quay.io/biocontainers/emblmygff3:2.4--pyhdfd78af_1"
---

# emblmygff3

## Overview

The `emblmygff3` tool is an efficient converter designed to transform GFF3 annotation files and their corresponding FASTA sequences into the EMBL flat file format. This conversion is a critical step for researchers submitting annotated genomes to the European Nucleotide Archive (ENA). The tool ensures that genomic features, coordinates, and attributes are correctly mapped to the specific qualifiers and syntax required by the International Nucleotide Sequence Database Collaboration (INSDC) standards.

## Basic Usage

The tool requires a GFF3 file and the FASTA file used to generate that annotation.

### Interactive Mode
If you provide only the input files, the tool will prompt you for the mandatory metadata required for a valid EMBL file:
```bash
EMBLmyGFF3 annotations.gff3 genome.fasta -o output.embl
```

### Non-Interactive (Complete) Mode
To bypass prompts and ensure reproducibility, provide all mandatory metadata as flags:
```bash
EMBLmyGFF3 annotations.gff3 genome.fasta \
    --topology linear \
    --molecule_type 'genomic DNA' \
    --transl_table 1 \
    --species 'Species name' \
    --locus_tag PROJECT_PREFIX \
    --project_id PRJXXXXXXX \
    -o output.embl
```

## Mandatory Metadata for ENA Submission

When preparing files for ENA, the following parameters are strictly required:
- `--locus_tag`: The unique prefix registered at ENA for your project.
- `--project_id`: The ENA Project ID (e.g., PRJEB12345).
- `--molecule_type`: Usually 'genomic DNA', 'genomic RNA', etc.
- `--topology`: Either `linear` or `circular`.
- `--transl_table`: The genetic code table (e.g., `1` for Standard, `11` for Bacterial/Archaeal).

## Advanced Configuration

### Handling Short Sequences
By default, ENA submission guidelines often discourage or reject very short sequences. If you need to include sequences shorter than 100bp, use:
```bash
EMBLmyGFF3 annotations.gff3 genome.fasta --keep_short_sequences -o output.embl
```

### Adding Publication Details
For a complete submission file, you can include citation information directly:
```bash
EMBLmyGFF3 annotations.gff3 genome.fasta \
    --author 'Surname N.' \
    --rt 'Title of the Publication' \
    --rl 'Journal Name, Volume, Pages' \
    --project_id PRJXXXXXXX \
    -o output.embl
```

### Taxonomy and Data Class
- `--taxonomy`: Use the INSDC division code (e.g., `PRO` for Prokaryotes, `INV` for Invertebrates, `MAM` for Mammals).
- `--data_class`: Usually `STD` (Standard).

## Best Practices and Tips

1. **Validation**: Always validate the resulting `.embl` file using the ENA Webin-cli validator before attempting a final submission.
2. **Locus Tags**: Ensure your GFF3 attributes (like `ID` or `Name`) are compatible with the `--locus_tag` prefix to avoid naming conflicts in the output.
3. **CDS Phases**: The tool expects proper GFF3 phase columns for CDS features. If the phase is missing or incorrect, it defaults to 0, which may affect the translation check.
4. **Environment**: It is recommended to install via Conda (`conda install -c bioconda emblmygff3`) to ensure all dependencies like `biopython` and `bcbio-gff` are correctly versioned.

## Reference documentation
- [GitHub Repository and Documentation](./references/github_com_NBISweden_EMBLmyGFF3.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_emblmygff3_overview.md)