# alignoth CWL Generation Report

## alignoth

### Tool Description
A tool to create alignment plots from bam files.

### Metadata
- **Docker Image**: quay.io/biocontainers/alignoth:1.4.6--h1520f10_0
- **Homepage**: https://github.com/koesterlab/alignoth
- **Package**: https://anaconda.org/channels/bioconda/packages/alignoth/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/alignoth/overview
- **Total Downloads**: 63.2K
- **Last updated**: 2026-02-05
- **GitHub**: https://github.com/koesterlab/alignoth
- **Stars**: N/A
### Original Help Text
```text
alignoth 1.4.6
A tool to create alignment plots from bam files.

USAGE:
    alignoth [FLAGS] [OPTIONS]

FLAGS:
        --help           Prints help information
        --html           If present, the generated plot will inserted into a plain html file containing the plot
                         centered which is then written to stdout
        --no-embed-js    If present, the generated html will not embed javscript dependencies and therefore be
                         considerably smaller but require internet access to load the dependencies
        --plot-all       A short command to plot the whole bam file. We advise to only use this command for small bam
                         files
    -V, --version        Prints version information

OPTIONS:
    -a, --around <around>
            Chromosome and single base for the visualization. The plotted region will start 500bp before and end 500bp
            after the given base. Example: 2:20000
        --around-vcf-record <around-vcf-record>
            Plots a region around a specified VCF record taken via its index from the VCF file given via the --vcf
            option
    -x, --aux-tag <aux-tag>...
            Displays the given content of the aux tags in the tooltip of the plot. Multiple usage for more than one tag
            is possible
    -b, --bam-path <bam-path>                                            BAM file to be visualized
        --bed <bed>
            Path to a BED file that will be used to highlight all BED records overlapping the given region

        --coverage-output <coverage-output>
            If present coverage data will be written to the given file path

    -f, --data-format <data-format>
            Set the data format of the read, reference and highlight data [default: json]

    -h, --highlight <highlight>...
            Interval or single base position that will be highlighted in the visualization. Example: 132440-132450 or
            132440
        --highlight-data-output <highlight-data-output>
            If present highlight data will be written to the given file path

    -d, --max-read-depth <max-read-depth>
            Set the maximum rows of reads that will be shown in the alignment plots [default: 500]

    -w, --max-width <max-width>
            Sets the maximum width of the resulting plot [default: 1024]

        --mismatch-display-min-percent <mismatch-display-min-percent>
            The minimum percentage of mismatches compared to total read depth at that point to display in the coverage
            plot [default: 1.0]
    -o, --output <output>
            If present, data and vega-lite specs of the generated plot will be split and written to the given directory

        --read-data-output <read-data-output>
            If present read data will be written to the given file path

        --ref-data-output <ref-data-output>
            If present reference data will be written to the given file path

    -r, --reference <reference>                                          Path to the reference fasta file
    -g, --region <region>
            Chromosome and region (1-based, fully inclusive) for the visualization. Example: 2:132424-132924

        --spec-output <spec-output>
            If present vega-lite specs will be written to the given file path

    -v, --vcf <vcf>
            Path to a VCF file that will be used to highlight all variant position located within the given region
```

