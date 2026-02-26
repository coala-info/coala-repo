# npinv CWL Generation Report

## npinv

### Tool Description
Read a SE bam file and get the inversion

### Metadata
- **Docker Image**: quay.io/biocontainers/npinv:1.24--py312h7e72e81_6
- **Homepage**: https://github.com/haojingshao/npInv
- **Package**: https://anaconda.org/channels/bioconda/packages/npinv/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/npinv/overview
- **Total Downloads**: 4.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/haojingshao/npInv
- **Stars**: N/A
### Original Help Text
```text
No Key Name: output
Program function: Read a SE bam file and get the inversion
Version:	1.24
--output[String] file to write
--input[String] file to read
optional:
--region[String] Specify the region for running.
                 Such as chr9:1-1000 OR chr9 OR all Default[all]
--minAln[int] minimum size for Alignment & Inv. Default[500]
--IRdatabase[String] An inverted repeat file for the reference in bed format. Default[none]
--min[int] minimum size of an inversion. Default[500]
--max[int] maximum size of an inversion. Default[10000]
--window[int] minimun window size (bp) to merge inversion breakpoints. Default[2000]
--threshold[int] minimum number of supporting reads for an inversion. Default[3]
--help Show usage
For example: java -jar npInv.jar --input sample.bam --output sample.VCF
```

