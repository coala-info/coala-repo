---
name: archer
description: Archer (Artic Resource for Classifying, Honing & Exporting Reads) is a microservice designed to prepare genomic data for the CLIMB (Cloud Infrastructure for Microbial Bioinformatics) environment.
homepage: https://github.com/will-rowe/archer
---

# archer

## Overview

Archer (Artic Resource for Classifying, Honing & Exporting Reads) is a microservice designed to prepare genomic data for the CLIMB (Cloud Infrastructure for Microbial Bioinformatics) environment. It acts as a local gatekeeper that ensures data quality and metadata compliance before cloud-based pipelines are triggered. The tool validates sample metadata, filters reads against specific amplicon primer schemes using sketches, and handles the compression and upload of on-target reads to S3 storage.

## Installation

The recommended way to install archer is via Bioconda:

```bash
conda install -c bioconda archer
```

Alternatively, it can be built from source using the Go toolchain:

```bash
make all
```

## Command Line Usage

Archer operates as a gRPC microservice with a single binary providing both server and client functionality.

### Starting the Server
The server must be running to handle processing requests and client connections.

```bash
archer launch
```

### Processing Samples
To process a sample, you must pipe a JSON-formatted `ProcessRequest` into the client. This request includes the minimal metadata required for validation.

```bash
cat sample.json | archer process
```

### Monitoring Tasks
Use the watch client to monitor the status of ongoing sample processing tasks.

```bash
archer watch
```

## Best Practices and Expert Tips

- **Metadata Validation**: Ensure your `sample.json` contains all required fields for a `ProcessRequest`. Archer will reject samples that do not meet the minimal metadata requirements.
- **Primer Schemes**: Archer filters reads by comparing amplicon sketches against the provided primer scheme. Ensure your sequencing data matches the scheme defined in your request for accurate filtering.
- **S3 Integration**: Before running `archer process`, verify that your environment is configured with the necessary credentials to access the target S3 bucket, as the tool automates the upload of compressed on-target reads.
- **Service Architecture**: Since archer is a microservice, you can run the server (`launch`) on a central machine and use the client commands (`process`, `watch`) from different terminals or scripts to manage workflows.
- **Error Handling**: If a process fails, archer marks the sample as "errored." Currently, there is no automatic retry mechanism; you must manually re-submit the `ProcessRequest` after addressing the underlying issue (e.g., network connectivity to S3 or malformed input reads).

## Reference documentation

- [Archer GitHub Repository](./references/github_com_will-rowe_archer.md)
- [Bioconda Archer Overview](./references/anaconda_org_channels_bioconda_packages_archer_overview.md)