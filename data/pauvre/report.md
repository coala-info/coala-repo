# pauvre CWL Generation Report

## pauvre_browser

### Tool Description
A tool for plotting genomic tracks and reference sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/pauvre:0.1924--py_0
- **Homepage**: https://github.com/conchoecia/gloTK
- **Package**: https://anaconda.org/channels/bioconda/packages/pauvre/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pauvre/overview
- **Total Downloads**: 41.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/conchoecia/gloTK
- **Stars**: N/A
### Original Help Text
```text
usage: pauvre browser [-h] [-q] [-c Chr] [--dpi dpi]
                      [--fileform STRING [STRING ...]] [--no_timestamp]
                      [-o BASENAME] [--path PATH] [-p CMD [CMD ...]]
                      [--ratio RATIO [RATIO ...]] [-r REF] [--start START]
                      [--stop STOP] [-T]

optional arguments:
  -h, --help            show this help message and exit
  -q, --quiet           Do not output warnings to stderr
  -c Chr, --chromosomeid Chr
                        The fasta sequence to observe. Use the header name of
                        the fasta file without the '>' character
  --dpi dpi             Change the dpi from the default 600 if you need it
                        higher
  --fileform STRING [STRING ...]
                        Which output format would you like? Def.=png
  --no_timestamp        Turn off time stamps in the filename output.
  -o BASENAME, --output-base-name BASENAME
                        Specify a base name for the output file( s). The input
                        file base name is the default.
  --path PATH           Set an explicit filepath for the output. Only do this
                        if you have selected one output type.
  -p CMD [CMD ...], --plot_commands CMD [CMD ...]
                        Write strings here to select what to plot. The format
                        for each track is: <type>:<path>:<style>:<options> To
                        plot the reference, the format is:
                        ref:<style>:<options> Surround each track string with
                        double quotes and a space between subsequent strings.
                        "bam:mybam.bam:depth" "ref:colorful"
  --ratio RATIO [RATIO ...]
                        Enter the dimensions (arbitrary units) to plot the
                        figure. For example a figure that is seven times wider
                        than tall is: --ratio 7 1
  -r REF, --reference REF
                        The reference fasta file.
  --start START         The start position to observe on the fasta file. Uses
                        1-based indexing.
  --stop STOP           The stop position to observe on the fasta file. Uses
                        1-based indexing.
  -T, --transparent     Specify this option if you DON'T want a transparent
                        background. Default is on.
```


## pauvre_custommargin

### Tool Description
Generate custom margin plots from tab-separated data files.

### Metadata
- **Docker Image**: quay.io/biocontainers/pauvre:0.1924--py_0
- **Homepage**: https://github.com/conchoecia/gloTK
- **Package**: https://anaconda.org/channels/bioconda/packages/pauvre/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pauvre custommargin [-h] [-q] [--dpi dpi]
                           [--fileform STRING [STRING ...]] [-i INPUT_FILE]
                           [--xcol XCOL] [--ycol YCOL] [-n] [--no_timestamp]
                           [-o OUTPUT_BASE_NAME] [--plot_max_y PLOT_MAX_Y]
                           [--plot_max_x PLOT_MAX_X] [--plot_min_y PLOT_MIN_Y]
                           [--plot_min_x PLOT_MIN_X] [--square] [-t TITLE]
                           [--ybin YBIN] [--xbin XBIN] [--add-yaxes]

