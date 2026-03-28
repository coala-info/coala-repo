# methylartist CWL Generation Report

## methylartist_db-nanopolish

### Tool Description
Process nanopolish methylation output into a database

### Metadata
- **Docker Image**: quay.io/biocontainers/methylartist:1.5.3--pyhdfd78af_0
- **Homepage**: https://github.com/adamewing/methylartist
- **Package**: https://anaconda.org/channels/bioconda/packages/methylartist/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/methylartist/overview
- **Total Downloads**: 22.2K
- **Last updated**: 2025-11-21
- **GitHub**: https://github.com/adamewing/methylartist
- **Stars**: N/A
### Original Help Text
```text
usage: methylartist db-nanopolish [-h] -m METHDATA [-d DB] [-t THRESH] [-a]
                                  [-s] [-n MODNAME] [--motif MOTIF]

options:
  -h, --help            show this help message and exit
  -m, --methdata METHDATA
                        whole genome nanopolish methylation output, can be
                        comma-delimited
  -d, --db DB           database name (default: auto-infer)
  -t, --thresh THRESH   llr threshold (default = 2.5; if using --scalegroup
                        the suggested setting is 2.0)
  -a, --append          append to database
  -s, --scalegroup      scale threshold by number of CpGs in a group
  -n, --modname MODNAME
                        modification type (tag if combining multiple mods,
                        default = "CpG")
  --motif MOTIF         mod motif (default = CG)
```


## methylartist_db-megalodon

### Tool Description
Process megalodon per_read_text methylation output into a database

### Metadata
- **Docker Image**: quay.io/biocontainers/methylartist:1.5.3--pyhdfd78af_0
- **Homepage**: https://github.com/adamewing/methylartist
- **Package**: https://anaconda.org/channels/bioconda/packages/methylartist/overview
- **Validation**: PASS

### Original Help Text
```text
usage: methylartist db-megalodon [-h] -m METHDATA [-d DB] [-p MINPROB] [-a]
                                 [--motifsize MOTIFSIZE]

options:
  -h, --help            show this help message and exit
  -m, --methdata METHDATA
                        megalodon per_read_text methylation output
  -d, --db DB           database name (default: auto-infer)
  -p, --minprob MINPROB
                        probability threshold for calling modified or
                        unmodified base (default = 0.8)
  -a, --append          append to database
  --motifsize MOTIFSIZE
                        mod motif size (default is 2 as "CG" is most common
                        use case, e.g. set to 1 for 6mA)
```


## methylartist_db-custom

### Tool Description
Create or update a methylartist database from a custom per-read methylation output table.

### Metadata
- **Docker Image**: quay.io/biocontainers/methylartist:1.5.3--pyhdfd78af_0
- **Homepage**: https://github.com/adamewing/methylartist
- **Package**: https://anaconda.org/channels/bioconda/packages/methylartist/overview
- **Validation**: PASS

### Original Help Text
```text
usage: methylartist db-custom [-h] -m METHDATA [--header]
                              [--delimiter DELIMITER] --readname READNAME
                              --chrom CHROM --pos POS --strand STRAND
                              --modprob MODPROB [--canprob CANPROB]
                              [--modbasecol MODBASECOL] [--modbase MODBASE]
                              [-d DB] [--minmodprob MINMODPROB]
                              [--mincanprob MINCANPROB] [-a]
                              [--motifsize MOTIFSIZE]

options:
  -h, --help            show this help message and exit
  -m, --methdata METHDATA
                        per-read methylation output table
  --header              input table has header
  --delimiter DELIMITER
                        column delimimter char (default = whitespace (i.e. tab
                        or space)
  --readname READNAME   readname column number
  --chrom CHROM         chromosome column number
  --pos POS             genomic (i.e. on chromosome/contig) position column
                        number, 0-based
  --strand STRAND       strand column number
  --modprob MODPROB     column number for probability of modified base
  --canprob CANPROB     column number for probability of canonical base (if
                        not given, assume p=1-modprob)
  --modbasecol MODBASECOL
                        column number for modified base/motif name (optional,
                        can use --modbase instead)
  --modbase MODBASE     specify modified base/motif name (overrides
                        --modbasecol)
  -d, --db DB           database name (default: auto-infer)
  --minmodprob MINMODPROB
                        probability threshold for calling modified base
                        (default = 0.8)
  --mincanprob MINCANPROB
                        probability threshold for calling canonical base
                        (default = minmodprob)
  -a, --append          append to database
  --motifsize MOTIFSIZE
                        mod motif size (default is 2 as "CG" is most common
                        use case, e.g. set to 1 for 6mA)
```


## methylartist_db-guppy

### Tool Description
Process Guppy-called fast5 files to generate a methylation database

### Metadata
- **Docker Image**: quay.io/biocontainers/methylartist:1.5.3--pyhdfd78af_0
- **Homepage**: https://github.com/adamewing/methylartist
- **Package**: https://anaconda.org/channels/bioconda/packages/methylartist/overview
- **Validation**: PASS

