# ratatosk CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| ratatosk_correct | PASS |  |
| ratatosk_index | PASS |  |

## ratatosk_correct

### Tool Description
Correct long reads with short reads (hybrid error correction using colored de Bruijn graphs).

### Metadata
- **Docker Image**: quay.io/biocontainers/ratatosk:0.9.0--h077b44d_2
- **Homepage**: https://github.com/DecodeGenetics/Ratatosk
- **Package**: https://anaconda.org/channels/bioconda/packages/ratatosk/overview
- **Validation**: PASS

### Original Help Text
```text

Ratatosk 0.9.0

Hybrid error correction of long reads using colored de Bruijn graphs

Usage: Ratatosk [COMMAND] [PARAMETERS]
Usage: Ratatosk --help
Usage: Ratatosk --version
Usage: Ratatosk --cite

IMPORTANT: input (short) reads from the same pair MUST have the same name. /1 or /2 suffixes are not allowed.

[COMMAND]: correct

[PARAMETERS]:

   > Mandatory with required argument:

   -s, --in-short                  Input short read file in fasta/fastq(.gz)
                                   List of input short read files (one file per line)
   -l, --in-long                   Input long read file to correct in fasta/fastq(.gz)
                                   List of input long read files to correct (one file per line)
   -o, --out-long                  Output corrected long read file

   > Optional with required argument:

   -c, --cores                     Number of cores (default: 1)
   -S, --subsampling               Rate of short reads subsampling (default: Auto)
   -t, --trim-split                Trim and split bases with quality score < t (default: no trim/split)
                                   Only sub-read with length >= 63 are output if used
   -u, --in-unmapped-short         Input unmapped short read file in fasta/fastq(.gz)
                                   List of input unmapped short read files (one file per line)
   -a, --in-accurate-long          Input high quality long read file in fasta/fastq(.gz)
                                   List of input high quality long read files (one file per line)
                                   (Those reads are NOT corrected but assist the correction of reads in input)
   -g, --in-graph                  Load graph file prepared with the index command
   -d, --in-unitig-data            Load unitig data file prepared with the index command
   -Q, --max-base-qual             Maximum base quality of input long reads (default: 40)

   > Optional with no argument:

   -G, --gzip-out                  Output file is compressed with gzip
   -O, --force-io-order            Force same long read input/output order
   -v, --verbose                   Print information

[ADVANCED PARAMETERS]:

   > Optional with required argument:

   -m, --min-conf-snp-corr         Minimum confidence threshold to correct a SNP (default: 0.9)
   -M, --min-conf-color2           Minimum confidence threshold to color vertices for 2nd pass (default: 0)
   -C, --min-len-color2            Minimum length of a long read to color vertices for 2nd pass (default: 3000)
   -i, --insert-sz                 Insert size of the input paired-end short reads (default: 500)
   -k, --k1                        Length of short k-mers for 1st pass (default: 31)
   -K, --k2                        Length of long k-mers for 2nd pass (default: 63)
   -w, --max-len-weak1             Do not correct non-solid regions >= w bases during 1st pass (default: 1000)
   -W, --max-len-weak2             Do not correct non-solid regions >= w bases during 2nd pass (default: 5000)

   > Optional with no argument:

   -1, --1st-pass-only             Perform *only* the 1st correction pass (default: false)
   -2, --2nd-pass-only             Perform *only* the 2nd correction pass (default: false)
   -F, --no-snp-correction         Disable SNP detection and correction
   -I, --no-graph-index            Disable graph index output

[EXPERIMENTAL PARAMETERS]:

   > Optional with required argument:

   -L, --in-long_raw               Input long read file from 1st pass (FASTA/FASTQ possibly gzipped)
                                   List of input long read files to correct (one file per line)
   -p, --in-short-phase            Input short read phasing file (diploid only)
                                   List of input short read phasing files (one file per line)
   -P, --in-long-phase             Input long read phasing file (diploid only)
                                   List of input long read phasing files (one file per line)
```

## ratatosk_index

### Tool Description
Prepare a Ratatosk index (advanced).

### Metadata
- **Docker Image**: quay.io/biocontainers/ratatosk:0.9.0--h077b44d_2
- **Homepage**: https://github.com/DecodeGenetics/Ratatosk
- **Package**: https://anaconda.org/channels/bioconda/packages/ratatosk/overview
- **Validation**: PASS

### Original Help Text
```text

Ratatosk 0.9.0

Hybrid error correction of long reads using colored de Bruijn graphs

Usage: Ratatosk [COMMAND] [PARAMETERS]
Usage: Ratatosk --help
Usage: Ratatosk --version
Usage: Ratatosk --cite

IMPORTANT: input (short) reads from the same pair MUST have the same name. /1 or /2 suffixes are not allowed.

[COMMAND]: index

[PARAMETERS]:

   > Mandatory with required argument:

   -s, --in-short                  Input short read file in fasta/fastq(.gz)
                                   List of input short read files (one file per line)
   -l, --in-long                   Input long read file to correct in fasta/fastq(.gz)
                                   List of input long read files to correct (one file per line)
   -o, --out-long                  Prefix of the output index file

   > Mandatory with no argument:

   -1, --1st-pass-only             Prepare index for the 1st correction pass (default: false)
   -2, --2nd-pass-only             Prepare index for the the 2nd correction pass (default: false)

   > Optional with required argument:

   -c, --cores                     Number of cores (default: 1)
   -S, --subsampling               Rate of short reads subsampling (default: No subsampling)
   -u, --in-unmapped-short         Input unmapped short read file in fasta/fastq(.gz)
                                   List of input unmapped short read files (one file per line)
   -a, --in-accurate-long          Input high quality long read file in fasta/fastq(.gz)
                                   List of input high quality long read files (one file per line)
                                   (Those reads are NOT corrected but assist the correction of reads in input)
   -g, --in-graph                  Load graph file prepared with the index command
   -Q, --max-base-qual             Maximum base quality of input long reads (default: 40)

   > Optional with no argument:

   -v, --verbose                   Print information

[ADVANCED PARAMETERS]:

   > Optional with required argument:

   -M, --min-conf-color2           Minimum confidence threshold to color vertices for 2nd pass (default: 0)
   -C, --min-len-color2            Minimum length of a long read to color vertices for 2nd pass (default: 3000)
   -i, --insert-sz                 Insert size of the input paired-end short reads (default: 500)
   -k, --k1                        Length of short k-mers for 1st pass (default: 31)
   -K, --k2                        Length of long k-mers for 2nd pass (default: 63)

   > Optional with no argument:

   -F, --no-snp-correction         Disable SNP detection and correction
   -I, --no-graph-index            Disable graph index output
```

