# ngs_te_mapper2 CWL Generation Report

## ngs_te_mapper2

### Tool Description
Script to detect non-reference TEs from single end short read data

### Metadata
- **Docker Image**: quay.io/biocontainers/ngs_te_mapper2:1.0.2--pyhdfd78af_1
- **Homepage**: https://github.com/bergmanlab/ngs_te_mapper2
- **Package**: https://anaconda.org/channels/bioconda/packages/ngs_te_mapper2/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ngs_te_mapper2/overview
- **Total Downloads**: 2.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/bergmanlab/ngs_te_mapper2
- **Stars**: N/A
### Original Help Text
```text
usage: ngs_te_mapper2 [-h] -f READS -l LIBRARY -r REFERENCE [-a ANNOTATION]
                      [-w WINDOW] [--min_mapq MIN_MAPQ] [--min_af MIN_AF]
                      [--tsd_max TSD_MAX] [--gap_max GAP_MAX] [-m MAPPER]
                      [-t THREAD] [-o OUT] [-p PREFIX] [-k]

Script to detect non-reference TEs from single end short read data

required arguments:
  -f READS, --reads READS
                        raw reads in fastq or fastq.gz format, separated by
                        comma
  -l LIBRARY, --library LIBRARY
                        TE concensus sequence
  -r REFERENCE, --reference REFERENCE
                        reference genome

optional arguments:
  -h, --help            show this help message and exit
  -a ANNOTATION, --annotation ANNOTATION
                        reference TE annotation in GFF3 format (must have
                        'Target' attribute in the 9th column)
  -w WINDOW, --window WINDOW
                        merge window for identifying TE clusters (default =
                        10)
  --min_mapq MIN_MAPQ   minimum mapping quality of alignment (default = 20)
  --min_af MIN_AF       minimum allele frequency (default = 0.1)
  --tsd_max TSD_MAX     maximum TSD size (default = 25)
  --gap_max GAP_MAX     maximum gap size (default = 5)
  -m MAPPER, --mapper MAPPER
                        read alignment program (default = 'bwa')
  -t THREAD, --thread THREAD
                        thread (default = 1)
  -o OUT, --out OUT     output dir (default = '.')
  -p PREFIX, --prefix PREFIX
                        output prefix
  -k, --keep_files      If provided then all intermediate files will be kept
                        (default: remove intermediate files)
```