### Original Help Text
```text
usage: methylartist db-guppy [-h] -s SAMPLENAME -f FAST5 [-p PROCS] -m MOTIF
                             -n MODNAME -b BAM -r REF [--minprob MINPROB] [-a]
                             [--include_unmatched] [--motifsize MOTIFSIZE]
                             [--force]

options:
  -h, --help            show this help message and exit
  -s, --samplename SAMPLENAME
                        name for sample
  -f, --fast5 FAST5     fast5 with called bases
  -p, --procs PROCS     multiprocessing
  -m, --motif MOTIF     motif e.g. G[A]TC or [C]G
  -n, --modname MODNAME
                        mod name in guppy fast5 modified base alphabet (5mC,
                        6mA, etc)
  -b, --bam BAM         .bam file containing alignments of reads from fast5
  -r, --ref REF         reference genome fasta (samtools faidx indexed)
  --minprob MINPROB     probability threshold for calling modified or
                        unmodified base (default = 0.8)
  -a, --append          append to database
  --include_unmatched   include sites where read base does not match genome
                        base
  --motifsize MOTIFSIZE
                        mod motif size (default is 2 as "CG" is most common
                        use case, e.g. set to 1 for 6mA)
  --force
```


## methylartist_db-sub

### Tool Description
Methylartist database submission/subcommand tool

### Metadata
- **Docker Image**: quay.io/biocontainers/methylartist:1.5.3--pyhdfd78af_0
- **Homepage**: https://github.com/adamewing/methylartist
- **Package**: https://anaconda.org/channels/bioconda/packages/methylartist/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/lib/python3.13/site-packages/ont_fast5_api/compression_settings.py:1: UserWarning: pkg_resources is deprecated as an API. See https://setuptools.pypa.io/en/latest/pkg_resources.html. The pkg_resources package is slated for removal as early as 2025-11-30. Refrain from using this package or pin to Setuptools<81.
  import pkg_resources
2026-02-24 16:09:29,493 starting methylartist with command: /usr/local/bin/methylartist db-sub
usage: methylartist db-sub [-h] -b BAM -d DB [--append]
methylartist db-sub: error: the following arguments are required: -b/--bam, -d/--db
```


## methylartist_segmeth

### Tool Description
Segmented methylation analysis tool for calculating methylation levels over specific intervals.

### Metadata
- **Docker Image**: quay.io/biocontainers/methylartist:1.5.3--pyhdfd78af_0
- **Homepage**: https://github.com/adamewing/methylartist
- **Package**: https://anaconda.org/channels/bioconda/packages/methylartist/overview
- **Validation**: PASS

### Original Help Text
```text
usage: methylartist segmeth [-h] [-d DATA] [-b BAMS] -i INTERVALS [-p PROCS]
                            [-q MIN_MAPQ] [-o OUTFILE] [-m MODS] [--bedmethyl]
                            [--meth_thresh METH_THRESH]
                            [--can_thresh CAN_THRESH] [--ctbam CTBAM]
                            [--ref REF] [--motif MOTIF]
                            [--max_read_density MAX_READ_DENSITY]
                            [--excl_ambig] [--spanning_only] [--primary_only]
                            [--lowmeth_thresh LOWMETH_THRESH]
                            [--highmeth_thresh HIGHMETH_THRESH]
                            [--dmr_minreads DMR_MINREADS]
                            [--dmr_minratio DMR_MINRATIO]
                            [--dmr_maxoverlap DMR_MAXOVERLAP]
                            [--dmr_mindiff DMR_MINDIFF]
                            [--dmr_minmotifs DMR_MINMOTIFS] [--phased]
                            [--predict_dmr]

options:
  -h, --help            show this help message and exit
  -d, --data DATA       text file with .bam filename and corresponding
                        methylation database per line(whitespace-delimited)
  -b, --bams BAMS       one or more .bams (or bedMethyl input) with Mm and Ml
                        tags for modification calls (see samtags spec)
  -i, --intervals INTERVALS
                        .bed file
  -p, --procs PROCS     multiprocessing
  -q, --min_mapq MIN_MAPQ
                        minimum mapping quality (mapq), default = 10
  -o, --outfile OUTFILE
                        output file name (default: generated from input)
  -m, --mods MODS       mods, comma-delimited for >1 (default to all available
                        mods)
  --bedmethyl           input is (tabix-indexed) bedMethyl
  --meth_thresh METH_THRESH
                        modified base threshold (default=0.8)
  --can_thresh CAN_THRESH
                        canonical base threshold (default=0.8)
  --ctbam CTBAM         specify which .bam(s) are C/T substitution data (can
                        be comma-delimited)
  --ref REF             reference genome .fa (build .fai index with samtools
                        faidx) (required for mod bams)
  --motif MOTIF         expected modification motif (e.g. CG for 5mCpG
                        required for mod bams)
  --max_read_density MAX_READ_DENSITY
                        filter reads with call density greater >= value, can
                        be helpful in footprinting assays (default=None)
  --excl_ambig          do not consider reads that align entirely within
                        segment
  --spanning_only       only consider reads that span segment
  --primary_only        ignore non-primary alignments
  --lowmeth_thresh LOWMETH_THRESH
                        threshold for low-methylated read count column
                        (default = 0.05)
  --highmeth_thresh HIGHMETH_THRESH
                        threshold for high-methylated read count column
                        (default = 0.95)
  --dmr_minreads DMR_MINREADS
                        minimum reads per group for DMR prediction (default=8)
  --dmr_minratio DMR_MINRATIO
                        minimum reads ratio for DMR prediction (default=0.3)
  --dmr_maxoverlap DMR_MAXOVERLAP
                        max overlap between distributions (default = 0.0)
  --dmr_mindiff DMR_MINDIFF
                        minimum difference between means (default = 0.4)
  --dmr_minmotifs DMR_MINMOTIFS
                        minimum motif count for DMR prediction (default = 20)
  --phased              currently only considers two phases (diploid)
  --predict_dmr         enable DMR prediction in unphased data
