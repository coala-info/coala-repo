# dirseq CWL Generation Report

## dirseq

### Tool Description
Reports the coverage of a mapping in against each gene given in a GFF file

### Metadata
- **Docker Image**: quay.io/biocontainers/dirseq:0.4.3--hdfd78af_0
- **Homepage**: https://github.com/wwood/dirseq
- **Package**: https://anaconda.org/channels/bioconda/packages/dirseq/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/dirseq/overview
- **Total Downloads**: 2.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/wwood/dirseq
- **Stars**: N/A
### Original Help Text
```text
Usage: dirseq <arguments>

    Reports the coverage of a mapping in against each gene given in a GFF file

        --bam FILE                   path to mapping file [required]
        --gff FILE                   path to GFF3 file [required]

Optional parameters:

        --forward-read-only          consider only forward reads (i.e. read1) and ignore reverse reads. [default false]
        --ignore-directions          ignore directionality, give overall coverage [default: false i.e. differentiate between directions]
        --measure-type TYPE          what to count for each gene [options: count, coverage][default: coverage]
        --accepted-feature-types TYPE
                                     Print only features of these type(s) [default CDS]
        --comment-fields COMMA_SEPARATED_FIELDS
                                     Print elements from the comments in the GFF file [default ID]
        --sam-filter-flags           Apply these samtools filters [default: -F0x100 -F0x800]

Verbosity:

    -q, --quiet                      Run quietly, set logging to ERROR level [default INFO]
        --logger filename            Log to file [default stderr]
        --trace options              Set log level [default INFO]. e.g. '--trace debug' to set logging level to DEBUG
```

