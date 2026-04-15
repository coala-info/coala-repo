---
name: archer
description: Archer is a microservice that validates sample metadata and filters sequencing reads against amplicon primer schemes before uploading them to cloud storage. Use when user asks to launch the gRPC server, process sequencing samples, or monitor the status of active tasks.
homepage: https://github.com/will-rowe/archer
metadata:
  docker_image: "quay.io/biocontainers/archer:0.1.1--he881be0_0"
---

# archer

## Overview

Archer (Artic Resource for Classifying, Honing & Exporting Reads) is a specialized microservice designed to bridge the gap between local sequencing data and cloud-based CLIMB workflows. It functions as a pre-processing gatekeeper that validates sample metadata and performs rapid read filtering against amplicon primer schemes. By identifying on-target reads locally before compression and S3 upload, it minimizes bandwidth usage and ensures that only high-quality, relevant data enters the downstream ARTIC bioinformatics pipeline.

## Core Workflows

### Server Management

The archer service operates as a gRPC server. By default, it listens on port `9090`.

*   **Launch the server**: Use the `launch` command to start the microservice.
    ```bash
    archer launch
    ```
*   **Containerized execution**: If running via Docker, ensure port 9090 is mapped.
    ```bash
    docker run -p 9090:9090 willrowe/archer:latest
    ```

### Processing Samples

The primary way to interact with the service is through the `process` command, which accepts a JSON-formatted `ProcessRequest` via standard input.

*   **Basic processing command**:
    ```bash
    cat sample.json | archer process
    ```

### Monitoring Tasks

Because processing and uploading can be time-consuming, archer provides a "watch" mode to monitor the status of active tasks.

*   **Watch client**:
    ```bash
    archer watch
    ```

## Technical Best Practices

### Input Preparation
The `ProcessRequest` JSON must contain minimal metadata and links to the sequencing reads. Ensure your JSON structure matches the schema defined in the API documentation. Archer performs a validation check on this metadata before beginning the filtering process.

### Read Filtering Logic
Archer uses a similarity comparison between amplicon sketches and read sketches. 
*   **Heuristic approach**: It loops over amplicon sketches (typically ~90 for standard schemes) to find the best match for each read.
*   **Filtering**: It applies hard-coded Jaccard similarity and read length filters to determine if a read is "on-target."

### S3 Integration
Archer is designed to compress on-target reads and upload them directly to an S3 bucket. Ensure your environment has the necessary AWS/S3 credentials configured if the server is tasked with uploading to a CLIMB-managed bucket.

### Troubleshooting
*   **Error Handling**: If a sample fails during processing, it is marked as "errored" in the internal database. Currently, there is no automatic retry mechanism; you must re-submit the `ProcessRequest` after addressing the underlying issue (e.g., network connectivity to S3 or malformed input files).
*   **Logs**: Check the server output for gRPC status codes if the client returns an error.



## Subcommands

| Command | Description |
|---------|-------------|
| archer launch | Launch the Archer service. This will start a gRPC server running that will accept incoming Process and Watch requests. It will offer the Archer API for filtering, compressing and uploading ARTIC reads to an S3 endpoint. |
| archer process | Add a sample to the processing queue. The processing request is collected via STDIN and should be in JSON. The request will be validated prior to submitting it to the Archer service. |
| archer watch | Watch a running Archer service. This command will start a gRPC message stream and print samples that have completed processing. It will include sample name, amplicon coverage, S3 location and processing time. |

## Reference documentation

- [Archer README](./references/github_com_will-rowe_archer_blob_main_README.md)
- [Archer API Documentation](./references/github_com_will-rowe_archer_blob_main_api_docs_v1_archer.md)
- [Archer Dockerfile](./references/github_com_will-rowe_archer_blob_main_Dockerfile.md)