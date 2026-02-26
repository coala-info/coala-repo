# viewbs CWL Generation Report

## viewbs_ViewBS

### Tool Description
Tools for exploring and visualizing deep sequencing of bisulfite seuquencing (BS-seq) data.

### Metadata
- **Docker Image**: quay.io/biocontainers/viewbs:0.1.11--pl5321h7b50bb2_4
- **Homepage**: https://github.com/xie186/ViewBS
- **Package**: https://anaconda.org/channels/bioconda/packages/viewbs/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/viewbs/overview
- **Total Downloads**: 10.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/xie186/ViewBS
- **Stars**: N/A
### Original Help Text
```text
NAME
    ViewBS - Tools for exploring and visualizing deep sequencing of
    bisulfite seuquencing (BS-seq) data.

SYNOPSIS
    ViewBS <subcmd> [options]

DESCRIPTION
    ViewBS is developped to mine and visualize bisulfite seuquencing data.

Options
    --help | -h
            Prints the help message and exits.

    --version | -v
            Prints the version information and exits.

    Subcommands:
    MethCoverage
             - Generate coverage report for BS-seq data

    BisNonConvRate
             - Generate bisulfite non-conversion rate for BS-seq data using the
               provided chromosome (usually chloroplast for plants).

    GlobalMethLev
             - Generate global (bulk) methylation level report for BS-seq data

    MethLevDist
             - Generate distribution of methylation level for different sequence context (CG, 
               CHG and CHH) for BS-seq data

    MethGeno
             - Generate the methylation information across each chromosome and plot the 
               information.

    MethOverRegion
             - Generate the methylation information across the regions provided and generate 
               meta-plot. The regions can be genes, transposable elements, etc.

    MethHeatmap
             - Generate heat map and violin-boxplot for selected regions.

    MethOneRegion
             - Visualize DNA methylation for a given regions.

HELP
            If you have bugs, feature requests, please report the issues
            here: (https://github.com/readbio/ViewBS/issues)
```

