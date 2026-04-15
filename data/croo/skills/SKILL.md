---
name: croo
description: Croo organizes complex Cromwell workflow outputs into a structured, human-readable directory format using metadata files. Use when user asks to organize workflow results, create HTML summaries of genomic pipelines, or link Cromwell outputs to a destination directory.
homepage: https://github.com/ENCODE-DCC/croo
metadata:
  docker_image: "quay.io/biocontainers/croo:0.6.0--pyhdfd78af_0"
---

# croo

## Overview

Croo (Cromwell Output Organizer) is a specialized utility designed to transform the often-convoluted directory structure produced by Cromwell into a clean, human-readable format. By parsing the `metadata.json` generated at the end of a workflow run, Croo identifies specific output files and either links or copies them to a destination directory based on a provided output definition. It is particularly useful for bioinformaticians managing large-scale genomic pipelines who require structured results, HTML summaries, and integration with genome browsers like UCSC.

## Core CLI Usage

The basic syntax for running Croo requires the Cromwell metadata file, an output definition JSON, and a destination directory.

```bash
croo [METADATA_JSON] --out-def-json [OUT_DEF_JSON] --out-dir [OUT_DIR]
```

### Common Command Patterns

- **Local Organization (Soft-linking):** By default, Croo uses soft links for local-to-local transfers to save space.
  ```bash
  croo metadata.json --out-def-json workflow.out_def.json --out-dir ./organized_results
  ```

- **Cloud-to-Cloud Transfer:** Croo handles URI-based paths for metadata, definitions, and output directories across GCS and S3.
  ```bash
  croo gs://my-bucket/run1/metadata.json \
    --out-def-json s3://my-configs/atac.out_def.json \
    --out-dir gs://my-bucket/organized_results
  ```

- **Forcing File Copies:** Use this when you want to move files out of the Cromwell execution directory permanently or when moving between different storage types.
  ```bash
  croo metadata.json --out-def-json def.json --out-dir ./results --method copy
  ```

## Advanced Features and Best Practices

### Genome Browser Integration
Croo can automatically generate links for the UCSC Genome Browser in its HTML report.
- Use `--ucsc-genome-db` (e.g., `hg38`, `mm10`) to specify the assembly.
- Use `--ucsc-genome-pos` to set a default viewing position (e.g., `chr1:35000-40000`).

### Handling Private Cloud Storage
If your output directory is a private cloud bucket, you can generate presigned URLs so the links in the HTML report remain accessible for a limited time.
- **S3:** `--use-presigned-url-s3` (Default duration is often sufficient, but can be adjusted with `--duration-presigned-url-s3`).
- **GCS:** `--use-presigned-url-gcs` (Requires a service account key via `--gcp-private-key`).

### Path Mapping for Web Servers
If you are organizing files on a local server that is exposed via HTTP, use the TSV mapping feature to ensure the HTML report links work correctly.
- Create a 2-column TSV file: `[LOCAL_PREFIX] [TAB] [URL_PREFIX]`
- Run with: `--tsv-mapping-path-to-url mapping.tsv`

### Performance and Reliability
- **Temporary Directory:** Use `--tmp-dir` to specify a local cache for inter-storage transfers. This is critical when moving large files between different cloud providers.
- **Interruption Warning:** Croo does not currently have a fail-safe for interrupted transfers. Ensure the process completes fully before moving or deleting the source Cromwell directories.

## Reference documentation
- [Croo GitHub Repository](./references/github_com_ENCODE-DCC_croo.md)
- [Bioconda Croo Overview](./references/anaconda_org_channels_bioconda_packages_croo_overview.md)