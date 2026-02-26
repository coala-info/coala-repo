---
name: ebi-webservice
description: The ebi-webservice skill provides programmatic access to the European Bioinformatics Institute's computational tools for automated biological data processing. Use when user asks to submit bioinformatics jobs, run sequence alignments, perform BLAST searches, or manage asynchronous data processing workflows through the EBI Job Dispatcher.
homepage: https://github.com/ebi-jdispatcher/webservice-clients
---


# ebi-webservice

## Overview
The ebi-webservice skill facilitates programmatic access to the European Bioinformatics Institute's (EBI) computational tools. It allows for the automation of complex biological workflows by providing a standardized way to interact with the Job Dispatcher Web Services. Instead of using a web browser, you can use this skill to guide the execution of specialized client scripts that handle the asynchronous nature of biological data processing, including job submission, polling for completion, and downloading result files.

## Tool-Specific Best Practices

### Mandatory Parameters
Every request to the EBI Job Dispatcher requires a valid email address. This is used by EBI to contact users if there are issues with their jobs or to prevent service abuse.
- Always include: `--email <your@email.com>`

### Python Client Usage
The Python clients are the most common way to interact with the service. They require the `xmltramp2` and `requests` libraries.
- **Basic Pattern**: `python <tool_name>.py --email <email> [options] --sequence <data>`
- **Example (Clustal Omega)**:
  `python clustalo.py --email user@example.com --sequence sp:wap_rat,sp:wap_mouse`
- **Example (NCBI BLAST)**:
  `python ncbiblast.py --email user@example.com --program blastp --database uniprotkb_swissprot --stype protein --sequence <file_or_id>`

### Docker Integration
To avoid dependency issues (especially for Perl or Java environments), use the official Docker container.
- **Run Help**: `docker run --rm ebiwp/webservice-clients <tool_script> --help`
- **Run with Volume**: To save results to your local directory, mount the current path:
  `docker run --rm -v $(pwd):/results -w /results ebiwp/webservice-clients ncbiblast.pl --email user@example.com --program blastp --database uniprotkb_swissprot --stype protein --sequence query.fasta`

### Common CLI Patterns
- **Discovery**: Use `--help` with any client script to see the specific parameters (e.g., `--database`, `--matrix`, `--gapopen`) supported by that specific EBI tool.
- **Input Handling**: Most clients accept both database identifiers (e.g., `uniprot:P12345`) and local file paths for the `--sequence` argument.
- **Job Management**: The scripts are designed to be "fire and wait." They will submit the job, print the Job ID, and then poll the server until the results are ready to be downloaded.

### Expert Tips
- **Service Status**: If a job fails immediately, check if the specific tool is undergoing maintenance at EBI.
- **Data Types**: Ensure the `--stype` (sequence type) matches your input (e.g., `dna`, `rna`, or `protein`). Incorrect `stype` is a frequent cause of job submission errors.
- **Output Formats**: Use the `--outformat` parameter (where available) to specify the desired result type, such as XML, JSON, or traditional alignment formats.

## Reference documentation
- [EMBL-EBI Web Services Clients](./references/github_com_ebi-jdispatcher_webservice-clients.md)