optional arguments:
  -h, --help            show this help message and exit
  -q, --quiet           Do not output warnings to stderr
  --dpi dpi             Change the dpi from the default 600 if you need it
                        higher
  --fileform STRING [STRING ...]
                        Which output format would you like? Def.=png
  -i INPUT_FILE, --input_file INPUT_FILE
                        A tab-separated file with a header row of column
                        names.
  --xcol XCOL           The column name of the data to plot on the x-axis
  --ycol YCOL           The column name of the data to plot on the y-axis
  -n, --no_transparent  Specify this option if you don't want a transparent
                        background. Default is on.
  --no_timestamp        Turn off time stamps in the filename output.
  -o OUTPUT_BASE_NAME, --output_base_name OUTPUT_BASE_NAME
                        Specify a base name for the output file(s). The input
                        file base name is the default.
  --plot_max_y PLOT_MAX_Y
                        Sets the maximum viewing area in the length dimension.
  --plot_max_x PLOT_MAX_X
                        Sets the maximum viewing area in the quality
                        dimension.
  --plot_min_y PLOT_MIN_Y
                        Sets the minimum viewing area in the length dimension.
                        Default value = 0
  --plot_min_x PLOT_MIN_X
                        Sets the minimum viewing area in the quality
                        dimension. Default value = 0
  --square              changes the hexmap into a square map quantized by
                        ints.
  -t TITLE, --title TITLE
                        This sets the title for the whole plot. Use --title
                        "Crustacean's DNA read quality" if you need single
                        quote or apostrophe inside title.
  --ybin YBIN           This sets the bin size to use for length.
  --xbin XBIN           This sets the bin size to use for quality
  --add-yaxes           Add Y-axes to both marginal histograms.
```


## pauvre_marginplot

### Tool Description
Generate a margin plot of read length versus quality from FASTQ files.

### Metadata
- **Docker Image**: quay.io/biocontainers/pauvre:0.1924--py_0
- **Homepage**: https://github.com/conchoecia/gloTK
- **Package**: https://anaconda.org/channels/bioconda/packages/pauvre/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pauvre marginplot [-h] [-q] [--dpi dpi] [-f FASTQ]
                         [--fileform STRING [STRING ...]]
                         [--filt_maxlen FILT_MAXLEN]
                         [--filt_maxqual FILT_MAXQUAL]
                         [--filt_minlen FILT_MINLEN]
                         [--filt_minqual FILT_MINQUAL] [--kmerdf KMERDF] [-n]
                         [--no_timestamp] [-o BASENAME]
                         [--plot_maxlen PLOT_MAXLEN]
                         [--plot_maxqual PLOT_MAXQUAL]
                         [--plot_minlen PLOT_MINLEN]
                         [--plot_minqual PLOT_MINQUAL] [--lengthbin LENGTHBIN]
                         [--qualbin QUALBIN] [-t TITLE] [-y]

optional arguments:
  -h, --help            show this help message and exit
  -q, --quiet           Do not output warnings to stderr
  --dpi dpi             Change the dpi from the default 600 if you need it
                        higher
  -f FASTQ, --fastq FASTQ
                        The input FASTQ file.
  --fileform STRING [STRING ...]
                        Which output format would you like? Def.=png
  --filt_maxlen FILT_MAXLEN
                        This sets the max read length filter reads.
  --filt_maxqual FILT_MAXQUAL
                        This sets the max mean read quality to filter reads.
  --filt_minlen FILT_MINLEN
                        This sets the min read length to filter reads.
  --filt_minqual FILT_MINQUAL
                        This sets the min mean read quality to filter reads.
  --kmerdf KMERDF       Pass the filename of a data matrix if you would like
                        to plot read length versus number of kmers in that
                        read. The data matrix is a tab-separated text file
                        with columns "id length numks and kmers", where: <id>
                        = read id <length> = the length of the read <numks> =
                        the number of canonical kmers in the read <kmers> = a
                        list representation of kmers ie ['GAT', 'GTA']
  -n, --no_transparent  Specify this option if you don't want a transparent
                        background. Default is on.
  --no_timestamp        Turn off time stamps in the filename output.
  -o BASENAME, --output_base_name BASENAME
                        Specify a base name for the output file(s). The input
                        file base name is the default.
  --plot_maxlen PLOT_MAXLEN
                        Sets the maximum viewing area in the length dimension.
  --plot_maxqual PLOT_MAXQUAL
                        Sets the maximum viewing area in the quality
                        dimension.
  --plot_minlen PLOT_MINLEN
                        Sets the minimum viewing area in the length dimension.
  --plot_minqual PLOT_MINQUAL
                        Sets the minimum viewing area in the quality
                        dimension.
  --lengthbin LENGTHBIN
                        This sets the bin size to use for length.
  --qualbin QUALBIN     This sets the bin size to use for quality
  -t TITLE, --title TITLE
                        This sets the title for the whole plot. Use --title
                        "Crustacean's DNA read quality" if you need single
                        quote or apostrophe inside title.
  -y, --add-yaxes       Add Y-axes to both marginal histograms.
```


