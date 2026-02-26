# minipileup CWL Generation Report

## minipileup

### Tool Description
Generates a pileup of aligned sequencing reads, with options for variant calling and filtering.

### Metadata
- **Docker Image**: quay.io/biocontainers/minipileup:1.4b--h577a1d6_0
- **Homepage**: https://github.com/lh3/minipileup
- **Package**: https://anaconda.org/channels/bioconda/packages/minipileup/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/minipileup/overview
- **Total Downloads**: 383
- **Last updated**: 2025-04-25
- **GitHub**: https://github.com/lh3/minipileup
- **Stars**: N/A
### Original Help Text
```text
Usage: minipileup [options] in1.bam [in2.bam [...]]
Options:
  General:
    -f FILE      reference genome [null]
    -v           show variants only
    -c           output in the VCF format (force -v)
    -C           show count of each allele on both strands
    -e           use '*' to mark deleted bases
    -y           variant calling mode (-vcC -a2 -s5 -q30 -Q20)
    -V           print version number
  Alignment filter:
    -r STR       region in format of 'ctg:start-end' [null]
    -b FILE      BED or position list file to include [null]
    -P           only consider properly paired reads for paired-end reads
    -q INT       minimum mapping quality [0]
    -l INT       minimum alignment length [0]
    -S INT       minimum supplementary alignment length [0]
  Site filter:
    -Q INT       minimum base quality [0]
    -T INT       skip bases within INT-bp from either end of a read [0]
    -s INT       drop alleles with depth<INT [1]
    -a INT       drop alleles with depth<INT on either strand [0]
    -p FLOAT     drop an allele if the allele fraction is below FLOAT [0]
```

