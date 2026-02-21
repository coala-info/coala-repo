---
name: cthreepo
description: `cthreepo` is a specialized utility designed to resolve sequence ID mismatches in bioinformatics workflows.
homepage: https://github.com/vkkodali/cthreepo
---

# cthreepo

## Overview

`cthreepo` is a specialized utility designed to resolve sequence ID mismatches in bioinformatics workflows. It provides a streamlined way to interconvert identifiers across RefSeq, UCSC, and Ensembl styles. By using either built-in mapping shortcuts for common assemblies (Human and Mouse) or fetching specific assembly reports via NCBI accessions, it ensures that annotation and alignment files are compatible with the reference genome being used in a specific pipeline.

## Command Line Usage

The basic syntax for `cthreepo` requires specifying the input/output files, the source and target ID formats, the file type, and a mapping source.

### Basic Conversion
To convert a GFF3 file from RefSeq format to UCSC format using the Human GRCh38 mapping:
```bash
cthreepo -i input.gff3 -if rs -it uc -f gff3 -m h38 -o output.gff3
```

### Key Arguments
- `-i`, `--infile`: Path to the input file.
- `-o`, `--outfile`: Path for the converted output.
- `-f`, `--format`: The format of the input file. Supported: `gff3`, `gtf`, `bed`, `bedgraph`, `sam`, `vcf`, `wig`, `tsv`.
- `-if`, `--id_from`: Source ID style. Options: `rs` (RefSeq), `uc` (UCSC), `en` (Ensembl), or `any` (default).
- `-it`, `--id_to`: Target ID style. Options: `rs`, `uc`, `en`.
- `-m`, `--mapfile`: Mapping shortcut (`h38`, `h37`, `m38`, `m37`) or a path to a local NCBI assembly report.
- `-a`, `--accession`: A specific NCBI assembly accession (e.g., `GCF_000001405.39`) to fetch the mapping automatically.

## Expert Tips and Best Practices

### Handling Unknown Source Formats
If you are unsure of the source ID format, use `-if any` (which is the default). `cthreepo` will attempt to identify the source style based on the mapping file provided.

### Using Specific Assembly Versions
While shortcuts like `h38` are convenient, they may not match the specific patch level of your data. For maximum precision, use the NCBI assembly accession:
```bash
cthreepo -i input.vcf -if rs -it uc -f vcf -a GCF_000001405.39 -o output.vcf
```

### Working with TSV Files
When converting generic TSV files, ensure the sequence ID is in the first column, as `cthreepo` typically expects standard genomic formats where the sequence ID position is predefined.

### Built-in Mapping Shortcuts
- `h38`: GRCh38 / hg38
- `h37`: GRCh37 / hg19
- `m38`: GRCm38 / mm10
- `m37`: MGSCv37 / mm9

### Troubleshooting Mismatches
If the tool fails to convert certain IDs, verify that the input file does not contain custom or non-standard chromosome names that are absent from the NCBI assembly report. You can download the "Assembly structure report" manually from NCBI and provide it via the `-m` flag if the automated accession fetch fails due to network issues.

## Reference documentation
- [cthreepo GitHub Repository](./references/github_com_vkkodali_cthreepo.md)
- [cthreepo Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_cthreepo_overview.md)