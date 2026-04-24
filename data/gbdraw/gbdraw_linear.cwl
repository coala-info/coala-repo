cwlVersion: v1.2
class: CommandLineTool
baseCommand: gbdraw
label: gbdraw_linear
doc: "Generate plot in PNG/PDF/SVG/PS/EPS.\n\nTool homepage: https://github.com/satoshikawato/gbdraw"
inputs:
  - id: align_center
    type:
      - 'null'
      - boolean
    doc: 'Align genomes to the center (default: False).'
    inputBinding:
      position: 101
      prefix: --align_center
  - id: axis_stroke_color
    type:
      - 'null'
      - string
    doc: 'Axis stroke color (str; default: "lightgray")'
    inputBinding:
      position: 101
      prefix: --axis_stroke_color
  - id: axis_stroke_width
    type:
      - 'null'
      - float
    doc: "Axis stroke width (optional; float; default: 5 pt for\n                \
      \        genomes <= 50 kb, 2 pt for genomes >= 50 kb)"
    inputBinding:
      position: 101
      prefix: --axis_stroke_width
  - id: bitscore
    type:
      - 'null'
      - int
    doc: bitscore threshold (default=50)
    inputBinding:
      position: 101
      prefix: --bitscore
  - id: blast_files
    type:
      - 'null'
      - type: array
        items: File
    doc: "input BLAST result file in tab-separated format\n                      \
      \  (-outfmt 6 or 7) (optional)"
    inputBinding:
      position: 101
      prefix: --blast
  - id: block_stroke_color
    type:
      - 'null'
      - string
    doc: 'Block stroke color (str; default: "gray")'
    inputBinding:
      position: 101
      prefix: --block_stroke_color
  - id: block_stroke_width
    type:
      - 'null'
      - float
    doc: "Block stroke width (optional; float; default: 2 pt for\n               \
      \         genomes <= 50 kb, 0 pt for genomes >= 50 kb)"
    inputBinding:
      position: 101
      prefix: --block_stroke_width
  - id: comparison_height
    type:
      - 'null'
      - float
    doc: "Comparison block height (optional; float; optional;\n                  \
      \      default: 60 (pixels, 96 dpi))"
    inputBinding:
      position: 101
      prefix: --comparison_height
  - id: default_colors
    type:
      - 'null'
      - string
    doc: TSV file that overrides the color palette (optional)
    inputBinding:
      position: 101
      prefix: --default_colors
  - id: definition_font_size
    type:
      - 'null'
      - float
    doc: "Definition font size (optional; float; default: 24 pt\n                \
      \        for genomes <= 50 kb, 10 pt for genomes >= 50 kb)"
    inputBinding:
      position: 101
      prefix: --definition_font_size
  - id: evalue
    type:
      - 'null'
      - float
    doc: evalue threshold (default=1e-2)
    inputBinding:
      position: 101
      prefix: --evalue
  - id: fasta_files
    type:
      - 'null'
      - type: array
        items: File
    doc: FASTA file (required with --gff)
    inputBinding:
      position: 101
      prefix: --fasta
  - id: feature_height
    type:
      - 'null'
      - float
    doc: "Feature vertical width (optional; float; default: 80\n                 \
      \       (pixels, 96 dpi) for genomes <= 50 kb, 20 for genomes\n            \
      \            >= 50 kb)"
    inputBinding:
      position: 101
      prefix: --feature_height
  - id: features
    type:
      - 'null'
      - string
    doc: "Comma-separated list of feature keys to draw (default:\n               \
      \         CDS,rRNA,tRNA,tmRNA,ncRNA,misc_RNA,repeat_region)"
    inputBinding:
      position: 101
      prefix: --features
  - id: format
    type:
      - 'null'
      - string
    doc: "Comma-separated list of output file formats (svg, png,\n               \
      \         pdf, eps, ps; default: svg)."
    inputBinding:
      position: 101
      prefix: --format
  - id: gbk_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Genbank/DDBJ flatfile
    inputBinding:
      position: 101
      prefix: --gbk
  - id: gc_height
    type:
      - 'null'
      - float
    doc: "GC content/skew vertical width (optional; float;\n                     \
      \   default: 20 (pixels, 96 dpi))"
    inputBinding:
      position: 101
      prefix: --gc_height
  - id: gff3_files
    type:
      - 'null'
      - type: array
        items: File
    doc: GFF3 file (instead of --gbk; --fasta is required)
    inputBinding:
      position: 101
      prefix: --gff
  - id: identity
    type:
      - 'null'
      - int
    doc: identity threshold (default=0)
    inputBinding:
      position: 101
      prefix: --identity
  - id: label_blacklist
    type:
      - 'null'
      - string
    doc: "Comma-separated keywords or path to a file for label\n                 \
      \       blacklisting (optional); mutually exclusive with\n                 \
      \       --label_whitelist"
    inputBinding:
      position: 101
      prefix: --label_blacklist
  - id: label_font_size
    type:
      - 'null'
      - string
    doc: "Label font size (optional; default: 24 pt for genomes\n                \
      \        <= 50 kb, 5 pt for genomes >= 50 kb)"
    inputBinding:
      position: 101
      prefix: --label_font_size
  - id: label_whitelist
    type:
      - 'null'
      - File
    doc: "path to a file for label whitelisting (optional);\n                    \
      \    mutually exclusive with --label_blacklist"
    inputBinding:
      position: 101
      prefix: --label_whitelist
  - id: legend
    type:
      - 'null'
      - string
    doc: "Legend position (default: \"right\"; \"right\", \"left\",\n            \
      \            \"top\", \"bottom\", \"none\")"
    inputBinding:
      position: 101
      prefix: --legend
  - id: legend_box_size
    type:
      - 'null'
      - string
    doc: "Legend box size (optional; float; default: 24 (pixels,\n               \
      \         96 dpi) for genomes <= 50 kb, 20 for genomes >= 50\n             \
      \           kb)."
    inputBinding:
      position: 101
      prefix: --legend_box_size
  - id: legend_font_size
    type:
      - 'null'
      - string
    doc: "Legend font size (optional; float; default: 20 (pt)\n                  \
      \      for genomes <= 50 kb, 16 for genomes >= 50 kb)."
    inputBinding:
      position: 101
      prefix: --legend_font_size
  - id: line_stroke_color
    type:
      - 'null'
      - string
    doc: "Line stroke color (optional; str; default:\n                        \"lightgray\"\
      )"
    inputBinding:
      position: 101
      prefix: --line_stroke_color
  - id: line_stroke_width
    type:
      - 'null'
      - float
    doc: "Line stroke width (optional; float; default: 5 pt for\n                \
      \        genomes <= 50 kb, 1 pt for genomes >= 50 kb)"
    inputBinding:
      position: 101
      prefix: --line_stroke_width
  - id: normalize_length
    type:
      - 'null'
      - boolean
    doc: "Normalize record length (experimental; default:\n                      \
      \  False)."
    inputBinding:
      position: 101
      prefix: --normalize_length
  - id: nt
    type:
      - 'null'
      - string
    doc: 'dinucleotide skew (default: GC).'
    inputBinding:
      position: 101
      prefix: --nt
  - id: output
    type:
      - 'null'
      - string
    doc: 'output file prefix (default: out)'
    inputBinding:
      position: 101
      prefix: --output
  - id: palette
    type:
      - 'null'
      - string
    doc: 'Palette name (default: default)'
    inputBinding:
      position: 101
      prefix: --palette
  - id: qualifier_priority
    type:
      - 'null'
      - string
    doc: "Path to a TSV file defining qualifier priority for\n                   \
      \     labels (optional)"
    inputBinding:
      position: 101
      prefix: --qualifier_priority
  - id: resolve_overlaps
    type:
      - 'null'
      - boolean
    doc: 'Resolve overlaps (experimental; default: False).'
    inputBinding:
      position: 101
      prefix: --resolve_overlaps
  - id: scale_font_size
    type:
      - 'null'
      - string
    doc: "Scale bar/ruler font size (optional; float; default:\n                 \
      \       24 (pt) for genomes <= 50 kb, 16 for genomes >= 50\n               \
      \         kb)."
    inputBinding:
      position: 101
      prefix: --scale_font_size
  - id: scale_interval
    type:
      - 'null'
      - int
    doc: "Manual tick interval for \"ruler\" scale style (in bp).\n              \
      \          Overrides automatic calculation; optional"
    inputBinding:
      position: 101
      prefix: --scale_interval
  - id: scale_stroke_color
    type:
      - 'null'
      - string
    doc: "Scale bar/ruler stroke color (optional; str; default:\n                \
      \        \"black\")"
    inputBinding:
      position: 101
      prefix: --scale_stroke_color
  - id: scale_stroke_width
    type:
      - 'null'
      - float
    doc: "Scale bar/ruler stroke width (optional; float;\n                       \
      \ default: 3 (pt))"
    inputBinding:
      position: 101
      prefix: --scale_stroke_width
  - id: scale_style
    type:
      - 'null'
      - string
    doc: "Style for the length scale (default: \"bar\"; \"bar\",\n               \
      \         \"ruler\")"
    inputBinding:
      position: 101
      prefix: --scale_style
  - id: separate_strands
    type:
      - 'null'
      - boolean
    doc: "separate forward and reverse strands (default: False).\n               \
      \         Features of undefined strands are shown on the forward\n         \
      \               strand."
    inputBinding:
      position: 101
      prefix: --separate_strands
  - id: show_gc
    type:
      - 'null'
      - boolean
    doc: 'plot GC content below genome (default: False).'
    inputBinding:
      position: 101
      prefix: --show_gc
  - id: show_labels
    type:
      - 'null'
      - string
    doc: "Show labels: no argument or 'all' (all records),\n                     \
      \   'first' (first record only), 'none' (no labels).\n                     \
      \   Default: 'none'"
    inputBinding:
      position: 101
      prefix: --show_labels
  - id: show_skew
    type:
      - 'null'
      - boolean
    doc: 'plot GC skew below genome (default: False).'
    inputBinding:
      position: 101
      prefix: --show_skew
  - id: step
    type:
      - 'null'
      - string
    doc: "step size (optional; default: 100 bp for genomes <\n                   \
      \     1Mb, 1kb for genomes <10Mb, 10kb for genomes >=10Mb)"
    inputBinding:
      position: 101
      prefix: --step
  - id: table
    type:
      - 'null'
      - string
    doc: color table (optional)
    inputBinding:
      position: 101
      prefix: --table
  - id: window
    type:
      - 'null'
      - string
    doc: "window size (optional; default: 1kb for genomes < 1Mb,\n               \
      \         10kb for genomes <10Mb, 100kb for genomes >=10Mb)"
    inputBinding:
      position: 101
      prefix: --window
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gbdraw:0.8.0--pyhdfd78af_0
stdout: gbdraw_linear.out