```


## methylartist_segplot

### Tool Description
Generate segmentation plots from methylartist segmeth output

### Metadata
- **Docker Image**: quay.io/biocontainers/methylartist:1.5.3--pyhdfd78af_0
- **Homepage**: https://github.com/adamewing/methylartist
- **Package**: https://anaconda.org/channels/bioconda/packages/methylartist/overview
- **Validation**: PASS

### Original Help Text
```text
usage: methylartist segplot [-h] -s SEGMETH [-m SAMPLES] [-d MODS]
                            [-c CATEGORIES] [-v] [-g] [-n MINCALLS]
                            [-r MINREADS] [-q MIN_MAPQ] [-a] [-o OUTFILE]
                            [--metadata METADATA] [--usemeta USEMETA]
                            [--width WIDTH] [--height HEIGHT]
                            [--pointsize POINTSIZE] [--min MIN] [--max MAX]
                            [--ylabel YLABEL] [--tiltlabel] [--vertlabel]
                            [--palette PALETTE] [--ridge_alpha RIDGE_ALPHA]
                            [--ridge_spacing RIDGE_SPACING]
                            [--ridge_smoothing RIDGE_SMOOTHING] [--svg]

options:
  -h, --help            show this help message and exit
  -s, --segmeth SEGMETH
                        output from segmeth.py
  -m, --samples SAMPLES
                        samples, comma delimited
  -d, --mods MODS       mods, comma delimited
  -c, --categories CATEGORIES
                        categories, comma delimited, need to match seg_name
                        column from input
  -v, --violin
  -g, --ridge
  -n, --mincalls MINCALLS
                        minimum number of calls to include site (methylated +
                        unmethylated) (default=10)
  -r, --minreads MINREADS
                        minimum reads in interval (default = 1)
  -q, --min_mapq MIN_MAPQ
                        minimum mapping quality (mapq), default = 10
  -a, --group_by_annotation
                        group plots by annotation rather than by sample
  -o, --outfile OUTFILE
                        output file name (default: generated from input)
  --metadata METADATA   sample metadata (tab-delimited with header, sample
                        name as first column)
  --usemeta USEMETA     metadata to append to annotation (comma-delimited)
  --width WIDTH         figure width (default = automatic)
  --height HEIGHT       figure height (default = 6)
  --pointsize POINTSIZE
                        point size for scatterplot (default = 1)
  --min MIN             min (default = -0.15)
  --max MAX             max (default = 1.15)
  --ylabel YLABEL       set label for y-axis (default: pct methylation)
  --tiltlabel
  --vertlabel
  --palette PALETTE     palette (default = "tab10"), see https://seaborn.pydat
                        a.org/tutorial/color_palettes.html
  --ridge_alpha RIDGE_ALPHA
                        alpha (tranparency) for ridge plot fills (default =
                        1.0)
  --ridge_spacing RIDGE_SPACING
                        ridge plot spacing (generally negative, default =
                        -0.25)
  --ridge_smoothing RIDGE_SMOOTHING
                        smoothing parameter for ridge plot, bigger is smoother
                        (default=0.5)
  --svg
```


## methylartist_locus

### Tool Description
Plot methylation data for a specific genomic locus, including alignments, smoothed methylation profiles, and gene annotations.

### Metadata
- **Docker Image**: quay.io/biocontainers/methylartist:1.5.3--pyhdfd78af_0
- **Homepage**: https://github.com/adamewing/methylartist
- **Package**: https://anaconda.org/channels/bioconda/packages/methylartist/overview
- **Validation**: PASS

### Original Help Text
```text
usage: methylartist locus [-h] [-d DATA] [-b BAMS] -i INTERVAL [-g GTF]
                          [-C CSI] [-l HIGHLIGHT] [-m MODS]
                          [-s SMOOTHWINDOWSIZE] [-t SLIDINGWINDOWSTEP]
                          [-p PANELRATIOS] [-q MIN_MAPQ] [-r REF] [-n MOTIF]
                          [-c PLOT_COVERAGE] [-o OUTFILE] [--samplebox]
                          [--skip_align_plot] [--skip_raw_plot]
                          [--meth_thresh METH_THRESH]
                          [--can_thresh CAN_THRESH] [--ctbam CTBAM]
                          [--logcover] [--coverprocs COVERPROCS] [--bed BED]
                          [--hidebedlabel] [--highlight_bed HIGHLIGHT_BED]
                          [--highlight_subplot] [--variants VARIANTS]
                          [--splitvar SPLITVAR]
                          [--variantpalette VARIANTPALETTE]
                          [--variantsize VARIANTSIZE] [--motifsize MOTIFSIZE]
                          [--allreads] [--phased] [--phasediff] [--ignore_ps]
                          [--color_by_hp] [--color_by_phase]
                          [--colormap COLORMAP] [--phase_labels PHASE_LABELS]
                          [--include_unphased] [--readmask READMASK]
                          [--readmarker READMARKER]
                          [--markeralpha MARKERALPHA]
                          [--readmarkersize READMARKERSIZE]
                          [--readlinewidth READLINEWIDTH]
                          [--readlinealpha READLINEALPHA]
                          [--readopenmarkeredgecolor READOPENMARKEREDGECOLOR]
                          [--slidingwindowsize SLIDINGWINDOWSIZE]
                          [--smoothfunc SMOOTHFUNC]
                          [--smoothalpha SMOOTHALPHA]
                          [--smoothlinewidth SMOOTHLINEWIDTH] [--shuffle]
                          [--smoothed_csv SMOOTHED_CSV]
                          [--maskcutoff MASKCUTOFF]
                          [--maxmaskedfrac MAXMASKEDFRAC] [--nomask]
                          [--mincalls MINCALLS]
                          [--max_read_density MAX_READ_DENSITY]
                          [--modspace MODSPACE] [--genes GENES] [--labelgenes]
                          [--hidelegend] [--exonheight EXONHEIGHT]
                          [--show_transcripts] [--ymin YMIN] [--ymax YMAX]
                          [--cover_ymin COVER_YMIN] [--nticks NTICKS]
                          [--statname STATNAME]
                          [--samplepalette SAMPLEPALETTE]
                          [--coverpalette COVERPALETTE]
                          [--highlightpalette HIGHLIGHTPALETTE]
                          [--genepalette GENEPALETTE]
                          [--highlight_alpha HIGHLIGHT_ALPHA] [--excl_ambig]
                          [--primary_only] [--unambig_highlight]
                          [--width WIDTH] [--height HEIGHT] [--notext] [--svg]

