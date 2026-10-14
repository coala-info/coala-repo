# phyloflash CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| phyloflash_phyloFlash.pl | Not completed | needs the phyloFlash SILVA/UniVec reference database (large download); the run stops with: failed to find suitable DBHOME |
| phyloflash_phyloFlash_barplot.R | PASS |  |
| phyloflash_phyloFlash_compare.pl | PASS | ran on the tool's own test NTU tables; the heatmap task needs --min-ntu-count 0 there (the default 50 stops with an R error on these tiny tables) |
| phyloflash_phyloFlash_fastgFishing.pl | Not completed | no test data: needs an assembly graph (Fastg) and contigs from a real metagenome assembly |
| phyloflash_phyloFlash_heatmap.R | Not completed | needs complete phyloFlash result sets (*.phyloFlash.report.csv from a database run); the tool's NTU tables alone give 'cannot open report.csv' |
| phyloflash_phyloFlash_makedb.pl | Not completed | downloads the full SILVA and UniVec databases (large) and indexes them; not run |

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


## phyloflash_phyloFlash_heatmap.R

### Tool Description
Generates a heatmap plot from multiple phyloFlash result sets.

### Metadata
- **Docker Image**: quay.io/biocontainers/phyloflash:3.4.2--hdfd78af_0
- **Homepage**: https://hrgv.github.io/phyloFlash/
- **Package**: https://anaconda.org/channels/bioconda/packages/phyloflash/overview
- **Validation**: PASS

### Original Help Text
```text
Loading required package: optparse
Usage: /usr/local/bin/phyloFlash_heatmap.R [options] [files]

Generates a heatmap plot from multiple phyloFlash result sets. For more control,
source this file from R.

Files:
        A list of files and/or directories that will be searched
        for phyloFlash results.

Options:
	-v, --verbose
		Be more talkative

	-q, --quiet
		Be less talkative

	-d, --debug
		Show debug messages

	-n MIN-NTU-COUNT, --min-ntu-count=MIN-NTU-COUNT
		Sum NTUs with less counts in pseudo NTU "Other". Default 50.

	--no-split
		Do not split heatmap

	-t SPLIT-REGEX, --split-regex=SPLIT-REGEX
		Split heatmap using this regex on taxa. Multiple regex can be
                specified comma separated. Default 'Eukaryota'

	-l, --long-taxnames
		Do not shorten taxa names to last two groups

	-a, --absolute
		Do not scale columns to percentages

	-m CLUSTER-SAMPLES, --cluster-samples=CLUSTER-SAMPLES
		Use this method for clustering/sorting samples. Can be:
                alpha, ward.D, single, complete, average, mcquitty, median, centroid, or custom.
                Default is ward.D.

	-M CLUSTER-TAXA, --cluster-taxa=CLUSTER-TAXA
		Use this method for clustering/sorting taxa. Can be:
               alpha, ward.D, single, complete, average, mcquitty, median or centroid.
               Default is ward.D

	-r ROWS, --rows=ROWS
		Component rows, in order, to render (separated by commas).
                Valid terms are: tree, map, chao and labels.
                Default is tree,map,chao,labels.

	-c COLS, --cols=COLS
		Component columns, in order, to render (separated by commas).
                Valid terms are: labels, map and tree.
                Default is labels,map,tree.

	--colors=COLORS
		Colors for heatmaps. Default is steelblue,indianred,green,orange.

	-o OUT, --out=OUT
		Name of output file. Must end in .png or .pdf. Default is out.png.

	--aa=AA
		Type of anti-aliasing to use for PNG output. Can be one of default,
                none, gray, or subpixel. Default is gray.

	-s OUT-SIZE, --out-size=OUT-SIZE
		Size of output graphic in pixels (e.g. 100x100). Assumes 72 DPI for
                PDF. Using "auto" for a dimension will attempt to guess at suitable
                size. Default autoXauto

	--library-name-from-file
		Use thee filename to derive library name instead of parsing ...report.csv

	--custom-distance-matrix-sample=CUSTOM-DISTANCE-MATRIX-SAMPLE
		Import custom distance matrix for samples instead of calculating
                from abundance matrix

	-h, --help
		Show this help message and exit
```

