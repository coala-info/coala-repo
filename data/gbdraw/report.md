# gbdraw CWL Generation Report

## gbdraw_circular

### Tool Description
Generate genome diagrams in PNG/PDF/SVG/PS/EPS. Diagrams for multiple entries are saved separately.

### Metadata
- **Docker Image**: quay.io/biocontainers/gbdraw:0.8.0--pyhdfd78af_0
- **Homepage**: https://github.com/satoshikawato/gbdraw
- **Package**: https://anaconda.org/channels/bioconda/packages/gbdraw/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/gbdraw/overview
- **Total Downloads**: 1.7K
- **Last updated**: 2025-12-20
- **GitHub**: https://github.com/satoshikawato/gbdraw
- **Stars**: N/A
### Original Help Text
```text
usage: gbdraw [-h] [--gbk [GBK_FILE ...]] [--gff [GFF3_FILE ...]]
              [--fasta [FASTA_FILE ...]] [-o OUTPUT] [-p PALETTE] [-t TABLE]
              [-d DEFAULT_COLORS] [-n NT] [-w WINDOW] [-s STEP]
              [--species SPECIES] [--strain STRAIN] [-k FEATURES]
              [--block_stroke_color BLOCK_STROKE_COLOR]
              [--block_stroke_width BLOCK_STROKE_WIDTH]
              [--axis_stroke_color AXIS_STROKE_COLOR]
              [--axis_stroke_width AXIS_STROKE_WIDTH]
              [--line_stroke_color LINE_STROKE_COLOR]
              [--line_stroke_width LINE_STROKE_WIDTH]
              [--definition_font_size DEFINITION_FONT_SIZE]
              [--label_font_size LABEL_FONT_SIZE] [-f FORMAT] [--suppress_gc]
              [--suppress_skew] [-l LEGEND] [--separate_strands]
              [--track_type TRACK_TYPE] [--show_labels] [--allow_inner_labels]
              [--label_whitelist LABEL_WHITELIST |
              --label_blacklist LABEL_BLACKLIST]
              [--qualifier_priority QUALIFIER_PRIORITY]
              [--outer_label_x_radius_offset OUTER_LABEL_X_RADIUS_OFFSET]
              [--outer_label_y_radius_offset OUTER_LABEL_Y_RADIUS_OFFSET]
              [--inner_label_x_radius_offset INNER_LABEL_X_RADIUS_OFFSET]
              [--inner_label_y_radius_offset INNER_LABEL_Y_RADIUS_OFFSET]
              [--scale_interval SCALE_INTERVAL]
              [--legend_box_size LEGEND_BOX_SIZE]
              [--legend_font_size LEGEND_FONT_SIZE]

Generate genome diagrams in PNG/PDF/SVG/PS/EPS. Diagrams for multiple entries
are saved separately.

options:
  -h, --help            show this help message and exit
  --gbk [GBK_FILE ...]  Genbank/DDBJ flatfile
  --gff [GFF3_FILE ...]
                        GFF3 file (instead of --gbk; --fasta is required)
  --fasta [FASTA_FILE ...]
                        FASTA file (required with --gff)
  -o, --output OUTPUT   output file prefix (default: accession number of the
                        sequence)
  -p, --palette PALETTE
                        Palette name (default: default)
  -t, --table TABLE     color table (optional)
  -d, --default_colors DEFAULT_COLORS
                        TSV file that overrides the color palette (optional)
  -n, --nt NT           dinucleotide (default: GC).
  -w, --window WINDOW   window size (optional; default: 1kb for genomes < 1Mb,
                        10kb for genomes <10Mb, 100kb for genomes >=10Mb)
  -s, --step STEP       step size (optional; default: 100 bp for genomes <
                        1Mb, 1kb for genomes <10Mb, 10kb for genomes >=10Mb)
  --species SPECIES     Species name (optional; e.g. "<i>Escherichia
                        coli</i>", "<i>Ca.</i> Hepatoplasma crinochetorum")
  --strain STRAIN       Strain/isolate name (optional; e.g. "K-12", "Av")
  -k, --features FEATURES
                        Comma-separated list of feature keys to draw (default:
                        CDS,rRNA,tRNA,tmRNA,ncRNA,misc_RNA,repeat_region)
  --block_stroke_color BLOCK_STROKE_COLOR
                        Block stroke color (str; default: "gray")
  --block_stroke_width BLOCK_STROKE_WIDTH
                        Block stroke width (optional; float; default: 2 pt for
                        genomes <= 50 kb, 0 pt for genomes >= 50 kb)
  --axis_stroke_color AXIS_STROKE_COLOR
                        Axis stroke color (str; default: "gray")
  --axis_stroke_width AXIS_STROKE_WIDTH
                        Axis stroke width (optional; float; default: 3 pt for
                        genomes <= 50 kb, 1 pt for genomes >= 50 kb)
  --line_stroke_color LINE_STROKE_COLOR
                        Line stroke color (str; default: "gray")
  --line_stroke_width LINE_STROKE_WIDTH
                        Line stroke width (optional; float; default: 5 pt for
                        genomes <= 50 kb, 1 pt for genomes >= 50 kb)
  --definition_font_size DEFINITION_FONT_SIZE
                        Definition font size (optional; default: 18)
  --label_font_size LABEL_FONT_SIZE
                        Label font size (optional; default: 14 (pt) for
                        genomes <= 50 kb, 8 for genomes >= 50 kb)
  -f, --format FORMAT   Comma-separated list of output file formats (svg, png,
                        pdf, eps, ps; default: svg).
  --suppress_gc         Suppress GC content track (default: False).
  --suppress_skew       Suppress GC skew track (default: False).
  -l, --legend LEGEND   Legend position (default: "right"; "left", "right",
                        "upper_left", "upper_right", "lower_left",
                        "lower_right", "none")
  --separate_strands    Separate strands (default: False).
  --track_type TRACK_TYPE
                        Track type (default: "tuckin"; "tuckin", "middle",
                        "spreadout")
  --show_labels         Show feature labels (default: False).
  --allow_inner_labels  Place labels inside the circle (default: False). If
                        enabled, labels are placed both inside and outside the
                        circle, and gc and skew tracks are not shown.
  --label_whitelist LABEL_WHITELIST
                        path to a file for label whitelisting (optional);
                        mutually exclusive with --label_blacklist
  --label_blacklist LABEL_BLACKLIST
                        Comma-separated keywords or path to a file for label
                        blacklisting (optional); mutually exclusive with
                        --label_whitelist
  --qualifier_priority QUALIFIER_PRIORITY
                        Path to a TSV file defining qualifier priority for
                        labels (optional)
  --outer_label_x_radius_offset OUTER_LABEL_X_RADIUS_OFFSET
                        Outer label x-radius offset factor (float; default
                        from config)
  --outer_label_y_radius_offset OUTER_LABEL_Y_RADIUS_OFFSET
                        Outer label y-radius offset factor (float; default
                        from config)
  --inner_label_x_radius_offset INNER_LABEL_X_RADIUS_OFFSET
                        Inner label x-radius offset factor (float; default
                        from config)
  --inner_label_y_radius_offset INNER_LABEL_Y_RADIUS_OFFSET
                        Inner label y-radius offset factor (float; default
                        from config)
  --scale_interval SCALE_INTERVAL
                        Manual scale interval for circular mode (in bp).
                        Overrides automatic calculation.
  --legend_box_size LEGEND_BOX_SIZE
                        Legend box size (optional; float; default: 24 (pixels,
                        96 dpi) for genomes <= 50 kb, 20 for genomes >= 50
                        kb).
  --legend_font_size LEGEND_FONT_SIZE
                        Legend font size (optional; float; default: 20 (pt)
                        for genomes <= 50 kb, 16 for genomes >= 50 kb).
```


