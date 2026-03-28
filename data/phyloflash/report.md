# phyloflash CWL Generation Report

## phyloflash_phyloFlash.pl

### Tool Description
Runs the phyloFlash pipeline to assemble and annotate eukaryotic viral genomes from sequencing data.

### Metadata
- **Docker Image**: quay.io/biocontainers/phyloflash:3.4.2--hdfd78af_0
- **Homepage**: https://github.com/HRGV/phyloFlash
- **Package**: https://anaconda.org/channels/bioconda/packages/phyloflash/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/phyloflash/overview
- **Total Downloads**: 35.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/HRGV/phyloFlash
- **Stars**: N/A
### Original Help Text
```text
Usage:
    phyloFlash.pl [OPTIONS] -lib name -read1 <file> -read2 <file>

    phyloFlash.pl -help

    phyloFlash.pl -man

    phyloFlash.pl -check_env
```


## phyloflash_phyloFlash_compare.pl

### Tool Description
Compare phyloFlash runs.

### Metadata
- **Docker Image**: quay.io/biocontainers/phyloflash:3.4.2--hdfd78af_0
- **Homepage**: https://github.com/HRGV/phyloFlash
- **Package**: https://anaconda.org/channels/bioconda/packages/phyloflash/overview
- **Validation**: PASS

### Original Help Text
```text
Usage:
    # NTU abundance table CSV files as input

    phyloFlash_compare.pl --csv
    LIB1.phyloFlash.NTUabundance.csv,LIB2.phyloFlash.NTUabundance.csv -task
    barplot

    phyloFlash_compare.pl --csv
    LIB1.phyloFlash.NTUabundance.csv,LIB2.phyloFlash.NTUabundance.csv -task
    heatmap

    # phyloFlash tar.gz archives as input

    phyloFlash_compare.pl --zip
    LIB1.phyloFlash.tar.gz,LIB2.phyloFlash.tar.gz -task barplot

    phyloFlash_compare.pl --zip
    LIB1.phyloFlash.tar.gz,LIB2.phyloFlash.tar.gz -task heatmap

    # Help/manual pages

    phyloFlash_compare.pl --help

    phyloFlash_compare.pl --man

Arguments:
  Input Files:
    Specify the output files from phyloFlash runs for the libraries that you
    wish to compare.

    The options -csv and -zip are mutually exclusive. If phyloFlash is run
    with the -zip option, the archives containing the results of each
    separate run can be specified with the -zip option below. If the results
    are not compressed, you can specify the NTU classification tables in CSV
    format.

    --csv FILES
            Comma-separated list of NTU abundance tables from phyloFlash
            runs. The files should be named
            [LIBNAME].phyloFlash.NTUabundance.csv or
            [LIBNAME].phyloFlash.NTUfull_abundance.csv

    --zip FILES
            Comma-separated list of tar.gz archives from phyloFlash runs.
            These will be parsed to search for the
            [LIBNAME].phyloFlash.NTUabundance.csv files within the archive,
            to extract the NTU classifications. This assumes that the
            archive filenames are named [LIBNAME].phyloFlash.tar.gz, and
            that the LIBNAME matches the contents of the archive.

    --allzip
            Use all phyloFlash tar.gz archives in the current folder (by
            matching filename *.phyloFlash.tar.gz) for a comparison run.
            Overrides anything passed to option --zip.

    --use_SAM
            Ignore NTU abundance tables in CSV format, and recalculate the
            NTU abundances from SAM files in the compressed tar.gz
            phyloFlash archives. Useful if e.g. phyloFlash was originally
            called to summarize the taxonomy at a higher level than you want
            to use for the comparison.

            Only works if the tar.gz archives from phyloFlash runs are
            specified with the --zip option above.

            Default: No.

  Analysis Options:
    --task STRING
            Type of analysis to be run. Options: "heatmap", "barplot",
            "matrix", "ntu_table" or a recognizable substring thereof.
            Supply more than one option as comma- separated list.

            Default: None

    --out STRING
            Prefix for output files.

            Default: "test.phyloFlash_compare"

    --outfmt STRING
            Format for plots (tasks 'barplot' and 'heatmap' only). Options:
            "pdf", "png"

            Default: "pdf"

    --level INTEGER
            Taxonomic level to perform the comparison. Must be an integer
            between 1 and 7.

            Default: 4 ('Order')

    --keeptmp
            Keep temporary files

            Default: No

    --log   Save log file to file [OUTPREFIX].log

            Default: No

  Arguments for Barplot:
    The R script phyloFlash_barplot.R can be run directly; run the script
    without arguments to see the built-in help message. However, the input
    file to the barplot script is produced by phyloFlash_compare.pl (i.e.
    this script).

    --displaytaxa INTEGER
            Number of top taxa to display in barplot. Integer between 3 and
            12 is preferable.

            Default: 5

    --barplot_palette STRING
            Palette to color taxa in barplot. Should be one of the
            qualitative ColorBrewer2 palettes: Accent, Dark2, Paired,
            Pastel1, Pastel2, Set1, Set2, or Set3.

            Default: "Set3"

    --barplot_subset STRING
            Display only the subset from this taxon, e.g. "Bacteria". Should
            be a taxon string excluding trailing semicolon, e.g.
            "Bacteria;Proteobacteria".

            Default: None (show all)

    --barplot_rawval
            Logical: Display counts rather than proportions in barplot, i.e.
            bars will not be rescaled to 100% for each sample.

            Default: False

    --barplot_scaleplotwidth
            Numeric: Change plot width by this scaling factor (e.g. 2 makes
            it twice as wide). Allows adjustment when bars are hidden
            because the legend labels are too long.

            Default: 1

  Arguments for Heatmap:
    More options are available by using the R script phyloFlash_heatmap.R
    directly, or by sourcing it in the R environment. Run the R script
    without arguments to see the built-in help message.

    --cluster-samples STRING
            Clustering method to use for clustering/sorting samples in
            heatmap. Options: "alpha", "ward.D", "single", "complete",
            "average", "mcquitty", "median", "centroid", or "custom".

            "custom" will use the Unifrac-like abundance weighted taxonomic
            distances (the distance matrix can be separately output with
            --task matrix). This is an experimental (unpublished) metric
            similar to Unifrac, but using a taxonomy tree instead of a real
            phylogeny.

            Default: "ward.D"

    --cluster-taxa STRING
            Clustering method to use for clustering/sorting taxa. Options:
            "alpha", "ward", "single", "complete", "average", "mcquitty",
            "median", "centroid".

            Default: "ward.D"

    --long-taxnames
            Do not shorten taxa names to two last groups

    --min-ntu-count INTEGER
            Sum up NTUs with fewer counts into a pseudo-NTU "Other".

            Default: 50
```


## Metadata
- **Skill**: generated