options:
  -h, --help            show this help message and exit
  -d, --data DATA       text file with .bam filename and corresponding
                        methylation database per line (whitespace-delimited)
  -b, --bams BAMS       one or more .bams with MM and ML tags for modification
                        calls (see samtags spec)
  -i, --interval INTERVAL
                        chrom:start-end
  -g, --gtf GTF         genes or intervals to display in gtf format
  -C, --csi CSI         csi index for the gtf, optional
  -l, --highlight HIGHLIGHT
                        format: start-end, (can be chrom:start-end but chrom
                        is ignored) can comma-delimit multiple highlights
  -m, --mods MODS       mods, comma-delimited for >1 (default to all available
                        mods)
  -s, --smoothwindowsize SMOOTHWINDOWSIZE
                        size of window for smoothing (default=auto)
  -t, --slidingwindowstep SLIDINGWINDOWSTEP
                        step size for initial sliding window (default=1)
  -p, --panelratios PANELRATIOS
                        Alter panel ratios: needs to be 5 comma-seperated
                        integers. Default: 1,5,1,3,3
  -q, --min_mapq MIN_MAPQ
                        minimum mapping quality (mapq), default = 10
  -r, --ref REF         reference genome .fa (build .fai index with samtools
                        faidx) (required for mod bams)
  -n, --motif MOTIF     expected modification motif (e.g. CG for 5mCpG
                        required for mod bams)
  -c, --plot_coverage PLOT_COVERAGE
                        plot coverage from bam(s) (can be comma-delimited
                        list)
  -o, --outfile OUTFILE
                        output file name (default: generated from input)
  --samplebox           draw sample box with labels next to alignments
  --skip_align_plot     do not plot alignments
  --skip_raw_plot       do not plot raw signal
  --meth_thresh METH_THRESH
                        modified base threshold (default=0.8)
  --can_thresh CAN_THRESH
                        canonical base threshold (default=0.8)
  --ctbam CTBAM         specify which .bam(s) are C/T substitution data (can
                        be comma-delimited)
  --logcover            apply log2(count+1) to coverage data (--plot_coverage)
  --coverprocs COVERPROCS
                        processes to use for coverage function (default=1)
  --bed BED             .bed file for additional annotations (BED3+3: chrom,
                        start, end, label, strand, color)
  --hidebedlabel        hide lables from .bed track
  --highlight_bed HIGHLIGHT_BED
                        BED3+1 format (chrom, start, end, optional_colour)
                        where colour (optional) must be intelligible to
                        matplotlib
  --highlight_subplot   make sub-plots for highlighted regions of smoothed
                        plots grouped by colormap (incl --phasediff plot),
                        requires --highlight and --colormap
  --variants VARIANTS   variants to highlight, bgzipped/tabix VCF
  --splitvar SPLITVAR   split variant on variant with ID (uses ID field from
                        --variants VCF)
  --variantpalette VARIANTPALETTE
                        colour palette for variant ticks (default = Set1)
  --variantsize VARIANTSIZE
                        size of variant ticks (default = 6)
  --motifsize MOTIFSIZE
                        mod motif size, only used with -b/--bams (default is 2
                        as "CG" is most common use case, e.g. set to 1 for
                        6mA)
  --allreads            show all alignments (secondary/supplementary
                        alignments hidden by default)
  --phased              split samples into phases
  --phasediff           add absolute difference between phases as output
  --ignore_ps           do not use phase set (PS) when plotting phased data
                        (HP only)
  --color_by_hp         color samples by HP value (req --phased)
  --color_by_phase      color samples by phase (req --phased)
  --colormap COLORMAP   map annotations to colours, can be file with mapping
                        or "auto"
  --phase_labels PHASE_LABELS
                        if --color_by_hp substitute HP tags for labels. Format
                        HP:Label comma-delimited e.g.: 1:Father,2:Mother
  --include_unphased    include an "unphased" category if called with --phased
  --readmask READMASK   mask reads from being shown in interval(s) (start-end
                        or chrom:start-end; chrom ignored). Can be comma-
                        delimited.
  --readmarker READMARKER
                        marker for (un)methylated glpyhs in read panel
                        (matplotlib markers, default=o)
  --markeralpha MARKERALPHA
                        alpha (transparency) for (un)methylation marker
                        (default=1.0)
  --readmarkersize READMARKERSIZE
                        marker size for (un)methylated glpyhs in read panel
                        (default=2.0)
  --readlinewidth READLINEWIDTH
                        width for lines representing read alignments
                        (default=1.0)
  --readlinealpha READLINEALPHA
                        alpha (transparency) for read mapping lines
                        (default=0.4)
  --readopenmarkeredgecolor READOPENMARKEREDGECOLOR
                        edge color for open (unmethylated) markers in read
                        plot (default = sample color)
  --slidingwindowsize SLIDINGWINDOWSIZE
                        size of initial sliding window for coverage check
                        (default=2)
  --smoothfunc SMOOTHFUNC
                        smoothing function, one of:
                        flat,hanning,hamming,bartlett,blackman (default =
                        hanning)
  --smoothalpha SMOOTHALPHA
                        alpha (transparency) value for smoothed plot (default
                        = 1.0)
  --smoothlinewidth SMOOTHLINEWIDTH
                        smooth line width (default = 4.0)
  --shuffle             shuffle sample order for smoothed plot (may reduce
                        visual bias due to sample order)
  --smoothed_csv SMOOTHED_CSV
                        output values from smoothed plot to CSV format (can
                        specify filename or "auto")
  --maskcutoff MASKCUTOFF
                        read count masking cutoff (default=1)
  --maxmaskedfrac MAXMASKEDFRAC
                        skip smoothed plot if fraction of sample masked
                        (--maskcutoff) > this value (default = 1.0)
  --nomask              skip drawing segment masks
  --mincalls MINCALLS   drop modspace positions if call count (meth+unmeth) <
                        --mincalls (default=0)
  --max_read_density MAX_READ_DENSITY
                        filter reads with call density greater >= value, can
                        be helpful in footprinting assays (default=None)
  --modspace MODSPACE   spacing between links in top panel (default=auto)
  --genes GENES         genes of interest (comma delimited)
  --labelgenes          plot gene names
  --hidelegend          hide legends
  --exonheight EXONHEIGHT
                        set exon height (default=0.8)
  --show_transcripts    plot all transcripts, use
                        transcript_id/transcript_name attrs
  --ymin YMIN           y-axis minimum for smoothed plot (default = -0.05)
  --ymax YMAX           y-axis maximum for smoothed plot (default = 1.05)
  --cover_ymin COVER_YMIN
                        y-axis minimum for coverage plot (default = 0)
  --nticks NTICKS       tick count (default=10)
  --statname STATNAME   label for raw statistic plot
  --samplepalette SAMPLEPALETTE
                        palette for samples (default = "tab10"), see https://s
                        eaborn.pydata.org/tutorial/color_palettes.html
  --coverpalette COVERPALETTE
                        colour palette name for coverage plot (default =
                        "mako")
  --highlightpalette HIGHLIGHTPALETTE
                        colour palette name for highlights (default = "Blues")
  --genepalette GENEPALETTE
                        colour palette name for highlights (default =
                        "viridis")
  --highlight_alpha HIGHLIGHT_ALPHA
                        alpha for highlighting in panels (between 0 and 1,
                        default = 0.25)
  --excl_ambig
  --primary_only        ignore non-primary alignments
  --unambig_highlight
  --width WIDTH         image width (inches, default=16)
  --height HEIGHT       image width (inches, default=8)
  --notext              remove all text from figure
  --svg
