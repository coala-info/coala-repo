# quickdeconvolution CWL Generation Report

## quickdeconvolution_QuickDeconvolution

### Tool Description
QuickDeconvolution

### Metadata
- **Docker Image**: quay.io/biocontainers/quickdeconvolution:1.2--h9f5acd7_1
- **Homepage**: https://github.com/RolandFaure/QuickDeconvolution
- **Package**: https://anaconda.org/channels/bioconda/packages/quickdeconvolution/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/quickdeconvolution/overview
- **Total Downloads**: 3.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/RolandFaure/QuickDeconvolution
- **Stars**: N/A
### Original Help Text
```text
Could not parse the arguments
SYNOPSIS
        QuickDeconvolution -i [<i>] -o [<o>] [-k [<k>]] [-w [<w>]] [-d [<d>]] [-t [<t>]] [-a [<a>]]
                           [-m]

OPTIONS
        -i, --input-file
                    input file (mandatory)

        -o, --output-file
                    file to write the output (mandatory)

        -k, --kmers-length
                    size of kmers [default:20]

        -w, --window-size
                    size of window guaranteed to contain at least one minimizing kmer [default:40]

        -d, --density
                    on average 1/2^d kmers are sparse kmers [default:3]

        -t, --threads
                    number of threads [default:1]

        -a, --dropout
                    QD does not try to deconvolve clouds smaller than this value [default:0]

        -m, --metagenome
                    Use this option on metagenomic samples
```

