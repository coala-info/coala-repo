# sansa CWL Generation Report

## sansa_annotate

### Tool Description
Annotate structural variants

### Metadata
- **Docker Image**: quay.io/biocontainers/sansa:0.2.5--h4d20210_0
- **Homepage**: https://github.com/dellytools/sansa
- **Package**: https://anaconda.org/channels/bioconda/packages/sansa/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/sansa/overview
- **Total Downloads**: 17.9K
- **Last updated**: 2025-10-14
- **GitHub**: https://github.com/dellytools/sansa
- **Stars**: N/A
### Original Help Text
```text
Usage: sansa annotate [OPTIONS] input.bcf

Generic options:
  -? [ --help ]                         show help message
  -a [ --anno ] arg (="anno.bcf")       output annotation VCF/BCF file
  -o [ --output ] arg (="query.tsv.gz") gzipped output file for query SVs

SV annotation file options:
  -d [ --db ] arg                       database VCF/BCF file
  -b [ --bpoffset ] arg (=50)           max. breakpoint offset
  -r [ --ratio ] arg (=0.800000012)     min. reciprocal overlap
  -s [ --strategy ] arg (=best)         matching strategy [best|all]
  -n [ --notype ]                       do not require matching SV types
  -m [ --nomatch ]                      report SVs without match in database 
                                        (ANNOID=None)

BED/GTF/GFF3 annotation file options:
  -g [ --gtf ] arg                      gtf/gff3/bed file
  -i [ --id ] arg (=gene_name)          gtf/gff3 attribute
  -f [ --feature ] arg (=gene)          gtf/gff3 feature
  -t [ --distance ] arg (=1000)         max. distance (0: overlapping features 
                                        only)
  -c [ --contained ]                    report contained genes (useful for CNVs
                                        but potentially long list of genes)
```


## sansa_markdup

### Tool Description
Filter sites for PASS

### Metadata
- **Docker Image**: quay.io/biocontainers/sansa:0.2.5--h4d20210_0
- **Homepage**: https://github.com/dellytools/sansa
- **Package**: https://anaconda.org/channels/bioconda/packages/sansa/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: sansa markdup [OPTIONS] <input.bcf>

Generic options:
  -? [ --help ]                         show help message
  -o [ --outfile ] arg                  Filtered SV BCF output file
  -y [ --quality ] arg (=300)           min. SV site quality
  -b [ --bpdiff ] arg (=50)             max. SV breakpoint offset
  -s [ --sizeratio ] arg (=0.800000012) min. SV size ratio
  -d [ --divergence ] arg (=0.100000001)
                                        max. SV allele divergence
  -c [ --carrier ] arg (=0.25)          min. fraction of shared SV carriers
  -p [ --pass ]                         Filter sites for PASS
  -t [ --tag ]                          Tag duplicate marked sites in the 
                                        FILTER column instead of removing them
```


## sansa_compvcf

### Tool Description
Compare two VCF/BCF files and report differences.

### Metadata
- **Docker Image**: quay.io/biocontainers/sansa:0.2.5--h4d20210_0
- **Homepage**: https://github.com/dellytools/sansa
- **Package**: https://anaconda.org/channels/bioconda/packages/sansa/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: sansa compvcf [OPTIONS] -a <base.bcf> <input.bcf>

Generic options:
  -? [ --help ]                         show help message
  -a [ --base ] arg                     base VCF/BCF file
  -y [ --quality ] arg (=0)             min. SV site quality
  -m [ --minsize ] arg (=50)            min. SV size
  -n [ --maxsize ] arg (=100000)        max. SV size
  -e [ --minac ] arg (=1)               min. allele count
  -f [ --maxac ] arg (=10000)           max. allele count
  -b [ --bpdiff ] arg (=1000)           max. SV breakpoint offset
  -s [ --sizeratio ] arg (=0.5)         min. SV size ratio
  -d [ --divergence ] arg (=0.300000012)
                                        max. SV allele divergence
  -o [ --outprefix ] arg (=out)         output prefix
  -t [ --nosvt ]                        Ignore the SV type
  -p [ --pass ]                         Filter sites for PASS
  -i [ --ignore ]                       Ignore duplicate IDs
  -c [ --ct ]                           Require matching CT value in addition 
                                        to SV type
```


## Metadata
- **Skill**: generated
