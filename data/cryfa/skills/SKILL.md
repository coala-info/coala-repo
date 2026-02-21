---
name: cryfa
description: Cryfa is a specialized security tool for genomic data that combines AES encryption with sequence compaction.
homepage: https://github.com/smortezah/cryfa
---

# cryfa

## Overview
Cryfa is a specialized security tool for genomic data that combines AES encryption with sequence compaction. While it can encrypt any text-based genomic format (such as VCF or SAM), it features a unique capability to compact FASTA and FASTQ sequences by approximately a factor of 3 during the encryption process. It is designed to be used within bioinformatics pipelines, utilizing standard output streams for easy integration with other tools.

## Installation
The most efficient way to install cryfa is via Bioconda:
```bash
conda install bioconda::cryfa
```

## Key Management
Cryfa requires a key file containing a password of at least 8 characters. For maximum security, use the included `keygen` utility to generate a strong password.

1. Run the generator: `./keygen`
2. Enter a raw password when prompted.
3. Specify a filename (e.g., `key.txt`) to save the generated strong key.

## Common CLI Patterns

### FASTA/FASTQ Compaction and Encryption
Cryfa automatically detects sequence formats and applies compaction by default.
```bash
# Compact and encrypt a sequence file
cryfa -k key.txt input.fastq > encrypted_data.cryfa
```

### Decrypting and Unpacking
Use the `-d` flag to return the data to its original state.
```bash
# Decrypt and restore original sequence data
cryfa -k key.txt -d encrypted_data.cryfa > original.fastq
```

### Encrypting Non-Sequence Genomic Data
For formats like VCF, SAM, or BAM, cryfa performs encryption without compaction.
```bash
# Encrypt a VCF file
cryfa -k key.txt input.vcf > encrypted_vcf.cryfa
```

### Forcing Encryption Without Compaction
If you have a FASTA/FASTQ file but wish to skip the compaction step (e.g., for faster processing when storage is not a concern), use the `--force` flag.
```bash
# Encrypt sequence data without compacting
cryfa -k key.txt -f input.fa > encrypted_only.cryfa
```

## Expert Tips
- **Threading**: For large genomic datasets, use the `-t` option to specify the number of threads and significantly decrease processing time.
- **Format Agnosticism**: Cryfa detects file types by content rather than extension. You do not need to worry about specific file suffixes for the tool to recognize FASTA or FASTQ headers.
- **Pipeline Integration**: Since cryfa outputs to `stdout`, you can pipe the results directly into other tools or compression utilities:
  ```bash
  cryfa -k key.txt input.fq | gzip > final_output.cryfa.gz
  ```
- **Shuffling**: By default, cryfa shuffles data for extra security. If your workflow requires maintaining specific block orders or you want to reduce CPU overhead, use `-s` to stop shuffling.

## Reference documentation
- [Cryfa GitHub Repository](./references/github_com_smortezah_cryfa.md)
- [Bioconda Cryfa Package Overview](./references/anaconda_org_channels_bioconda_packages_cryfa_overview.md)