## phyloflash_phyloFlash_barplot.R

### Tool Description
Generate a barplot of NTU abundances by sample.

### Metadata
- **Docker Image**: quay.io/biocontainers/phyloflash:3.4.2--hdfd78af_0
- **Homepage**: https://hrgv.github.io/phyloFlash/
- **Package**: https://anaconda.org/channels/bioconda/packages/phyloflash/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: /usr/local/bin/phyloFlash_barplot.R [options]
Generate a barplot of NTU abundances by sample

Options:
	-t TOPTAXA, --toptaxa=TOPTAXA
		Number of taxa to display in the barplot. By default takes the top 10
                by total proportional abundance in the library

	-f FILE, --file=FILE
		CSV file containing three columns: Taxon, sample, and counts

	-o OUT, --out=OUT
		Name of output PDF or PNG file

	-p PALETTE, --palette=PALETTE
		Palette name for taxon colors. One of the qualitative palettes from the
                  ColorBrewer2 set: Accent, Dark2, Paired, Pastel1, Pastel2, Set1, Set2, or Set3.

	-s SUBSET, --subset=SUBSET
		Display only subset from this taxon (e.g. show only Bacteria). Supply
                  full taxon string prefix, excluding trailing semicolon.

	-r, --rawval
		Plot raw counts rather than proportions

	-w SCALEPLOTWIDTH, --scaleplotwidth=SCALEPLOTWIDTH
		Change the plot width by this scaling factor (e.g. 2 makes it twice
                  as wide). Allows adjustment when bars are hidden because the
                  legend labels are too long.

	-h, --help
		Show this help message and exit
```

## phyloflash_phyloFlash_makedb.pl

### Tool Description
Builds the phyloFlash reference database (SILVA SSU Ref NR99 and Univec) by downloading the files or from local copies.

### Metadata
- **Docker Image**: quay.io/biocontainers/phyloflash:3.4.2--hdfd78af_0
- **Homepage**: https://hrgv.github.io/phyloFlash/
- **Package**: https://anaconda.org/channels/bioconda/packages/phyloflash/overview
- **Validation**: PASS

### Original Help Text
```text
Usage:
    ### download databases via FTP

    phyloFlash_makedb.pl --remote

    ### use local copies

    phyloFlash_makedb.pl --silva_file path/to/silva_db --univec_file
    path/to/univec_db

    ## Get help

    phyloFlash_makedb.pl --help

    phyloFlash_makedb.pl --man

Arguments:
  Input Files:
    --remote
            Download databases via FTP

    --silva_file path/to/silva_db
            Path to local copy of SILVA database file. Ignored if --remote
            flag is used.

            This should be the Fasta-formatted SILVA SSURef file, clustered
            at 99% identity, with SILVA taxonomy strings in file header, and
            sequences truncated to SSU gene boundaries. The file name should
            be in the form
            SILVA_[Release]_SSURef_Nr99_tax_silva_trunc.fasta.gz (release
            132 and before) or
            SILVA_[Release]_SSURef_NR99_tax_silva_trunc.fasta.gz (from
            release 138 onwards)

    --univec_file path/to/univec_db
            Path to local copy of Univec database file. Ignored if --remote
            flag is used.

  Optional Tools:
    --emirge
            Index database with Bowtie v1 for Emirge. Requires bowtie-build
            to be in path.

            Default: Yes (turn off with --noemirge)

    --sortmerna
            Index database for Sortmerna, if you wish to use it as an
            alternative to BBmap for extracting rRNA reads from the read
            file. Requires indexdb_rna to be in path.

            Default: No (--nosortmerna).

  Configuration and Help:
    --keep  Do not delete intermediary files

    --overwrite
            Overwrite files if already present. Files are not overwritten by
            default, allowing you to restart the DB build process if it was
            interrupted (but you will have to do find and delete corrupted
            files manually).

            Default: No ("--nooverwrite")

    --ref_minlength
            Minimum length of database sequences to keep after trimming of
            vectors and contaminant sequences. Default of 800 bp is about
            50% for SSU rRNA gene length, but should be changed if a custom
            database is used.

            Default: 800

    --CPUs N
            Number of processors to use

            Default: All available

    --mem N Memory limit (in Gb) for indexing tools. At least 10 is
            recommended.

            Default: 10

    --log FILE
            Write phyloFlash_makedb.pl log to a file.

            Default: None

    --check_env
            Check that required dependencies are available in your path. If
            specifying optional tools --sortmerna and --emirge, put the
            --check_env argument at the end of the command.

    --help  Help message

    --man   Full manual page

    --version
            Report version