## gbdraw_linear

### Tool Description
Generate plot in PNG/PDF/SVG/PS/EPS.

### Metadata
- **Docker Image**: quay.io/biocontainers/gbdraw:0.8.0--pyhdfd78af_0
- **Homepage**: https://github.com/satoshikawato/gbdraw
- **Package**: https://anaconda.org/channels/bioconda/packages/gbdraw/overview
- **Validation**: PASS

### Original Help Text
```text
usage: gbdraw [-h] [--gbk [GBK_FILE ...]] [--gff [GFF3_FILE ...]]
              [--fasta [FASTA_FILE ...]] [-b [BLAST ...]] [-t TABLE]
              [-p PALETTE] [-d DEFAULT_COLORS] [-o OUTPUT] [-n NT] [-w WINDOW]
              [-s STEP] [--separate_strands] [--show_gc] [--show_skew]
              [--align_center] [--evalue EVALUE] [--bitscore BITSCORE]
              [--identity IDENTITY] [-k FEATURES]
              [--block_stroke_color BLOCK_STROKE_COLOR]
              [--block_stroke_width BLOCK_STROKE_WIDTH]
              [--axis_stroke_color AXIS_STROKE_COLOR]
              [--axis_stroke_width AXIS_STROKE_WIDTH]
              [--line_stroke_color LINE_STROKE_COLOR]
              [--line_stroke_width LINE_STROKE_WIDTH]
              [--definition_font_size DEFINITION_FONT_SIZE]
              [--label_font_size LABEL_FONT_SIZE] [-f FORMAT] [-l LEGEND]
              [--show_labels [{all,first,none}]] [--resolve_overlaps]
              [--label_whitelist LABEL_WHITELIST |
              --label_blacklist LABEL_BLACKLIST]
              [--qualifier_priority QUALIFIER_PRIORITY]
              [--feature_height FEATURE_HEIGHT] [--gc_height GC_HEIGHT]
              [--comparison_height COMPARISON_HEIGHT]
              [--scale_style {bar,ruler}]
              [--scale_stroke_color SCALE_STROKE_COLOR]
              [--scale_stroke_width SCALE_STROKE_WIDTH]
              [--scale_font_size SCALE_FONT_SIZE]
              [--scale_interval SCALE_INTERVAL]
              [--legend_box_size LEGEND_BOX_SIZE]
              [--legend_font_size LEGEND_FONT_SIZE] [--normalize_length]

Generate plot in PNG/PDF/SVG/PS/EPS.

options:
  -h, --help            show this help message and exit
  --gbk [GBK_FILE ...]  Genbank/DDBJ flatfile
  --gff [GFF3_FILE ...]
                        GFF3 file (instead of --gbk; --fasta is required)
  --fasta [FASTA_FILE ...]
                        FASTA file (required with --gff)
  -b, --blast [BLAST ...]
                        input BLAST result file in tab-separated format
                        (-outfmt 6 or 7) (optional)
  -t, --table TABLE     color table (optional)
  -p, --palette PALETTE
                        Palette name (default: default)
  -d, --default_colors DEFAULT_COLORS
                        TSV file that overrides the color palette (optional)
  -o, --output OUTPUT   output file prefix (default: out)
  -n, --nt NT           dinucleotide skew (default: GC).
  -w, --window WINDOW   window size (optional; default: 1kb for genomes < 1Mb,
                        10kb for genomes <10Mb, 100kb for genomes >=10Mb)
  -s, --step STEP       step size (optional; default: 100 bp for genomes <
                        1Mb, 1kb for genomes <10Mb, 10kb for genomes >=10Mb)
  --separate_strands    separate forward and reverse strands (default: False).
                        Features of undefined strands are shown on the forward
                        strand.
  --show_gc             plot GC content below genome (default: False).
  --show_skew           plot GC skew below genome (default: False).
  --align_center        Align genomes to the center (default: False).
  --evalue EVALUE       evalue threshold (default=1e-2)
  --bitscore BITSCORE   bitscore threshold (default=50)
  --identity IDENTITY   identity threshold (default=0)
  -k, --features FEATURES
                        Comma-separated list of feature keys to draw (default:
                        CDS,rRNA,tRNA,tmRNA,ncRNA,misc_RNA,repeat_region)
  --block_stroke_color BLOCK_STROKE_COLOR
                        Block stroke color (str; default: "gray")
  --block_stroke_width BLOCK_STROKE_WIDTH
                        Block stroke width (optional; float; default: 2 pt for
                        genomes <= 50 kb, 0 pt for genomes >= 50 kb)
  --axis_stroke_color AXIS_STROKE_COLOR
                        Axis stroke color (str; default: "lightgray")
  --axis_stroke_width AXIS_STROKE_WIDTH
                        Axis stroke width (optional; float; default: 5 pt for
                        genomes <= 50 kb, 2 pt for genomes >= 50 kb)
  --line_stroke_color LINE_STROKE_COLOR
                        Line stroke color (optional; str; default:
                        "lightgray")
  --line_stroke_width LINE_STROKE_WIDTH
                        Line stroke width (optional; float; default: 5 pt for
                        genomes <= 50 kb, 1 pt for genomes >= 50 kb)
  --definition_font_size DEFINITION_FONT_SIZE
                        Definition font size (optional; float; default: 24 pt
                        for genomes <= 50 kb, 10 pt for genomes >= 50 kb)
  --label_font_size LABEL_FONT_SIZE
                        Label font size (optional; default: 24 pt for genomes
                        <= 50 kb, 5 pt for genomes >= 50 kb)
  -f, --format FORMAT   Comma-separated list of output file formats (svg, png,
                        pdf, eps, ps; default: svg).
  -l, --legend LEGEND   Legend position (default: "right"; "right", "left",
                        "top", "bottom", "none")
  --show_labels [{all,first,none}]
                        Show labels: no argument or 'all' (all records),
                        'first' (first record only), 'none' (no labels).
                        Default: 'none'
  --resolve_overlaps    Resolve overlaps (experimental; default: False).
  --label_whitelist LABEL_WHITELIST
                        path to a file for label whitelisting (optional);
                        mutually exclusive with --label_blacklist
  --label_blacklist LABEL_BLACKLIST
                        Comma-separated keywords or path to a file for label
                        blacklisting (optional); mutually exclusive with
                        --label_whitelist
  --qualifier_priority QUALIFIER_PRIORITY
                        Path to a TSV file defining qualifier priority for
                        labels (optional)
  --feature_height FEATURE_HEIGHT
                        Feature vertical width (optional; float; default: 80
                        (pixels, 96 dpi) for genomes <= 50 kb, 20 for genomes
                        >= 50 kb)
  --gc_height GC_HEIGHT
                        GC content/skew vertical width (optional; float;
                        default: 20 (pixels, 96 dpi))
  --comparison_height COMPARISON_HEIGHT
                        Comparison block height (optional; float; optional;
                        default: 60 (pixels, 96 dpi))
  --scale_style {bar,ruler}
                        Style for the length scale (default: "bar"; "bar",
                        "ruler")
  --scale_stroke_color SCALE_STROKE_COLOR
                        Scale bar/ruler stroke color (optional; str; default:
                        "black")
  --scale_stroke_width SCALE_STROKE_WIDTH
                        Scale bar/ruler stroke width (optional; float;
                        default: 3 (pt))
  --scale_font_size SCALE_FONT_SIZE
                        Scale bar/ruler font size (optional; float; default:
                        24 (pt) for genomes <= 50 kb, 16 for genomes >= 50
                        kb).
  --scale_interval SCALE_INTERVAL
                        Manual tick interval for "ruler" scale style (in bp).
                        Overrides automatic calculation; optional
  --legend_box_size LEGEND_BOX_SIZE
                        Legend box size (optional; float; default: 24 (pixels,
                        96 dpi) for genomes <= 50 kb, 20 for genomes >= 50
                        kb).
  --legend_font_size LEGEND_FONT_SIZE
                        Legend font size (optional; float; default: 20 (pt)
                        for genomes <= 50 kb, 16 for genomes >= 50 kb).
  --normalize_length    Normalize record length (experimental; default:
                        False).
```

