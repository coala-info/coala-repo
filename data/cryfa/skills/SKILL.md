---
name: cryfa
description: "Cryfa is a security and compression utility that encrypts genomic data and compacts FASTA/FASTQ sequences. Use when user asks to encrypt or decrypt genomic files, compress FASTA or FASTQ datasets, or generate secure cryptographic keys for data protection."
homepage: https://github.com/smortezah/cryfa
---


# cryfa

## Overview

Cryfa is a specialized security and compression utility tailored for genomic datasets. It serves two primary functions: providing robust encryption for text-based genomic formats (including VCF, SAM, and BAM) and compacting FASTA/FASTQ sequences by a factor of approximately 3x. The tool is designed to be pipeline-friendly, utilizing standard output streams and offering multithreaded performance for large-scale data processing.

## Command Line Usage

### Basic Operations

**Encrypt and Compact (FASTA/FASTQ)**
Cryfa automatically detects the format and applies compaction to FASTA/FASTQ files during encryption.
```bash
./cryfa -k pass.txt input.fq > compressed_encrypted.cryfa
```

**Decrypt and Unpack**
Use the `-d` flag to reverse the process.
```bash
./cryfa -k pass.txt -d compressed_encrypted.cryfa > original.fq
```

**Encrypt Generic Genomic Data (VCF/SAM/BAM)**
For non-sequence formats, Cryfa provides encryption without sequence-specific compaction.
```bash
./cryfa -k pass.txt input.vcf > encrypted.vcf.cryfa
```

### Key Management

Cryfa requires a key file containing a password of at least 8 characters.

1.  **Recommended Method (keygen):** Use the included `keygen` utility to generate a cryptographically strong password.
    ```bash
    ./keygen
    ```
    Follow the prompts to enter a raw password and specify a filename to save the generated strong key.

2.  **Manual Method:** Create a simple text file with your password.
    ```bash
    echo "YourStrongPassword123!" > pass.txt
    ```

### Advanced Options

| Option | Description |
| :--- | :--- |
| `-t [NUMBER]` | Set the number of threads for parallel processing. |
| `-f`, `--force` | Force the tool to treat input as non-FASTA/FASTQ (disables compaction, performs shuffle and encryption only). |
| `-s`, `--stop_shuffle` | Disables the shuffling phase of the encryption process. |
| `-v`, `--verbose` | Enables verbose mode for detailed processing information. |

## Expert Tips and Best Practices

*   **Format Agnosticism:** Cryfa identifies file types by inspecting file headers rather than extensions. You do not need to rename files for the tool to recognize FASTA or FASTQ structures.
*   **Pipeline Integration:** Since Cryfa outputs to `stdout`, it can be piped directly into other tools or compression utilities:
    ```bash
    ./cryfa -k pass.txt input.fa | gzip > final_output.fa.cryfa.gz
    ```
*   **Security Standards:** For maximum security, always use the `keygen` utility. A "strong" password should be at least 12 characters and include a mix of cases, digits, and symbols.
*   **Performance:** When working with high-throughput sequencing data (large FASTQ files), always specify the `-t` flag matching your available CPU cores to significantly reduce processing time.

## Reference documentation
- [Cryfa GitHub README](./references/github_com_smortezah_cryfa_blob_master_README.md)