```

## phyloflash_phyloFlash_fastgFishing.pl

### Tool Description
Finds contig clusters with SSU rRNA genes in an assembly graph (Fastg) from MEGAHIT or SPAdes.

### Metadata
- **Docker Image**: quay.io/biocontainers/phyloflash:3.4.2--hdfd78af_0
- **Homepage**: https://hrgv.github.io/phyloFlash/
- **Package**: https://anaconda.org/channels/bioconda/packages/phyloflash/overview
- **Validation**: PASS

### Original Help Text
```text
Usage:
    ### Megahit assembly

    phyloFlash_fastgFishing.pl --fasta [Fasta] --fastg [Fastg] --out
    [PREFIX] --assembler megahit

    ### SPAdes assembly

    phyloFlash_fastgFishing.pl --fasta [Fasta] --fastg [Fastg] --paths
    [Paths] --out [PREFIX] --assembler spades

    ### Help

    phyloFlash_fastgFishing.pl --help

    phyloFlash_fastgFishing.pl --man

Arguments:
  Input:
    --fastg FILE
            Input Fastg file from Megahit or Spades. NB: The de facto Fastg
            format used by these programs differs from the Fastg standard,
            as described in the Bandage documentation.

    --fasta FILE
            Input Fasta file, to convert Fastg sequence identifiers to
            corresponding Fasta sequence IDs.

            If using MEGAHIT, this is the *.contigs.fa file. For SPAdes this
            is either the scaffolds or contigs file (after repeat
            resolution).

    --paths FILE
            Input Paths file, to convert EDGE to NODE identifiers, if using
            SPAdes assembler.

    --assembler STRING
            Assembler used. Either "megahit" or "spades".

            Default: 'megahit'

    --compare-ssu FILE
    --compare-zip FILE
            If a targeted assembly of SSU rRNA has already been performed
            for this library, compare the sequences to those extracted from
            the metagenome assembly by barrnap.

            The sequences can be supplied either as a Fasta flie (option
            --compare-ssu) or as a phyloFlash tar.gz archive (option
            --compare-zip).

            Default: None.

  Output Options:
    --out|-o STRING
            Output file name prefix

            Default: 'test'

    --clusteronly
            Do not search for SSU rRNA sequences, instead only report all
            connected contig clusters above length threshold, regardless of
            whether they have SSU rRNA or not

            Default: Off

    --cutoff|-c INTEGER
            Minimum total sequence length of contig cluster to be reported
            (Default: 100000)

    --min-SSU-frac NUMERIC
            Minimum fraction of SSU sequence to report (parameter passed to
            the '--reject' option in Barrnap)

            Default: 0.2

    --outfasta
            Logical: Output Fasta files for clusters with total length above
            cutoff?

            Default: No

  Usage Options:
    --CPUs INTEGER
            Number of CPUs to use for Barrnap rRNA prediction

            Default: 8

    --barnap-path PATH
            Path to barrnap executable

            Default: Use version bundled with phyloFlash

    --help|-h
            Brief help message

    --man|-m
            Manual page

    --version|-v
            Report phyloFlash version
```

## Metadata
- **Skill**: generated
