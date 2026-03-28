---
name: sr2silo
description: The sr2silo tool converts BAM alignment files into the LAPIS-SILO NDJSON format by extracting and translating nucleotide sequences into amino acids. Use when user asks to process BAM files into SILO format, translate viral reads to amino acid sequences, or submit processed genomic data to a Loculus backend.
homepage: https://github.com/cbg-ethz/sr2silo
---

# sr2silo

## Overview

The `sr2silo` tool is a specialized bioinformatics utility designed to bridge the gap between raw nucleotide alignments (BAM files) and the LAPIS-SILO database format. It automates the complex workflow of extracting reads, translating them into amino acid sequences based on specific gene annotations, and formatting the results into newline-delimited JSON (NDJSON). It is particularly useful for viral surveillance pipelines where short-read data must be converted into a "cleartext" alignment format for downstream analysis and public health reporting.

## Core Workflows

### 1. Processing BAM to SILO Format
The primary command for data transformation is `process-from-vpipe`. This command handles the extraction, translation, and formatting.

```bash
sr2silo process-from-vpipe \
    --input-file input.bam \
    --sample-id "SAMPLE_001" \
    --timeline-file timeline.tsv \
    --organism covid \
    --output-fp output.ndjson.zst
```

**Expert Tips:**
- **Reference Accessions**: If your BAM contains multiple references (e.g., a combined RSV-A/B index), use `--reference-accession "ACCESSION_ID"` to prevent mixed-organism errors.
- **Resource Management**: Processing requires ~6GB RAM (3GB for batching + 3GB for Diamond). Set `TMPDIR` to a high-performance disk with at least 50GB free space for Diamond's temporary files.
- **Batching**: The tool processes 100k reads per batch by default. You can adjust this via `--chunk-size` if memory is constrained.

### 2. Reference Handling
`sr2silo` requires both nucleotide (`.fasta`) and amino acid (`.fasta`) reference files.

- **Auto-fetch**: Use `--lapis-url` to automatically download and cache the correct references for the specified organism.
- **Manual**: Provide paths via `--nuc-ref` and `--aa-ref` to override defaults or work offline.
- **Caching**: References are stored in `~/.cache/sr2silo/references/`. Clear this directory if you suspect outdated reference metadata.

### 3. Submitting to Loculus
Once processed, data can be uploaded to a Loculus backend.

```bash
sr2silo submit-to-loculus \
    --processed-file output.ndjson.zst \
    --nucleotide-alignment input.bam \
    --group-id 1 \
    --auto-release
```

**Configuration via Environment Variables:**
To avoid passing sensitive credentials in the CLI, set these variables:
- `USERNAME` / `PASSWORD`: Loculus credentials.
- `BACKEND_URL`: The API endpoint for the SILO backend.
- `KEYCLOAK_TOKEN_URL`: The authentication endpoint.

## Supported Organisms
The tool includes built-in logic for:
- `covid`: SARS-CoV-2
- `rsva`: Respiratory Syncytial Virus A

To add a new organism, you must provide a directory in `resources/references/{organism_id}/` containing `nuc_ref.fasta` and `aa_ref.fasta`.

## Troubleshooting
- **ZeroFilteredReadsError**: Occurs when `--reference-accession` is used but no reads in the BAM match that ID. Verify the ID using `samtools view -H file.bam | grep @SQ`.
- **Authentication Failures**: Ensure `KEYCLOAK_TOKEN_URL` is correct for the specific Loculus instance you are targeting.
- **Memory Issues**: If the process is killed, reduce `--chunk-size` or ensure `TMPDIR` is not pointing to a full partition.



## Subcommands

| Command | Description |
|---------|-------------|
| sr2silo process-from-vpipe | V-PIPE to SILO conversion with amino acids and special metadata. Processing only - use 'submit-to-loculus' command to upload and submit to SILO. |
| sr2silo_submit-to-loculus | Upload processed file to S3 and submit to SILO/Loculus. |

## Reference documentation
- [Usage Configuration](./references/cbg-ethz_github_io_sr2silo_usage_configuration.md)
- [Multi-Organism Support](./references/cbg-ethz_github_io_sr2silo_usage_organisms.md)
- [Resource Requirements](./references/cbg-ethz_github_io_sr2silo_usage_resource_requirements.md)
- [Loculus API Integration](./references/cbg-ethz_github_io_sr2silo_api_loculus.md)
- [Processing API](./references/cbg-ethz_github_io_sr2silo_api_process.md)