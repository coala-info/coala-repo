# cancerit-allelecount CWL Generation Report

## cancerit-allelecount_alleleCounter

### Tool Description
Counts alleles in a BAM/CRAM file based on a loci file.

### Metadata
- **Docker Image**: quay.io/biocontainers/cancerit-allelecount:4.3.0--h8bd2d3b_7
- **Homepage**: https://github.com/cancerit/alleleCount
- **Package**: https://anaconda.org/channels/bioconda/packages/cancerit-allelecount/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cancerit-allelecount/overview
- **Total Downloads**: 36.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/cancerit/alleleCount
- **Stars**: N/A
### Original Help Text
```text
Loci file (null) does not appear to exist.
Usage: alleleCounter -l loci_file.txt -b sample.bam -o output.txt [-m int] [-r ref.fa.fai]

 -l  --loci-file [file]           Path to loci file.
 -b  --hts-file [file]            Path to sample HTS file.
 -o  --output-file [file]         Path write output file.

Optional
 -r  --ref-file [file]           Path to reference fasta index file.
                                 NB. If cram format is supplied via -b and the reference listed in the cram header
                                     can't be found alleleCounter may fail to work correctly.
 -m  --min-base-qual [int]       Minimum base quality [Default: 20].
 -q  --min-map-qual [int]        Minimum mapping quality [Default: 35].
 -c  --contig [string]           Limit calling to named contig.
 -d  --dense-snps                Improves performance where many positions are close together 
 -x  --is-10x                    Enables 10X processing mode.
                                   In this mode the HTS input file must be a cellranger produced BAM file.  Allele
                                   counts are then given on a per-cellular barcode basis, with each count representing
                                   the consensus base for that UMI. 
                                 by iterating through bam file rather than using a 'fetch' approach.
 -f  --required-flag [int]       Flag value of reads to retain in allele counting default: [3].
                                 N.B. if the proper-pair flag is are selected, alleleCounter will assume paired-end
                                 and filter out any proper-pair flagged reads not in F/R orientation. -F  --filtered-flag [int]       Flag value of reads to exclude in allele counting default: [3852].
 -v  --version                   Display version number.
 -h  --help                      Display this usage information.
```

