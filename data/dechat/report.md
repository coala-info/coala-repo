# dechat CWL Generation Report

## dechat

### Tool Description
Repeat and haplotype aware error correction in nanopore sequencing reads with DeChat

### Metadata
- **Docker Image**: quay.io/biocontainers/dechat:1.0.1--h56e2c18_1
- **Homepage**: https://github.com/LuoGroup2023/DeChat
- **Package**: https://anaconda.org/channels/bioconda/packages/dechat/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/dechat/overview
- **Total Downloads**: 2.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/LuoGroup2023/DeChat
- **Stars**: N/A
### Original Help Text
```text
Repeat and haplotype aware error correction in nanopore sequencing reads with DeChat
Usage: dechat [options] -o <output> -t <thread>  -i <reads> <...>
Options:
  Input/Output:
       -o STR       prefix of output files [(null)]
                   The output for the stage 1 of correction is "recorrected.fa", 
                    The final corrected file is "file name".ec.fa;
       -t INT       number of threads [1]
       -h           show help information
       -v --version show version number
       -i           input reads file
       -k INT       k-mer length (must be <64) [21]
  Error correction stage 1 (dBG):
       -r1           set the maximal abundance threshold for a k-mer in dBG [2]
       -d           input reads file for building dBG (Default use input ONT reads) 
  Error correction stage 2 (MSA):
       -r            round of correction in alignment [3]
       -e            maximum allowed error rate used for filtering overlaps [0.04]
```

