---
name: sra-toolkit
description: The SRA Metadata Toolkit skill enables efficient access to NCBI/DDBJ/EBI Sequence Read Archive metadata without manually navigating web portals.
homepage: https://github.com/inutano/sra_metadata_toolkit
---

# sra-toolkit

## Overview

The SRA Metadata Toolkit skill enables efficient access to NCBI/DDBJ/EBI Sequence Read Archive metadata without manually navigating web portals. It focuses on using the toolkit's REST API to perform ID mapping across the SRA hierarchy, extracting specific metadata attributes (like submission dates or lab names), and retrieving sequence quality summaries. This is particularly useful for bioinformatics pipeline automation and data provenance tracking.

## Common CLI Patterns

The toolkit is primarily accessed via HTTP requests. Use `curl` or `wget` to interact with the service.

### 1. SRA ID Conversion
Convert between different SRA object types (Submission, Study, Experiment, Sample, Run) or find associated PubMed IDs.

**Pattern:**
`curl http://g86.dbcls.jp/sra/idconvert/<ORIGIN_ID>.to_<DEST_TYPE>`

*   **Valid Dest Types:** `submission`, `study`, `experiment`, `sample`, `run`, `pmid`, `all`
*   **Example (Convert Run to Study):**
    `curl http://g86.dbcls.jp/sra/idconvert/DRR000001.to_study`
*   **Example (Get all related IDs):**
    `curl http://g86.dbcls.jp/sra/idconvert/DRA000001.to_all`

### 2. Metadata Parsing
Retrieve specific metadata fields or the full record in JSON format.

**Pattern:**
`curl http://g86.dbcls.jp/sra/metadata/<SRA_ID>.<METHOD>`

*   **Discovery:** Use `.methods` to see available metadata fields for a specific ID.
    `curl http://g86.dbcls.jp/sra/metadata/DRA000001.methods`
*   **Full Record:** Use `.all` to get the complete metadata object.
    `curl http://g86.dbcls.jp/sra/metadata/DRA000001.all`
*   **Specific Fields:** Common methods include `submission_comment`, `center_name`, `lab_name`, and `submission_date`.

### 3. FastQC Result Retrieval
Access quality control summaries for specific sequence runs.

**Pattern:**
`curl http://g86.dbcls.jp/sra/fastqc/<RUN_FILE_NAME>.<METHOD>`

*   **Identify Run Files:** First, get the list of files associated with a Run ID.
    `curl http://g86.dbcls.jp/sra/readfile/DRR000001`
*   **Get Quality Metrics:** Use the filename (e.g., `DRR000001_1`) with a method.
    `curl http://g86.dbcls.jp/sra/fastqc/DRR000001_1.all`

## Expert Tips

*   **JSON Processing:** Always pipe output to `jq` for readability and easier filtering in the shell.
    `curl -s http://g86.dbcls.jp/sra/metadata/DRA000001.all | jq '.'`
*   **Batch Processing:** When processing multiple IDs, implement a small delay (e.g., `sleep 1`) between requests, as the service response time can vary.
*   **ID Validation:** Ensure SRA IDs follow the standard format: three-letter prefix (e.g., SRR, ERR, DRR) followed by six or more digits.
*   **Method Discovery:** Since metadata schemas can vary between DDBJ, EBI, and NCBI, always check `.methods` for a new dataset to see which specific fields were successfully parsed.

## Reference documentation

- [SRA Metadata toolkit README](./references/github_com_inutano_sra_metadata_toolkit.md)