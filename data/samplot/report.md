# samplot CWL Generation Report

## samplot_plot

### Tool Description
Plot BAM/CRAM files

### Metadata
- **Docker Image**: quay.io/biocontainers/samplot:1.3.0--pyh5e36f6f_1
- **Homepage**: https://github.com/ryanlayer/samplot
- **Package**: https://anaconda.org/channels/bioconda/packages/samplot/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/samplot/overview
- **Total Downloads**: 67.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/ryanlayer/samplot
- **Stars**: N/A
### Original Help Text
```text
usage: samplot plot [-h] [-n TITLES [TITLES ...]] [-r REFERENCE] [-z Z] -b
                    BAMS [BAMS ...] [-o OUTPUT_FILE] [--output_dir OUTPUT_DIR]
                    -s START -e END -c CHROM [-w WINDOW] [-d MAX_DEPTH]
                    [-t SV_TYPE] [-T TRANSCRIPT_FILE]
                    [--transcript_filename TRANSCRIPT_FILENAME]
                    [--max_coverage_points MAX_COVERAGE_POINTS]
                    [-A ANNOTATION_FILES [ANNOTATION_FILES ...]]
                    [--annotation_filenames ANNOTATION_FILENAMES [ANNOTATION_FILENAMES ...]]
                    [--coverage_tracktype {stack,superimpose,none}] [-a]
                    [-H PLOT_HEIGHT] [-W PLOT_WIDTH] [-q INCLUDE_MQUAL]
                    [--separate_mqual SEPARATE_MQUAL] [-j]
                    [--start_ci START_CI] [--end_ci END_CI]
                    [--long_read LONG_READ] [--ignore_hp]
                    [--min_event_size MIN_EVENT_SIZE]
                    [--xaxis_label_fontsize XAXIS_LABEL_FONTSIZE]
                    [--yaxis_label_fontsize YAXIS_LABEL_FONTSIZE]
                    [--legend_fontsize LEGEND_FONTSIZE]
                    [--annotation_fontsize ANNOTATION_FONTSIZE]
                    [--common_insert_size] [--hide_annotation_labels]
                    [--coverage_only] [--max_coverage MAX_COVERAGE]
                    [--same_yaxis_scales] [--marker_size MARKER_SIZE]
                    [--dpi DPI] [--annotation_scalar ANNOTATION_SCALAR]
                    [--zoom ZOOM] [--debug DEBUG]

optional arguments:
  -h, --help            show this help message and exit
  -n TITLES [TITLES ...], --titles TITLES [TITLES ...]
                        Space-delimited list of plot titles. Use quote marks
                        to include spaces (i.e. "plot 1" "plot 2")
  -r REFERENCE, --reference REFERENCE
                        Reference file for CRAM, required if CRAM files used
  -z Z, --z Z           Number of stdevs from the mean (default 4)
  -b BAMS [BAMS ...], --bams BAMS [BAMS ...]
                        Space-delimited list of BAM/CRAM file names
  -o OUTPUT_FILE, --output_file OUTPUT_FILE
                        Output file name/type. Defaults to
                        {type}_{chrom}_{start}_{end}.png
  --output_dir OUTPUT_DIR
                        Output directory name. Defaults to working dir.
                        Ignored if --output_file is set
  -s START, --start START
                        Start position of region/variant (add multiple for
                        translocation/BND events)
  -e END, --end END     End position of region/variant (add multiple for
                        translocation/BND events)
  -c CHROM, --chrom CHROM
                        Chromosome (add multiple for translocation/BND events)
  -w WINDOW, --window WINDOW
                        Window size (count of bases to include in view),
                        default(0.5 * len)
  -d MAX_DEPTH, --max_depth MAX_DEPTH
                        Max number of normal pairs to plot
  -t SV_TYPE, --sv_type SV_TYPE
                        SV type. If omitted, plot is created without variant
                        bar
  -T TRANSCRIPT_FILE, --transcript_file TRANSCRIPT_FILE
                        GFF3 of transcripts
  --transcript_filename TRANSCRIPT_FILENAME
                        Name for transcript track
  --max_coverage_points MAX_COVERAGE_POINTS
                        number of points to plot in coverage axis (downsampled
                        from region size for speed)
  -A ANNOTATION_FILES [ANNOTATION_FILES ...], --annotation_files ANNOTATION_FILES [ANNOTATION_FILES ...]
                        Space-delimited list of bed.gz tabixed files of
                        annotations (such as repeats, mappability, etc.)
  --annotation_filenames ANNOTATION_FILENAMES [ANNOTATION_FILENAMES ...]
                        Space-delimited list of names for the tracks in
                        --annotation_files
  --coverage_tracktype {stack,superimpose,none}
                        type of track to use for low MAPQ coverage plot.
  -a, --print_args      Print commandline arguments to a json file, useful
                        with PlotCritic
  -H PLOT_HEIGHT, --plot_height PLOT_HEIGHT
                        Plot height
  -W PLOT_WIDTH, --plot_width PLOT_WIDTH
                        Plot width
  -q INCLUDE_MQUAL, --include_mqual INCLUDE_MQUAL
                        Min mapping quality of reads to be included in plot
                        (default 1)
  --separate_mqual SEPARATE_MQUAL
                        coverage from reads with MAPQ <= separate_mqual
                        plotted in lighter grey. To disable, pass in negative
                        value
  -j, --json_only       Create only the json file, not the image plot
  --start_ci START_CI   confidence intervals of SV first breakpoint (distance
                        from the breakpoint). Must be a comma-separated pair
                        of ints (i.e. 20,40)
  --end_ci END_CI       confidence intervals of SV end breakpoint (distance
                        from the breakpoint). Must be a comma-separated pair
                        of ints (i.e. 20,40)
  --long_read LONG_READ
                        Min length of a read to be treated as a long-read
                        (default 1000)
  --ignore_hp           Choose to ignore HP tag in alignment files
  --min_event_size MIN_EVENT_SIZE
                        Min size of an event in long-read CIGAR to include
                        (default 20)
  --xaxis_label_fontsize XAXIS_LABEL_FONTSIZE
                        Font size for X-axis labels (default 6)
  --yaxis_label_fontsize YAXIS_LABEL_FONTSIZE
                        Font size for Y-axis labels (default 6)
  --legend_fontsize LEGEND_FONTSIZE
                        Font size for legend labels (default 6)
  --annotation_fontsize ANNOTATION_FONTSIZE
                        Font size for annotation labels (default 6)
  --common_insert_size  Set common insert size for all plots
  --hide_annotation_labels
                        Hide the label (fourth column text) from annotation
                        files, useful for regions with many annotations
  --coverage_only       Hide all reads and show only coverage
  --max_coverage MAX_COVERAGE
                        apply a maximum coverage cutoff. Unlimited by default
  --same_yaxis_scales   Set the scales of the Y axes to the max of all
  --marker_size MARKER_SIZE
                        Size of marks on pairs and splits (default 3)
  --dpi DPI             Dots per inches (pixel count, default 300)
  --annotation_scalar ANNOTATION_SCALAR
                        scaling factor for the optional annotation/trascript
                        tracks
  --zoom ZOOM           Only show +- zoom amount around breakpoints, much
                        faster for large regions. Ignored if region smaller
                        than --zoom (default 500000)
  --debug DEBUG         Print debug statements
```


