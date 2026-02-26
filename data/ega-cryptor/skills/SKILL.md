---
name: ega-cryptor
description: The ega-cryptor tool encrypts genomic data files and generates required MD5 checksums for secure submission to the European Genome-phenome Archive. Use when user asks to encrypt files for EGA submission, generate encrypted and unencrypted MD5 sums, or prepare sensitive data for archival.
homepage: https://ega-archive.org/submission/data/file-preparation/egacryptor/
---


# ega-cryptor

## Overview
The `ega-cryptor` skill facilitates the preparation of sensitive genomic data for secure archival. It focuses on the command-line execution of the EGACryptor JAVA application to transform raw data files into the specific encrypted format required by the EGA. This process includes generating both encrypted and unencrypted MD5 sums, ensuring data integrity during the subsequent transfer to EGA staging areas via FTP or Aspera.

## Usage Guidelines

### Prerequisites
- **Java Runtime**: JRE 6 or above (OpenJDK recommended).
- **JCE Policy**: For JRE versions older than 1.8.0_151, ensure "Unlimited Strength Jurisdiction Policy Files" are installed in `lib/security`.
- **Permissions**: You must have write access to the input directory, as the tool generates checksums and output folders relative to the source by default.

### Filename Requirements
Before encryption, sanitize filenames to avoid archival failures:
- Use only alphanumeric characters.
- Replace whitespaces with underscores (`_`).
- Avoid special characters: `# ? ( ) [ ] / \ = + < > : ; " ' , * ^ | &`.

### Common CLI Patterns
Run the tool using the JAR file (e.g., `EGA-Cryptor_2_0_0.jar`).

**Encrypt a single file:**
```bash
java -jar EGA-Cryptor_2_0_0.jar -i example.bam
```

**Encrypt multiple specific files:**
```bash
java -jar EGA-Cryptor_2_0_0.jar -i "file1.bam,file2.bam"
```

**Encrypt an entire directory (recursive structure):**
```bash
java -jar EGA-Cryptor_2_0_0.jar -i /path/to/input_dir -o /path/to/output_dir
```

### Performance and Threading
By default, the tool runs in single-threaded mode. Use these flags to optimize processing on multi-core systems:

- `-l`: **Limited Mode**. Uses 50% of available CPU cores.
- `-m`: **Maximum Mode**. Uses 75% of available CPU cores (recommended for prioritizing encryption while keeping the system responsive).
- `-f`: **Full Capacity**. Uses all available cores.
- `-t [number]`: **Throttling**. Manually specify the exact number of threads to use.

### Output Files
For every input file `data.bam`, the tool produces:
1. `data.bam.gpg`: The encrypted data file.
2. `data.bam.md5`: MD5 checksum of the unencrypted file.
3. `data.bam.gpg.md5`: MD5 checksum of the encrypted file.

## Troubleshooting
- **Permission Denied**: If you see `UnixFileSystem.createFileExclusively`, ensure you have write permissions in the directory where the source files are located.
- **Help Menu**: Access the built-in documentation using the `-h` flag.

## Reference documentation
- [EGACryptor File Preparation Guide](./references/ega-archive_org_submission_data_file-preparation_egacryptor.md)
- [EGA-Cryptor Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_ega-cryptor_overview.md)