## pauvre_redwood

### Tool Description
Plot long reads and RNA-seq data in a circular 'redwood' plot, often used for mitochondrial genomes.

### Metadata
- **Docker Image**: quay.io/biocontainers/pauvre:0.1924--py_0
- **Homepage**: https://github.com/conchoecia/gloTK
- **Package**: https://anaconda.org/channels/bioconda/packages/pauvre/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pauvre redwood [-h] [-q] [-d {main,rnaseq} [{main,rnaseq} ...]]
                      [--dpi dpi] [--fileform STRING [STRING ...]] [--gff gff]
                      [-I] [-i] [-L] [-M mainbam] [--no_timestamp]
                      [-o BASENAME] [--query QUERY [QUERY ...]] [-R rnabam]
                      [--small_start {inside,outside}]
                      [--sort {ALNLEN,TRULEN,MAPLEN,POS}]
                      [--ticks TICKS [TICKS ...]] [-T]

optional arguments:
  -h, --help            show this help message and exit
  -q, --quiet           Do not output warnings to stderr
  -d {main,rnaseq} [{main,rnaseq} ...], --doubled {main,rnaseq} [{main,rnaseq} ...]
                        If your fasta file was doubled to map circularly, use
                        this flag or you may encounter plotting errors.
                        Accepts multiple arguments. 'main' is for the sam file
                        passed with --sam, 'rnaseq' is for the sam file passed
                        with --rnaseq
  --dpi dpi             Change the dpi from the default 600 if you need it
                        higher
  --fileform STRING [STRING ...]
                        Which output format would you like? Def.=png
  --gff gff             The input filepath for the gff annotation to plot
  -I, --interlace       Interlace the reads so the pileup plot looks better.
                        Doesn't work currently
  -i, --invert          invert the image so that it looks better on a dark
                        background. DOESN'T DO ANYTHING.
  -L, --log             Plot the RNAseq track with a log scale
  -M mainbam, --main_bam mainbam
                        The input filepath for the bam file to plot. Ideally
                        was plotted with a fasta file that is two copies of
                        the mitochondrial genome concatenated. This should be
                        long reads (ONT, PB) and will be displayed in the
                        interior of the redwood plot.
  --no_timestamp        Turn off time stamps in the filename output.
  -o BASENAME, --output-base-name BASENAME
                        Specify a base name for the output file(s). The input
                        file base name is the default.
  --query QUERY [QUERY ...]
                        Query your reads to change plotting options
  -R rnabam, --rnaseq_bam rnabam
                        The input filepath for the rnaseq bam file to plot
  --small_start {inside,outside}
                        This determines where the shortest of the filtered
                        reads will appear on the redwood plot: on the outside
                        or on the inside? The default option puts the longest
                        reads on the outside and the shortest reads on the
                        inside.
  --sort {ALNLEN,TRULEN,MAPLEN,POS}
                        What value to use to sort the order in which the reads
                        are plotted?
  --ticks TICKS [TICKS ...]
                        Specify control for the number of ticks.
  -T, --transparent     Specify this option if you DON'T want a transparent
                        background. Default is on.