```


## methylartist_region

### Tool Description
Plot methylation data for a specific genomic region, including alignment tracks, smoothed methylation profiles, and gene annotations.

### Metadata
- **Docker Image**: quay.io/biocontainers/methylartist:1.5.3--pyhdfd78af_0
- **Homepage**: https://github.com/adamewing/methylartist
- **Package**: https://anaconda.org/channels/bioconda/packages/methylartist/overview
- **Validation**: PASS

### Original Help Text
```text
usage: methylartist region [-h] -i INTERVAL [-d DATA] [-b BAMS] -n MOTIF
                           -r REF [-g GTF] [-C CSI] [-l HIGHLIGHT]
                           [-w WINDOWS] [-p PROCS] [-m MODS]
                           [-s SMOOTHWINDOWSIZE] [-q MIN_MAPQ]
                           [-c PLOT_COVERAGE] [-o OUTFILE]
                           [--meth_thresh METH_THRESH]
                           [--can_thresh CAN_THRESH] [--bedmethyl]
                           [--ctbam CTBAM] [--bed BED] [--hidebedlabel]
                           [--logcover] [--allreads]
                           [--highlight_bed HIGHLIGHT_BED]
                           [--motifsize MOTIFSIZE]
                           [--maxuncovered MAXUNCOVERED] [--modspace MODSPACE]
                           [--readmask READMASK]
                           [--min_window_calls MIN_WINDOW_CALLS]
                           [--smoothfunc SMOOTHFUNC]
                           [--smoothalpha SMOOTHALPHA]
                           [--smoothlinewidth SMOOTHLINEWIDTH] [--shuffle]
                           [--segment_csv SEGMENT_CSV] [--eff EFF]
                           [--ymin YMIN] [--ymax YMAX]
                           [--cover_ymin COVER_YMIN]
                           [--max_read_density MAX_READ_DENSITY]
                           [--samplepalette SAMPLEPALETTE]
                           [--coverpalette COVERPALETTE]
                           [--highlightpalette HIGHLIGHTPALETTE]
                           [--genepalette GENEPALETTE]
                           [--gene_track_height GENE_TRACK_HEIGHT]
                           [--highlight_alpha HIGHLIGHT_ALPHA]
                           [--highlight_centerline HIGHLIGHT_CENTERLINE]
                           [--panelratios PANELRATIOS] [--nticks NTICKS]
                           [--skip_align_plot] [--force_align_plot]
                           [--genes GENES] [--labelgenes] [--show_transcripts]
                           [--exonheight EXONHEIGHT] [--width WIDTH]
                           [--height HEIGHT] [--dmr_minreads DMR_MINREADS]
                           [--dmr_minratio DMR_MINRATIO]
                           [--dmr_maxoverlap DMR_MAXOVERLAP]
                           [--dmr_mindiff DMR_MINDIFF]
                           [--dmr_minmotifs DMR_MINMOTIFS] [--write_dmrs]
                           [--phased] [--primary_only] [--color_by_hp]
                           [--colormap COLORMAP]
                           [--scale_fullwidth SCALE_FULLWIDTH] [--svg]

