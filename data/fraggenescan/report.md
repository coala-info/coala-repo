# fraggenescan CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| fraggenescan_FragGeneScan | PASS | last gene end differs by 1 base from the Galaxy expected file, 687 of 688 genes identical |
| fraggenescan_run_FragGeneScan.pl | PASS |  |

## fraggenescan_FragGeneScan

### Tool Description
Predicts genes in genomic sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/fraggenescan:1.32--h7b50bb2_1
- **Homepage**: https://sourceforge.net/projects/fraggenescan/
- **Package**: https://anaconda.org/channels/bioconda/packages/fraggenescan/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/fraggenescan/overview
- **Total Downloads**: 63.1K
- **Last updated**: 2025-09-16
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
USAGE: ./FragGeneScan.pl -s [seq_file_name] -o [output_file_name] -w [1 or 0] -t [train_file_name] (-p [thread_num])

       Mandatory parameters
       [seq_file_name]:    sequence file name including the full path
       [output_file_name]: output file name including the full path
       [1 or 0]:           1 if the sequence file has complete genomic sequences
                           0 if the sequence file has short sequence reads
       [train_file_name]:  file name that contains model parameters; this file should be in the "train" directory
                           Note that four files containing model parameters already exist in the "train" directory
                           [complete] for complete genomic sequences or short sequence reads without sequencing error
                           [sanger_5] for Sanger sequencing reads with about 0.5% error rate
                           [sanger_10] for Sanger sequencing reads with about 1% error rate
                           [454_5] for 454 pyrosequencing reads with about 0.5% error rate
                           [454_10] for 454 pyrosequencing reads with about 1% error rate
                           [454_30] for 454 pyrosequencing reads with about 3% error rate
                           [illumina_5] for Illumina sequencing reads with about 0.5% error rate
                           [illumina_10] for Illumina sequencing reads with about 1% error rate

       Optional parameter
       [thread_num]:       the number of threads used by FragGeneScan; default is 1 thread.
```

## fraggenescan_run_FragGeneScan.pl

### Tool Description
Predicts genes in genomic sequences and short reads (Perl wrapper that calls the FragGeneScan binary).

### Metadata
- **Docker Image**: quay.io/biocontainers/fraggenescan:1.32--h7b50bb2_1
- **Homepage**: https://sourceforge.net/projects/fraggenescan/
- **Package**: https://anaconda.org/channels/bioconda/packages/fraggenescan/overview
- **Validation**: PASS

### Original Help Text
```text
ERROR: An input genome file was not specified.
USAGE: ./run_FragGeneScan.pl -genome=[seq_file_name] -out=[output_file_name] -complete=[1 or 0] -train=[train_file_name] (-thread=[number of thread; default 1])
       [seq_file_name]:    sequence file name including the full path
       [output_file_name]: output file name including the full path
       [1 or 0]:           1 if the sequence file has complete genomic sequences
                           0 if the sequence file has short sequence reads
       [train_file_name]:  file name that contains model parameters; this file should be in the "train" directory
                           Note that four files containing model parameters already exist in the "train" directory
                           [complete] for complete genomic sequences or short sequence reads without sequencing error
                           [sanger_5] for Sanger sequencing reads with about 0.5% error rate
                           [sanger_10] for Sanger sequencing reads with about 1% error rate
                           [454_10] for 454 pyrosequencing reads with about 1% error rate
                           [454_30] for 454 pyrosequencing reads with about 3% error rate
                           [illumina_5] for Illumina sequencing reads with about 0.5% error rate
                           [illumina_10] for Illumina sequencing reads with about 1% error rate
       [num_thread]:       number of thread used in FragGeneScan. Default 1.
```

