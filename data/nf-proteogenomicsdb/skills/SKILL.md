---
name: proteogenomicsdb
description: This pipeline generates proteogenomics protein databases by integrating ENSEMBL reference proteomes with non-canonical sequences like pseudogenes and lncRNAs, as well as genomic variants from VCF files, COSMIC, cBioPortal, or gNOMAD. Use when creating customized FASTA databases for proteogenomics analysis that require the inclusion of alternative ORFs, variant-affected transcripts, and decoy sequences for false discovery rate estimation.
homepage: https://github.com/nf-core/proteogenomicsdb
---

# proteogenomicsdb

## Overview
nf-core/pgdb addresses the need for comprehensive protein databases in proteogenomics by combining standard reference proteomes with non-canonical and variant-derived sequences. It leverages the pypgatk framework to translate genomic information into protein-level sequences suitable for mass spectrometry search engines.

The pipeline produces a final FASTA database that can include reference proteins, alternative open reading frames (ORFs), and proteins modified by somatic or germline mutations. Users can also append decoy sequences generated via various algorithms to support statistical validation of peptide identifications.

## Data preparation
The pipeline primarily retrieves reference data from ENSEMBL based on the species name provided. For variant-aware databases, users can provide local files or credentials for remote databases.

*   **Reference Species**: Specified via `--ensembl_name` (default is `homo_sapiens`).
*   **VCF Input**: To translate local variants, set `--vcf true` and provide the path with `--vcf_file`.
*   **External Databases**: 
    *   **COSMIC**: Requires `--cosmic_user_name` and `--cosmic_password`.
    *   **cBioPortal**: Can be filtered by study ID (`--cbioportal_study_id`) or cancer type.
    *   **gNOMAD**: Uses a default VCF URL which can be overridden via `--gnomad_file_url`.
*   **Configuration Files**: Optional JSON/text configuration files can be provided for ENSEMBL, COSMIC, or cBioPortal download and processing parameters.
*   **Constraints**: If using VCF files, ensure the allele frequency field name is specified via `--af_field` if filtering is required.

## How to run
The pipeline is executed using Nextflow with appropriate profiles for containerization (Docker, Singularity, etc.). It is recommended to use a specific version with `-r`.

```bash
# Basic run with ENSEMBL reference proteome
nextflow run nf-core/pgdb -r 1.0.0 -profile docker --outdir ./results

# Run with non-canonical proteins and alternative ORFs
nextflow run nf-core/pgdb -profile singularity \
    --ncrna true \
    --pseudogenes true \
    --altorfs true \
    --outdir ./results

# Run with local VCF variants and decoy generation
nextflow run nf-core/pgdb -profile docker \
    --vcf true \
    --vcf_file ./my_variants.vcf \
    --decoy true \
    --decoy_method decoypyrat \
    --outdir ./results
```

Key flags include `-resume` for restarting interrupted runs and `--final_database_protein` to customize the output filename.

## Outputs
Results are saved in the directory specified by the `--outdir` parameter.

*   **Protein Database**: The primary output is a FASTA file containing the combined sequences, named `final_proteinDB.fa` by default.
*   **Decoys**: If enabled, decoy sequences are appended to the final FASTA with a configurable prefix (default `Decoy_`).
*   **Reports**: Pipeline execution logs and trace files are stored in the `pipeline_info` subfolder.

For a detailed description of all output files and their formats, refer to the official documentation at https://nf-co.re/pgdb/output.

## References

Local copies of pipeline documentation used to generate this skill (paths relative to this skill folder):

- [`references/README.md`](references/README.md)
- [`references/nextflow_schema.json`](references/nextflow_schema.json)
- [`references/docs/README.md`](references/docs/README.md)
- [`references/docs/output.md`](references/docs/output.md)
- [`references/docs/usage.md`](references/docs/usage.md)