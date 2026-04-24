cwlVersion: v1.2
class: CommandLineTool
baseCommand: gbdraw
label: gbdraw_circular
doc: "Generate genome diagrams in PNG/PDF/SVG/PS/EPS. Diagrams for multiple entries
  are saved separately.\n\nTool homepage: https://github.com/satoshikawato/gbdraw"
inputs:
  - id: allow_inner_labels
    type:
      - 'null'
      - boolean
    doc: 'Place labels inside the circle (default: False). If enabled, labels are
      placed both inside and outside the circle, and gc and skew tracks are not shown.'
    inputBinding:
      position: 101
      prefix: --allow_inner_labels
  - id: axis_stroke_color
    type:
      - 'null'
      - string
    doc: 'Axis stroke color (str; default: "gray")'
    inputBinding:
      position: 101
      prefix: --axis_stroke_color
  - id: axis_stroke_width
    type:
      - 'null'
      - string
    doc: 'Axis stroke width (optional; float; default: 3 pt for genomes <= 50 kb,
      1 pt for genomes >= 50 kb)'
    inputBinding:
      position: 101
      prefix: --axis_stroke_width
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
      - string
    doc: 'Block stroke width (optional; float; default: 2 pt for genomes <= 50 kb,
      0 pt for genomes >= 50 kb)'
    inputBinding:
      position: 101
      prefix: --block_stroke_width
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
      - string
    doc: 'Definition font size (optional; default: 18)'
    inputBinding:
      position: 101
      prefix: --definition_font_size
  - id: fasta_files
    type:
      - 'null'
      - type: array
        items: File
    doc: FASTA file (required with --gff)
    inputBinding:
      position: 101
      prefix: --fasta
  - id: features
    type:
      - 'null'
      - string
    doc: 'Comma-separated list of feature keys to draw (default: CDS,rRNA,tRNA,tmRNA,ncRNA,misc_RNA,repeat_region)'
    inputBinding:
      position: 101
      prefix: --features
  - id: format
    type:
      - 'null'
      - string
    doc: 'Comma-separated list of output file formats (svg, png, pdf, eps, ps; default:
      svg).'
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
  - id: gff3_files
    type:
      - 'null'
      - type: array
        items: File
    doc: GFF3 file (instead of --gbk; --fasta is required)
    inputBinding:
      position: 101
      prefix: --gff
  - id: inner_label_x_radius_offset
    type:
      - 'null'
      - float
    doc: Inner label x-radius offset factor (float; default from config)
    inputBinding:
      position: 101
      prefix: --inner_label_x_radius_offset
  - id: inner_label_y_radius_offset
    type:
      - 'null'
      - float
    doc: Inner label y-radius offset factor (float; default from config)
    inputBinding:
      position: 101
      prefix: --inner_label_y_radius_offset
  - id: label_blacklist
    type:
      - 'null'
      - string
    doc: Comma-separated keywords or path to a file for label blacklisting 
      (optional); mutually exclusive with --label_whitelist
    inputBinding:
      position: 101
      prefix: --label_blacklist
  - id: label_font_size
    type:
      - 'null'
      - string
    doc: 'Label font size (optional; default: 14 (pt) for genomes <= 50 kb, 8 for
      genomes >= 50 kb)'
    inputBinding:
      position: 101
      prefix: --label_font_size
  - id: label_whitelist
    type:
      - 'null'
      - File
    doc: path to a file for label whitelisting (optional); mutually exclusive 
      with --label_blacklist
    inputBinding:
      position: 101
      prefix: --label_whitelist
  - id: legend
    type:
      - 'null'
      - string
    doc: 'Legend position (default: "right"; "left", "right", "upper_left", "upper_right",
      "lower_left", "lower_right", "none")'
    inputBinding:
      position: 101
      prefix: --legend
  - id: legend_box_size
    type:
      - 'null'
      - string
    doc: 'Legend box size (optional; float; default: 24 (pixels, 96 dpi) for genomes
      <= 50 kb, 20 for genomes >= 50 kb).'
    inputBinding:
      position: 101
      prefix: --legend_box_size
  - id: legend_font_size
    type:
      - 'null'
      - string
    doc: 'Legend font size (optional; float; default: 20 (pt) for genomes <= 50 kb,
      16 for genomes >= 50 kb).'
    inputBinding:
      position: 101
      prefix: --legend_font_size
  - id: line_stroke_color
    type:
      - 'null'
      - string
    doc: 'Line stroke color (str; default: "gray")'
    inputBinding:
      position: 101
      prefix: --line_stroke_color
  - id: line_stroke_width
    type:
      - 'null'
      - string
    doc: 'Line stroke width (optional; float; default: 5 pt for genomes <= 50 kb,
      1 pt for genomes >= 50 kb)'
    inputBinding:
      position: 101
      prefix: --line_stroke_width
  - id: nt
    type:
      - 'null'
      - string
    doc: 'dinucleotide (default: GC).'
    inputBinding:
      position: 101
      prefix: --nt
  - id: outer_label_x_radius_offset
    type:
      - 'null'
      - float
    doc: Outer label x-radius offset factor (float; default from config)
    inputBinding:
      position: 101
      prefix: --outer_label_x_radius_offset
  - id: outer_label_y_radius_offset
    type:
      - 'null'
      - float
    doc: Outer label y-radius offset factor (float; default from config)
    inputBinding:
      position: 101
      prefix: --outer_label_y_radius_offset
  - id: output
    type:
      - 'null'
      - string
    doc: 'output file prefix (default: accession number of the sequence)'
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
      - File
    doc: Path to a TSV file defining qualifier priority for labels (optional)
    inputBinding:
      position: 101
      prefix: --qualifier_priority
  - id: scale_interval
    type:
      - 'null'
      - string
    doc: Manual scale interval for circular mode (in bp). Overrides automatic 
      calculation.
    inputBinding:
      position: 101
      prefix: --scale_interval
  - id: separate_strands
    type:
      - 'null'
      - boolean
    doc: 'Separate strands (default: False).'
    inputBinding:
      position: 101
      prefix: --separate_strands
  - id: show_labels
    type:
      - 'null'
      - boolean
    doc: 'Show feature labels (default: False).'
    inputBinding:
      position: 101
      prefix: --show_labels
  - id: species
    type:
      - 'null'
      - string
    doc: Species name (optional; e.g. "<i>Escherichia coli</i>", "<i>Ca.</i> 
      Hepatoplasma crinochetorum")
    inputBinding:
      position: 101
      prefix: --species
  - id: step
    type:
      - 'null'
      - string
    doc: 'step size (optional; default: 100 bp for genomes < 1Mb, 1kb for genomes
      <10Mb, 10kb for genomes >=10Mb)'
    inputBinding:
      position: 101
      prefix: --step
  - id: strain
    type:
      - 'null'
      - string
    doc: Strain/isolate name (optional; e.g. "K-12", "Av")
    inputBinding:
      position: 101
      prefix: --strain
  - id: suppress_gc
    type:
      - 'null'
      - boolean
    doc: 'Suppress GC content track (default: False).'
    inputBinding:
      position: 101
      prefix: --suppress_gc
  - id: suppress_skew
    type:
      - 'null'
      - boolean
    doc: 'Suppress GC skew track (default: False).'
    inputBinding:
      position: 101
      prefix: --suppress_skew
  - id: table
    type:
      - 'null'
      - string
    doc: color table (optional)
    inputBinding:
      position: 101
      prefix: --table
  - id: track_type
    type:
      - 'null'
      - string
    doc: 'Track type (default: "tuckin"; "tuckin", "middle", "spreadout")'
    inputBinding:
      position: 101
      prefix: --track_type
  - id: window
    type:
      - 'null'
      - string
    doc: 'window size (optional; default: 1kb for genomes < 1Mb, 10kb for genomes
      <10Mb, 100kb for genomes >=10Mb)'
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
stdout: gbdraw_circular.out