## samplot_vcf

### Tool Description
Plots structural variants from VCF and BAM/CRAM files.

### Metadata
- **Docker Image**: quay.io/biocontainers/samplot:1.3.0--pyh5e36f6f_1
- **Homepage**: https://github.com/ryanlayer/samplot
- **Package**: https://anaconda.org/channels/bioconda/packages/samplot/overview
- **Validation**: PASS

### Original Help Text
```text
usage: samplot vcf [-h] [--vcf VCF] [-d OUT_DIR] [--ped PED] [--dn_only]
                   [--min_call_rate MIN_CALL_RATE] [--filter FILTER]
                   [-O {png,pdf,eps,jpg}] [--max_hets MAX_HETS]
                   [--min_entries MIN_ENTRIES] [--max_entries MAX_ENTRIES]
                   [--max_mb MAX_MB] [--min_bp MIN_BP]
                   [--important_regions IMPORTANT_REGIONS] -b BAMS [BAMS ...]
                   [--sample_ids SAMPLE_IDS [SAMPLE_IDS ...]]
                   [--command_file COMMAND_FILE] [--format FORMAT]
                   [--gff3 GFF3] [--downsample DOWNSAMPLE] [--manual_run]
                   [--plot_all] [--debug]

optional arguments:
  -h, --help            show this help message and exit
  --vcf VCF, -v VCF     VCF file containing structural variants (default:
                        None)
  -d OUT_DIR, --out-dir OUT_DIR
                        path to write output images (default: samplot-out)
  --ped PED             path to ped (or .fam) file (default: None)
  --dn_only             plots only putative de novo variants (PED file
                        required) (default: False)
  --min_call_rate MIN_CALL_RATE
                        only plot variants with at least this call-rate
                        (default: None)
  --filter FILTER       simple filter that samples must meet. Join multiple
                        filters with '&' and specify --filter multiple times
                        for 'or' e.g. DHFFC < 0.7 & SVTYPE = 'DEL' (default:
                        [])
  -O {png,pdf,eps,jpg}, --output_type {png,pdf,eps,jpg}
                        type of output figure (default: png)
  --max_hets MAX_HETS   only plot variants with at most this many
                        heterozygotes (default: None)
  --min_entries MIN_ENTRIES
                        try to include homref samples as controls to get this
                        many samples in plot (default: 6)
  --max_entries MAX_ENTRIES
                        only plot at most this many heterozygotes (default:
                        10)
  --max_mb MAX_MB       skip variants longer than this many megabases
                        (default: None)
  --min_bp MIN_BP       skip variants shorter than this many bases (default:
                        20)
  --important_regions IMPORTANT_REGIONS
                        only report variants that overlap regions in this bed
                        file (default: None)
  -b BAMS [BAMS ...], --bams BAMS [BAMS ...]
                        Space-delimited list of BAM/CRAM file names (default:
                        None)
  --sample_ids SAMPLE_IDS [SAMPLE_IDS ...]
                        Space-delimited list of sample IDs, must have same
                        order as BAM/CRAM file names. BAM RG tag required if
                        this is omitted. (default: None)
  --command_file COMMAND_FILE
                        store commands in this file. (default:
                        samplot_vcf_cmds.tmp)
  --format FORMAT       comma separated list of FORMAT fields to include in
                        sample plot title (default: AS,AP,DHFFC)
  --gff3 GFF3           genomic regions (.gff with .tbi in same directory)
                        used when building HTML table and table filters
                        (default: None)
  --downsample DOWNSAMPLE
                        Number of normal reads/pairs to plot (default: 1)
  --manual_run          disables auto-run for the plotting commands (default:
                        False)
  --plot_all            plots all samples and all variants - limited by any
                        filtering arguments set (default: False)
  --debug               prints out the reason for skipping any skipped variant
                        entry (default: False)
```

