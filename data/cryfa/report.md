# cryfa CWL Generation Report

## cryfa

### Tool Description
A secure encryption tool for genomic data. Compacts and encrypts FASTA/FASTQ files, or encrypts any text-based genomic data like VCF/SAM/BAM.

### Metadata
- **Docker Image**: quay.io/biocontainers/cryfa:20.04--h9948957_3
- **Homepage**: https://github.com/smortezah/cryfa
- **Package**: https://anaconda.org/channels/bioconda/packages/cryfa/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cryfa/overview
- **Total Downloads**: 8.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/smortezah/cryfa
- **Stars**: N/A
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
INFO:    Inserting Apptainer configuration...
INFO:    Creating SIF file...
[1mNAME[0m
      Cryfa - a secure encryption tool for genomic data 

[1mSYNOPSIS[0m
      ./cryfa [[4mOPTION[0m]... -k [[4mKEY_FILE[0m] [-d] [[4mIN_FILE[0m] > [[4mOUT_FILE[0m] 

[1mSAMPLE[0m
      [3mEncrypt and Compact[0m:  ./cryfa -k pass.txt in.fq > comp 
      [3mDecrypt and Unpack[0m:   ./cryfa -k pass.txt -d comp > orig.fq 

      [3mEncrypt[0m:              ./cryfa -k pass.txt in > enc 
      [3mDecrypt[0m:              ./cryfa -k pass.txt -d enc > orig 

[1mOPTIONS[0m
      Compact & encrypt FASTA/FASTQ files. 
      Encrypt any text-based genomic data, e.g., VCF/SAM/BAM. 

      [1m-k[0m [[4mKEY_FILE[0m],  [1m--key[0m [[4mKEY_FILE[0m] 
           key file name -- [3mMANDATORY[0m
           The KEY_FILE should contain a password. 
           To make a strong password, the "keygen" program can be
           used via the command "./keygen".

      [1m-d[0m,  [1m--dec[0m
           decrypt & unpack 

      [1m-f[0m,  [1m--force[0m
           force to consider input as non-FASTA/FASTQ 
           Forces Cryfa not to compact, but shuffle and encrypt.
           If the input is FASTA/FASTQ, it is considered as
           non-FASTA/FASTQ; so, compaction will be ignored, but
           shuffling and encryption will be performed.

      [1m-s[0m,  [1m--stop_shuffle[0m
           stop shuffling the input 

      [1m-t[0m [[4mNUMBER[0m],  [1m--thread[0m [[4mNUMBER[0m] 
           number of threads 

      [1m-v[0m,  [1m--verbose[0m
           verbose mode (more information) 

      [1m-h[0m,  [1m--help[0m
           usage guide 

      [1m--version[0m
           version information 

      Note that the maximum file size supported is 64 GB. For
      larger files, you can split them, e.g. by "split"
      command, and encrypt each chunk. After the decryption,
      you can concatenate the chunks, e.g. by "cat" command.
```


## Metadata
- **Skill**: generated

## cryfa_keygen

### Tool Description
A utility to generate a key for Cryfa encryption by providing a password and an output file path.

### Metadata
- **Docker Image**: quay.io/biocontainers/cryfa:20.04--h9948957_3
- **Homepage**: https://github.com/smortezah/cryfa
- **Package**: https://anaconda.org/channels/bioconda/packages/cryfa/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
Enter a password, then press 'Enter':
Enter a file name to save the generated key, then press 'Enter':
```

