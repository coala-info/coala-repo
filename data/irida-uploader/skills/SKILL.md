---
name: irida-uploader
description: Uploads Next-Generation Sequencing data to the IRIDA platform. Use when user asks to upload sequencing data to IRIDA.
homepage: https://github.com/phac-nml/irida-uploader
metadata:
  docker_image: "quay.io/biocontainers/irida-uploader:0.9.5--pyhdfd78af_0"
---

# irida-uploader

irida-uploader/SKILL.md
---
name: irida-uploader
description: |
  Upload Next-Generation Sequencing (NGS) data to the IRIDA (Integrated Research Data Archive) system.
  Use this skill when you need to transfer sequencing data files, such as FASTQ or BAM, from your local environment to an IRIDA instance.
  This is particularly useful for researchers and bioinformaticians managing genomic data.
---
## Overview
The irida-uploader is a command-line tool designed to facilitate the upload of Next-Generation Sequencing (NGS) data to the IRIDA platform. It streamlines the process of transferring large datasets, making it easier for researchers to manage and share their genomic information within the IRIDA ecosystem.

## Usage Instructions

The `irida-uploader` is primarily used via its command-line interface.

### Installation

The `irida-uploader` can be installed using Conda or pip:

**Conda:**
```bash
conda install bioconda::irida-uploader
```

**Pip:**
```bash
pip install irida-uploader
```

### Core Commands

The main command for interacting with the uploader is `irida-uploader`.

#### Uploading Files

The most common use case is uploading sequence files. The basic command structure involves specifying the IRIDA server URL, the project ID, and the files to upload.

**Example:**
```bash
irida-uploader upload \
  --irida-url https://your-irida-instance.org \
  --project-id 123 \
  --sample-name "SampleA" \
  --file1 /path/to/sampleA_R1.fastq.gz \
  --file2 /path/to/sampleA_R2.fastq.gz
```

**Key Arguments:**

*   `--irida-url`: The base URL of your IRIDA instance.
*   `--project-id`: The ID of the IRIDA project to upload to.
*   `--sample-name`: The name for the sample being uploaded.
*   `--file1`: The first FASTQ file (e.g., R1).
*   `--file2`: The second FASTQ file (e.g., R2), if paired-end.
*   `--metadata`: Path to a metadata file (e.g., CSV) to upload with the sample.
*   `--sequence-file-type`: Specifies the type of sequence file (e.g., `FASTQ`, `BAM`). Defaults to `FASTQ`.

#### Authentication

For secure uploads, you will typically need to authenticate with your IRIDA instance. This is often handled by providing credentials or an API token. The tool may prompt for credentials if not provided.

**Using an API Token:**
If your IRIDA instance supports API tokens, you can often pass them via environment variables or command-line arguments (check the tool's specific documentation for exact methods).

#### Advanced Options and Tips

*   **Uploading Multiple Samples:** You can upload multiple samples by running the `upload` command for each sample, or by using a metadata file that lists all samples and their associated files.
*   **Error Handling:** Pay close attention to the output for any error messages. Common issues include incorrect project IDs, network connectivity problems, or file permission errors. The tool often logs detailed information to `~/.cache/irida_uploader_test/log/irida-uploader.log` for debugging.
*   **Configuration:** The uploader might have a configuration file or allow settings via environment variables for default IRIDA URLs or credentials. Refer to the official documentation for details on configuration management.
*   **NextSeq Sample Sheets:** The tool has parsers for various sequencing platforms, including NextSeq. Ensure your sample sheet is correctly formatted to avoid parsing errors. Issues with NextSeq sample sheets have been noted in the project's issue tracker.
*   **GUI Version:** A graphical user interface (GUI) version of the uploader is also available (`irida-uploader-gui`), which can be launched after installation.

## Reference documentation
- [irida-uploader Overview](https://anaconda.org/bioconda/irida-uploader)
- [irida-uploader GitHub Repository](https://github.com/phac-nml/irida-uploader)
- [irida-uploader Documentation](https://irida-uploader.readthedocs.io/en/latest)