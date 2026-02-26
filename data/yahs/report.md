# yahs CWL Generation Report

## yahs

### Tool Description
Scaffold contigs using Hi-C data

### Metadata
- **Docker Image**: quay.io/biocontainers/yahs:1.2.2--he4a0461_0
- **Homepage**: https://github.com/c-zhou/yahs
- **Package**: https://anaconda.org/channels/bioconda/packages/yahs/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/yahs/overview
- **Total Downloads**: 18.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/c-zhou/yahs
- **Stars**: N/A
### Original Help Text
```text
Usage: yahs [options] <contigs.fa> <hic.bed>|<hic.bam>|<hic.pa5>|<hic.bin>
Options:
    -a FILE                AGP file (for rescaffolding) [none]
    -r INT[,INT,...]       list of resolutions in ascending order [automate]
    -R INT                 rounds to run at each resoultion level [1]
    -e STR                 restriction enzyme cutting sites [none]
    -l INT                 minimum length of a contig to scaffold [0]
    -q INT                 minimum mapping quality [10]

    --no-contig-ec         do not do contig error correction
    --no-scaffold-ec       do not do scaffold error correction
    --no-mem-check         do not do memory check at runtime
    --file-type   STR      input file type BED|BAM|PA5|BIN, file name extension is ignored if set
    --read-length          read length (required for PA5 format input) [150]
    --telo-motif  STR      telomeric sequence motif

    -o STR                 prefix of output files [yahs.out]
    -v INT                 verbose level [0]
    -?                     print long help with extra option list
    --version              show version number
```