```


## pauvre_stats

### Tool Description
Generate statistics and optionally a histogram from FASTQ files.

### Metadata
- **Docker Image**: quay.io/biocontainers/pauvre:0.1924--py_0
- **Homepage**: https://github.com/conchoecia/gloTK
- **Package**: https://anaconda.org/channels/bioconda/packages/pauvre/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pauvre stats [-h] [-q] [-f FASTQ] [-H] [--filt_maxlen FILT_MAXLEN]
                    [--filt_maxqual FILT_MAXQUAL] [--filt_minlen FILT_MINLEN]
                    [--filt_minqual FILT_MINQUAL]

optional arguments:
  -h, --help            show this help message and exit
  -q, --quiet           Do not output warnings to stderr
  -f FASTQ, --fastq FASTQ
                        The input FASTQ file.
  -H, --histogram       Make a histogram of the read lengths and saves it to a
                        new file
  --filt_maxlen FILT_MAXLEN
                        This sets the max read length filter reads.
  --filt_maxqual FILT_MAXQUAL
                        This sets the max mean read quality to filter reads.
  --filt_minlen FILT_MINLEN
                        This sets the min read length to filter reads.
  --filt_minqual FILT_MINQUAL
                        This sets the min mean read quality to filter reads.
```


## pauvre_synplot

### Tool Description
Generate synteny plots from GFF annotations and alignments.

### Metadata
- **Docker Image**: quay.io/biocontainers/pauvre:0.1924--py_0
- **Homepage**: https://github.com/conchoecia/gloTK
- **Package**: https://anaconda.org/channels/bioconda/packages/pauvre/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pauvre synplot [-h] [-q] [--aln_dir aln_dir] [--center_on CENTER_ON]
                      [--dpi dpi]
                      [--fileform {png,pdf,eps,jpeg,jpg,pdf,pgf,ps,raw,rgba,svg,svgz,tif,tiff} [{png,pdf,eps,jpeg,jpg,pdf,pgf,ps,raw,rgba,svg,svgz,tif,tiff} ...]]
                      [--gff_paths gff_paths [gff_paths ...]]
                      [--gff_labels gff_labels [gff_labels ...]]
                      [--no_timestamp] [--optimum_order] [-o BASENAME]
                      [--ratio RATIO [RATIO ...]] [--sandwich]
                      [--start_with_aligned_genes] [--stop_codons] [-T]

optional arguments:
  -h, --help            show this help message and exit
  -q, --quiet           Do not output warnings to stderr
  --aln_dir aln_dir     The directory where all the fasta alignments are
                        contained.
  --center_on CENTER_ON
                        Centers the plot around the gene that you pass as an
                        argument. For example, if there is a locus called
                        'COI' in the gff file and in the alignments directory,
                        center using: --center_on COI
  --dpi dpi             Change the dpi from the default 600 if you need it
                        higher
  --fileform {png,pdf,eps,jpeg,jpg,pdf,pgf,ps,raw,rgba,svg,svgz,tif,tiff} [{png,pdf,eps,jpeg,jpg,pdf,pgf,ps,raw,rgba,svg,svgz,tif,tiff} ...]
                        Which output format would you like? Def.=png
  --gff_paths gff_paths [gff_paths ...]
                        The input filepath. for the gff annotation to plot.
                        Individual filepaths separated by spaces. For example,
                        --gff_paths sp1.gff sp2.gff sp3.gff
  --gff_labels gff_labels [gff_labels ...]
                        In case the gff names and sequence names don't match,
                        change the labels that will appear over the text.
  --no_timestamp        Turn off time stamps in the filename output.
  --optimum_order       If selected, this doesn't plot the optimum arrangement
                        of things as they are input into gff_paths. Instead,
                        it uses the first gff file as the top-most sequence in
                        the plot, and reorganizes the remaining gff files to
                        minimize the number of intersections.
  -o BASENAME, --output-basename BASENAME
                        Specify a base name for the output file(s). The input
                        file base name is the default.
  --ratio RATIO [RATIO ...]
                        Enter the dimensions (arbitrary units) to plot the
                        figure. For example a figure that is seven times wider
                        than tall is: --ratio 7 1
  --sandwich            Put an additional copy of the first gff file on the
                        bottom of the plot for comparison.
  --start_with_aligned_genes
                        Minimizes the number of intersections but only selects
                        combos where the first gene in each sequence is
                        aligned.
  --stop_codons         Performs some internal corrections if the gff
                        annotation includes the stop codons in the coding
                        sequences.
  -T, --transparent     Specify this option if you DON'T want a transparent
                        background. Default is on.
```


## Metadata
- **Skill**: not generated