options:
  -h, --help            show this help message and exit
  -i, --interval INTERVAL
                        chrom:start-end
  -d, --data DATA       text file with .bam filename and corresponding
                        methylation database per line(whitespace-delimited)
  -b, --bams BAMS       one or more .bams with MM and ML tags for modification
                        calls (see samtags spec)
  -n, --motif MOTIF     normalise window sizes to motif occurance
  -r, --ref REF         ref genome fasta, required if normalising windows with
                        -n/--norm_motif
  -g, --gtf GTF         genes or intervals to display in gtf format
  -C, --csi CSI         csi index for the gtf, optional
  -l, --highlight HIGHLIGHT
                        format: start-end, (can be chrom:start-end but chrom
                        is ignored) can comma-delimit multiple highlights
  -w, --windows WINDOWS
                        set window count, default=auto
  -p, --procs PROCS     multiprocessing
  -m, --mods MODS       mods to consider (comma-delimited, default = all
                        available)
  -s, --smoothwindowsize SMOOTHWINDOWSIZE
                        size of window for smoothing (default=auto)
  -q, --min_mapq MIN_MAPQ
                        minimum mapping quality (mapq), default = 10
  -c, --plot_coverage PLOT_COVERAGE
                        plot coverage from bam(s) (can be comma-delimited
                        list)
  -o, --outfile OUTFILE
                        output file name (default: generated from input)
  --meth_thresh METH_THRESH
                        modified base threshold (default=0.8)
  --can_thresh CAN_THRESH
                        canonical base threshold (default=0.8)
  --bedmethyl           input is (tabix-indexed) bedMethyl
  --ctbam CTBAM         specify which .bam(s) are C/T substitution data (can
                        be comma-delimited)
  --bed BED             .bed file for additional annotations (BED3+3: chrom,
                        start, end, label, strand, color)
  --hidebedlabel        hide lables from .bed track
  --logcover            apply log2(count+1) to coverage data (--plot_coverage)
  --allreads            show all alignments (secondary/supplementary
                        alignments hidden by default)
  --highlight_bed HIGHLIGHT_BED
                        BED3+1 format (chrom, start, end, optional_colour)
                        where colour (optional) must be intelligible to
                        matplotlib
  --motifsize MOTIFSIZE
                        mod motif size, only used with -b/--bams (default is 2
                        as "CG" is most common use case, e.g. set to 1 for
                        6mA)
  --maxuncovered MAXUNCOVERED
                        maximum percentage of uncovered windows tolerated
                        (default = 50.0)
  --modspace MODSPACE   increase to increase spacing between links in top
                        panel (default=auto)
  --readmask READMASK   mask reads from being shown in interval(s) (start-end
                        or chrom:start-end; chrom ignored). Can be comma-
                        delimited.
  --min_window_calls MIN_WINDOW_CALLS
                        minimum reads per window to include in plot (default =
                        1)
  --smoothfunc SMOOTHFUNC
                        smoothing function, one of:
                        flat,hanning,hamming,bartlett,blackman (default =
                        hanning)
  --smoothalpha SMOOTHALPHA
                        alpha (transparency) value for smoothed plot (default
                        = 1.0)
  --smoothlinewidth SMOOTHLINEWIDTH
                        smooth line width (default = 4.0)
  --shuffle             shuffle sample order for smoothed plot (may reduce
                        visual bias due to sample order)
  --segment_csv SEGMENT_CSV
                        output values from smoothed segment plot to specified
                        filename in CSV format (default=None)
  --eff EFF             conversion efficiency (for e.g. bs-seq or em-seq),
                        input as comma-delimited sample:eff e.g.
                        MySample1.m:0.9,MySample2.m:0.8
  --ymin YMIN           y-axis minimum for smoothed plot (default = -0.05)
  --ymax YMAX           y-axis maximum for smoothed plot (default = 1.05
  --cover_ymin COVER_YMIN
                        y-axis minimum for coverage plot (default = 0)
  --max_read_density MAX_READ_DENSITY
                        filter reads with call density greater >= value, can
                        be helpful in footprinting assays (default=None)
  --samplepalette SAMPLEPALETTE
                        palette for samples (default = "tab10"), see https://s
                        eaborn.pydata.org/tutorial/color_palettes.html
  --coverpalette COVERPALETTE
                        colour palette name for coverage plot (default =
                        "mako")
  --highlightpalette HIGHLIGHTPALETTE
                        colour palette name for highlights (default = "Blues")
  --genepalette GENEPALETTE
                        colour palette name for highlights (default =
                        "viridis")
  --gene_track_height GENE_TRACK_HEIGHT
                        maximum number of gene track layers
  --highlight_alpha HIGHLIGHT_ALPHA
                        alpha for highlighting in panels (between 0 and 1,
                        default = 0.25)
  --highlight_centerline HIGHLIGHT_CENTERLINE
                        change highlight to line (specify width)
  --panelratios PANELRATIOS
                        Alter panel ratios: needs to be 4 (or 5 if
                        --plot_coverage) comma-seperated integers. Default:
                        1,5,3,3
  --nticks NTICKS       tick count (default=10)
  --skip_align_plot     blank alignment plot, useful if unneeded or for
                        runtime.
  --force_align_plot    retain alignment plot even over regions > 5Mbp where
                        it would be disabled automatically
  --genes GENES         genes of interest (comma delimited)
  --labelgenes          plot gene names
  --show_transcripts    plot all transcripts, use
                        transcript_id/transcript_name attrs
  --exonheight EXONHEIGHT
                        set exon height (default=0.8)
  --width WIDTH         image width (inches, default=16)
  --height HEIGHT       image width (inches, default=8)
  --dmr_minreads DMR_MINREADS
                        minimum reads per group for DMR prediction (default=8)
  --dmr_minratio DMR_MINRATIO
                        minimum reads ratio for DMR prediction (default=0.3)
  --dmr_maxoverlap DMR_MAXOVERLAP
                        max overlap between distributions (default = 0.0)
  --dmr_mindiff DMR_MINDIFF
                        minimum difference between means (default = 0.4)
  --dmr_minmotifs DMR_MINMOTIFS
                        minimum motif count for DMR prediction (default = 20)
  --write_dmrs          record differentially methylated windows to a file
  --phased              currently only considers two phases (diploid)
  --primary_only        ignore non-primary alignments
  --color_by_hp         color samples by HP value (req --phased)
  --colormap COLORMAP   map annotations to colours, can be file with mapping
                        or "auto"
  --scale_fullwidth SCALE_FULLWIDTH
                        scale plot output relative to value (e.g. use length
                        of chrom 1)
  --svg
```


## methylartist_composite

### Tool Description
Generate composite methylation plots for transposable elements or other genomic features.

### Metadata
- **Docker Image**: quay.io/biocontainers/methylartist:1.5.3--pyhdfd78af_0
- **Homepage**: https://github.com/adamewing/methylartist
- **Package**: https://anaconda.org/channels/bioconda/packages/methylartist/overview
- **Validation**: PASS

### Original Help Text
```text
usage: methylartist composite [-h] [-d DATA] [-b BAMS] -s SEGDATA -r REF
                              -t TEREF [-p PROCS] [-c PALETTE] [-a ALPHA]
                              [-w LINEWIDTH] [-l LENFRAC] [-q MIN_MAPQ]
                              [-o OUTFILE] [--meth_thresh METH_THRESH]
                              [--can_thresh CAN_THRESH]
                              [--meanplot_ylabel MEANPLOT_YLABEL]
                              [--meanplot_cutoff MEANPLOT_CUTOFF] [--mod MOD]
                              [--motif MOTIF] [--blocks BLOCKS]
                              [--start START] [--end END]
                              [--mincalls MINCALLS] [--minelts MINELTS]
                              [--maxelts MAXELTS]
                              [--slidingwindowsize SLIDINGWINDOWSIZE]
                              [--slidingwindowstep SLIDINGWINDOWSTEP]
                              [--smoothwindowsize SMOOTHWINDOWSIZE]
                              [--smoothfunc SMOOTHFUNC] [--ymin YMIN]
                              [--ymax YMAX]
                              [--max_read_density MAX_READ_DENSITY]
                              [--excl_ambig] [--primary_only] [--phased]
                              [--color_by_phase] [--output_table] [--svg]

options:
  -h, --help            show this help message and exit
  -d, --data DATA       text file with .bam filename and corresponding
                        methylation database per line(whitespace-delimited)
  -b, --bams BAMS       one or more .bams with MM and ML tags for modification
                        calls (see samtags spec)
  -s, --segdata SEGDATA
                        BED3+1: chrom, start, end, strand
  -r, --ref REF         ref genome fasta
  -t, --teref TEREF     TE ref fasta
  -p, --procs PROCS     multiprocessing
  -c, --palette PALETTE
                        palette for samples (default = "tab10"), see https://s
                        eaborn.pydata.org/tutorial/color_palettes.html
  -a, --alpha ALPHA     alpha (default: 0.3)
  -w, --linewidth LINEWIDTH
                        line width (default: 1)
  -l, --lenfrac LENFRAC
                        fraction of TE length that must align (default 0.95)
  -q, --min_mapq MIN_MAPQ
                        minimum mapping quality (mapq), default = 10
  -o, --outfile OUTFILE
                        output file name (default: generated from input)
  --meth_thresh METH_THRESH
                        modified base threshold (default=0.8)
  --can_thresh CAN_THRESH
                        canonical base threshold (default=0.8)
  --meanplot_ylabel MEANPLOT_YLABEL
                        set y-axis label on mean plot
  --meanplot_cutoff MEANPLOT_CUTOFF
                        override site coverage cutoff for mean plot (see
                        output for automatic value)
  --mod MOD             modification to plot (mod codes will be listed,
                        default: infer from sample name
  --motif MOTIF         modified motif to highlight (default = CG)
  --blocks BLOCKS       blocks to highlight (txt file with start, end, name,
                        hex colour)
  --start START         start plotting at this base (default None)
  --end END             end plotting at this base (default None)
  --mincalls MINCALLS   minimum call count to include elt (default = 100)
  --minelts MINELTS     minimum output elements (default = 1)
  --maxelts MAXELTS     maximum output elements, if > max random.sample()
                        (default = 200)
  --slidingwindowsize SLIDINGWINDOWSIZE
                        size of sliding window for meth frac (default 10)
  --slidingwindowstep SLIDINGWINDOWSTEP
                        step size for meth frac (default 1)
  --smoothwindowsize SMOOTHWINDOWSIZE
                        size of window for smoothing (default 8)
  --smoothfunc SMOOTHFUNC
                        smoothing function, one of:
                        flat,hanning,hamming,bartlett,blackman (default =
                        hanning)
  --ymin YMIN           y-axis minimum for smoothed plot
  --ymax YMAX           y-axis maximum for smoothed plot
  --max_read_density MAX_READ_DENSITY
                        filter reads with call density greater >= value, can
                        be helpful in footprinting assays (default=None)
  --excl_ambig
  --primary_only        ignore non-primary alignments
  --phased              currently only considers two phases (diploid)
  --color_by_phase      color samples by HP value (req --phased)
  --output_table        output per-site data to table (.tsv)
  --svg
```


## methylartist_wgmeth

### Tool Description
Whole-genome methylation calling and processing tool

### Metadata
- **Docker Image**: quay.io/biocontainers/methylartist:1.5.3--pyhdfd78af_0
- **Homepage**: https://github.com/adamewing/methylartist
- **Package**: https://anaconda.org/channels/bioconda/packages/methylartist/overview
- **Validation**: PASS

### Original Help Text
```text
usage: methylartist wgmeth [-h] -b BAM [-d METHDB] [-s BINSIZE] [-f FAI]
                           [-m MOD] [-p PROCS] [-c CHROM] [-q MIN_MAPQ]
                           [-r REF] [-o OUTFILE] [-l MINLEN]
                           [--meth_thresh METH_THRESH]
                           [--can_thresh CAN_THRESH] [--ctbam CTBAM]
                           [--motif MOTIF]
                           [--max_read_density MAX_READ_DENSITY] [--dss]
                           [--phased] [--primary_only]

options:
  -h, --help            show this help message and exit
  -b, --bam BAM         bam used for methylation calling
  -d, --methdb METHDB   methylation database
  -s, --binsize BINSIZE
                        bin size for parallelisation, default = 1000000
  -f, --fai FAI         fasta index (.fai), default = --ref + .fai, required
                        for .db files
  -m, --mod MOD         output for specific mod (names vary, see output for
                        hints)
  -p, --procs PROCS     multiprocessing
  -c, --chrom CHROM     limit analysis to one chromosome
  -q, --min_mapq MIN_MAPQ
                        minimum mapping quality (mapq), default = 10
  -r, --ref REF         reference genome .fa (build .fai index with samtools
                        faidx) (required for mod bams)
  -o, --outfile OUTFILE
                        output file name (default: generated from input)
  -l, --minlen MINLEN   minimum chromosome length (default = 0)
  --meth_thresh METH_THRESH
                        modified base threshold (default=0.8)
  --can_thresh CAN_THRESH
                        canonical base threshold (default=0.8)
  --ctbam CTBAM         specify which .bam(s) are C/T substitution data (can
                        be comma-delimited)
  --motif MOTIF         expected modification motif (e.g. CG for 5mCpG
                        required for mod bams)
  --max_read_density MAX_READ_DENSITY
                        filter reads with call density greater >= value, can
                        be helpful in footprinting assays (default=None)
  --dss                 output in DSS format (default = bedMethyl)
  --phased              split output into phases (currently just 1,2)
  --primary_only        ignore non-primary alignments
```


## methylartist_adjustcutoffs

### Tool Description
Adjust methylation cutoffs in a methylartist database

### Metadata
- **Docker Image**: quay.io/biocontainers/methylartist:1.5.3--pyhdfd78af_0
- **Homepage**: https://github.com/adamewing/methylartist
- **Package**: https://anaconda.org/channels/bioconda/packages/methylartist/overview
- **Validation**: PASS

### Original Help Text
```text
usage: methylartist adjustcutoffs [-h] -d DB --mod MOD -m METHYLATED
                                  -u UNMETHYLATED

options:
  -h, --help            show this help message and exit
  -d, --db DB           methylartist database
  --mod MOD             modification to plot (will list for user if incorrect)
  -m, --methylated METHYLATED
                        mark as methylated above cutoff value
  -u, --unmethylated UNMETHYLATED
                        mark as unmethylated below cutoff value
```


## methylartist_scoredist

### Tool Description
Plot the distribution of modification scores from methylartist databases or BAM files.

### Metadata
- **Docker Image**: quay.io/biocontainers/methylartist:1.5.3--pyhdfd78af_0
- **Homepage**: https://github.com/adamewing/methylartist
- **Package**: https://anaconda.org/channels/bioconda/packages/methylartist/overview
- **Validation**: PASS

### Original Help Text
```text
usage: methylartist scoredist [-h] [-d DB] [-b BAM] [-n N] -m MOD [-r REF]
                              [-o OUTFILE] [--motif MOTIF] [--xmin XMIN]
                              [--xmax XMAX] [--lw LW] [--palette PALETTE]
                              [--svg]

options:
  -h, --help            show this help message and exit
  -d, --db DB           methylartist database(s), can be comma-delimited
  -b, --bam BAM         one or more .bam files with MM and ML tags for
                        modification calls (see samtags spec)
  -n, --n N             sample size (default = 1000000)
  -m, --mod MOD         modification to plot (will list for user if incorrect)
  -r, --ref REF         reference genome fasta (samtools faidx indexed)
  -o, --outfile OUTFILE
                        output file name (default: generated from input)
  --motif MOTIF         modified motif to highlight (e.g. CG)
  --xmin XMIN
  --xmax XMAX
  --lw LW               line width (default = 2)
  --palette PALETTE     palette for phases (default = "tab10"), see https://se
                        aborn.pydata.org/tutorial/color_palettes.html
  --svg
```


## Metadata
- **Skill**: generated
