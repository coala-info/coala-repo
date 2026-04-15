---
name: jpredapi
description: The jpredapi tool provides a programmatic interface for submitting protein sequences to the JPred4 REST API for secondary structure prediction. Use when user asks to submit protein sequences or alignments for prediction, monitor job status, or download prediction results.
homepage: https://github.com/MoseleyBioinformaticsLab/jpredapi
metadata:
  docker_image: "quay.io/biocontainers/jpredapi:1.5.6--py_0"
---

# jpredapi

## Overview

The `jpredapi` tool is a Python-based interface for JPred, a widely used server for predicting protein secondary structure. It allows researchers to bypass the web interface by submitting sequences directly to the JPred4 REST API. This skill enables the programmatic submission of single sequences or multiple alignments, monitoring of job progress, and the downloading of prediction results (such as DSSP, Jnet, and solvent accessibility) once processing is complete.

## Command Line Usage

The tool can be invoked using `jpredapi` or `python3 -m jpredapi`.

### Submitting Jobs
Submit a protein sequence for prediction. JPred requires a valid email address for job tracking.

```bash
# Submit a single sequence in FASTA format
jpredapi submit --seq <sequence_file.fasta> --user_email <email@example.com> --job_name <my_protein_job>

# Submit a Multiple Sequence Alignment (MSA)
jpredapi submit --msa <alignment_file.txt> --user_email <email@example.com>
```

### Monitoring and Retrieval
Jobs on JPred are asynchronous. You must check the status before attempting to download results.

```bash
# Check the status of a specific job ID
jpredapi status --jobid <job_id_string>

# Download results once the status is 'finished'
jpredapi get_results --jobid <job_id_string> --dir <output_directory>

# Check the current version of the JPred REST API
jpredapi check_rest_version
```

## Best Practices and Expert Tips

- **Retry Logic**: JPred is a shared resource and may occasionally time out. Use the `--attempts` flag to specify how many times the tool should try to communicate with the server before failing.
  ```bash
  jpredapi status --jobid <id> --attempts=5
```
- **Job Naming**: Always provide a unique `--job_name` when submitting multiple sequences to easily distinguish between result folders.
- **Email Requirements**: Ensure the email provided is valid; JPred uses this to prevent abuse and may send notifications for long-running jobs.
- **Rate Limiting**: Avoid submitting hundreds of jobs simultaneously. JPred has server-side limits. For large-scale batches, implement a sleep delay between submissions.
- **Result Formats**: The `get_results` command downloads a compressed archive. Common files inside include `.jnet` (Jnet predictions), `.concise` (summary), and `.pdf` (visual summary).



## Subcommands

| Command | Description |
|---------|-------------|
| jpredapi | The JPred API allows users to submit jobs from the command-line. |
| jpredapi | jpredapi command-line interface The JPred API allows users to submit jobs from the command-line. |
| jpredapi check_rest_version | Check the version of the REST API. |
| jpredapi get_results | Retrieves the results of a JPred API job. |
| jpredapi quota | Check your JPred API quota |

## Reference documentation

- [jpredapi GitHub README](./references/github_com_MoseleyBioinformaticsLab_jpredapi_blob_master_README.rst.md)
- [jpredapi Changelog and Version History](./references/github_com_MoseleyBioinformaticsLab_jpredapi_blob_master_CHANGELOG.rst.md)