# cosigt CWL Generation Report

## cosigt

### Tool Description
genotyping loci in pangenome graphs using cosine distance

### Metadata
- **Docker Image**: quay.io/biocontainers/cosigt:0.1.7--he881be0_0
- **Homepage**: https://github.com/davidebolo1993/cosigt
- **Package**: https://anaconda.org/channels/bioconda/packages/cosigt/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cosigt/overview
- **Total Downloads**: 3.9K
- **Last updated**: 2025-12-22
- **GitHub**: https://github.com/davidebolo1993/cosigt
- **Stars**: N/A
### Original Help Text
```text
usage: cosigt [-h|--help] -p|--paths "<value>" -g|--gafpack "<value>"
              [-b|--blacklist "<value>"] [-c|--cluster "<value>"] [-m|--mask
              "<value>"] [-w|--weights "<value>"] [-n|--ploidy <integer>]
              -o|--output "<value>" -i|--id "<value>"

              genotyping loci in pangenome graphs using cosine distance

Arguments:

  -h  --help       Print help information
  -p  --paths      gzip-compressed tsv file with path names and node coverages
                   from odgi paths
  -g  --gafpack    gzip-compressed tsv file with node coverages for a sample
                   from gafpack
  -b  --blacklist  txt file with names of paths to exclude (one string per
                   line)
  -c  --cluster    cluster json file as generated with cluster.r
  -m  --mask       boolean mask to ignore node coverages (one boolean per line)
  -w  --weights    file with node weights (one float64 per line)
  -n  --ploidy     ploidy level (default: 2). Default: 2
  -o  --output     folder prefix for output files
  -i  --id         sample name
```


## Metadata
- **Skill**: generated
