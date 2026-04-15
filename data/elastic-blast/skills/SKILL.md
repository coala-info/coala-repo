---
name: elastic-blast
description: Accelerates BLAST searches by distributing them across multiple cloud instances. Use when user asks to perform large-scale BLAST searches faster than stand-alone BLAST+ or when NCBI WebBLAST limitations are encountered.
homepage: https://pypi.org/project/elastic-blast/
metadata:
  docker_image: "quay.io/biocontainers/elastic-blast:1.5.0--pyhdfd78af_0"
---

# elastic-blast

yaml
name: elastic-blast
description: |
  Accelerates BLAST searches by distributing them across multiple cloud instances, making it ideal for users with a large number of queries or those who prefer cloud infrastructure. Use when you need to perform large-scale BLAST searches faster than stand-alone BLAST+ or when NCBI WebBLAST limitations are encountered.
```
## Overview

ElasticBLAST is a powerful tool designed to significantly speed up your sequence similarity searches by leveraging cloud computing. It's particularly useful when you have a substantial number of queries (thousands or more) or when you need to perform searches that are not feasible with standard NCBI WebBLAST or would take too long with stand-alone BLAST+. ElasticBLAST distributes your BLAST+ searches across multiple cloud instances, allowing for much faster completion times compared to running on a single machine.

## Usage Instructions

ElasticBLAST is primarily used via its command-line interface. The core functionality involves submitting BLAST jobs to the cloud.

### Installation

ElasticBLAST can be installed using conda:

```bash
conda install bioconda::elastic-blast
```

### Core Workflow

The general workflow involves:

1.  **Setting up cloud credentials**: Ensure your cloud environment (e.g., AWS, GCP) is configured with the necessary credentials and permissions.
2.  **Submitting BLAST jobs**: Use the `elastic-blast` command to submit your queries and specify the BLAST parameters.
3.  **Monitoring jobs**: Track the progress of your distributed BLAST searches.
4.  **Retrieving results**: Download the results once the jobs are completed.

### Command-Line Usage Examples

While specific cloud provider configurations can vary, the fundamental command structure remains consistent.

**Basic Job Submission:**

The `elastic-blast` command is used to submit jobs. You'll typically need to specify:

*   `-p`: The BLAST program to use (e.g., `blastn`, `blastp`, `blastx`, `tblastn`, `tblastx`).
*   `-d`: The BLAST database to search against.
*   `-i`: The input file containing your query sequences.
*   `--cloud-provider`: The cloud provider to use (e.g., `aws`, `gcp`).
*   `--project-name`: A name for your project.

```bash
elastic-blast \
  -p blastn \
  -d nt \
  -i queries.fasta \
  --cloud-provider aws \
  --project-name my-blast-project
```

**Specifying Output Location:**

You can direct the output to a specific location, often a cloud storage bucket.

```bash
elastic-blast \
  -p blastp \
  -d uniprot_sprot \
  -i protein_queries.fasta \
  --cloud-provider gcp \
  --project-name protein-search \
  --output-dir gs://my-bucket/blast-results/
```

**Advanced Options:**

ElasticBLAST supports many standard BLAST+ options, which can be passed directly. For example, to specify an E-value threshold:

```bash
elastic-blast \
  -p blastn \
  -d nr \
  -i dna_sequences.fastq \
  --cloud-provider aws \
  --project-name dna-search \
  -e 1e-5
```

**Monitoring and Retrieving Results:**

After submission, you can use commands to monitor job status and retrieve results. The exact commands may depend on the cloud provider and the specific version of elastic-blast, but typically involve commands like `elastic-blast --status` or `elastic-blast --download`.

Consult the official documentation for detailed instructions on cloud provider setup, advanced configuration, and specific commands for monitoring and result retrieval.

## Expert Tips

*   **Optimize Query Files**: Ensure your input query files (`-i`) are properly formatted FASTA or FASTQ. Large files can be split into smaller chunks for more efficient parallel processing.
*   **Database Choice**: Select the most appropriate BLAST database (`-d`) for your search to balance accuracy and speed. For example, `nt` for nucleotide, `nr` for protein.
*   **Cloud Provider Configuration**: Thoroughly configure your cloud provider's credentials and permissions before running jobs. This is often the most complex part of setting up ElasticBLAST. Refer to the official documentation for detailed guides on AWS and GCP.
*   **Project Naming**: Use descriptive project names (`--project-name`) to easily manage and identify your different BLAST runs.
*   **Error Handling**: Pay close attention to any error messages during job submission or execution. Issues often stem from incorrect cloud configurations or malformed input files.



## Subcommands

| Command | Description |
|---------|-------------|
| elastic-blast | This application facilitates running BLAST on large amounts of query sequence data on the cloud |
| elastic-blast delete | Deletes an ElasticBLAST job. |
| elastic-blast run-summary | Show a summary of the ElasticBLAST run. |
| elastic-blast status | Check the status of an ElasticBLAST job. |
| elastic-blast submit | Submit a BLAST search to ElasticBLAST |

## Reference documentation
- [ElasticBLAST Documentation](https://blast.ncbi.nlm.nih.gov/doc/elastic-blast/)