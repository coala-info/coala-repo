cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pangwas
  - heatmap
label: pangwas_heatmap
doc: "Plot a heatmap of variants alongside a tree.\n\nTakes as input a table of variants
  and/or a newick tree. The table can be either\nan Rtab file, or the locus effects
  TSV output from the gwas subcommand.\nIf both a tree and a table are provided, the
  tree will determine the sample order \nand arrangement. If just a table is provided,
  sample order will follow the \norder of the sample columns. A TXT of focal sample
  IDs can also be supplied\nwith one sample ID per line. Outputs a plot in SVG and
  PNG format.\n\nTool homepage: https://github.com/phac-nml/pangwas"
inputs:
  - id: focal
    type:
      - 'null'
      - File
    doc: TXT file of focal samples.
    inputBinding:
      position: 101
      prefix: --focal
  - id: font_family
    type:
      - 'null'
      - string
    doc: Font family of the tree labels.
    default: Roboto
    inputBinding:
      position: 101
      prefix: --font-family
  - id: font_size
    type:
      - 'null'
      - int
    doc: Font size of the tree labels.
    default: 16
    inputBinding:
      position: 101
      prefix: --font-size
  - id: gwas
    type:
      - 'null'
      - File
    doc: TSV table of variants from gwas subcommand.
    inputBinding:
      position: 101
      prefix: --gwas
  - id: heatmap_scale
    type:
      - 'null'
      - float
    doc: Scaling factor of heatmap boxes relative to the text.
    default: 1.5
    inputBinding:
      position: 101
      prefix: --heatmap-scale
  - id: margin
    type:
      - 'null'
      - int
    doc: Margin sizes in pixels.
    default: 20
    inputBinding:
      position: 101
      prefix: --margin
  - id: min_score
    type:
      - 'null'
      - float
    doc: 'Filter GWAS variants by a minimum score (range: -1.0 to 1.0).'
    inputBinding:
      position: 101
      prefix: --min-score
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Output directory.
    default: .
    inputBinding:
      position: 101
      prefix: --outdir
  - id: png_scale
    type:
      - 'null'
      - float
    doc: Scaling factor of the PNG file.
    default: 2.0
    inputBinding:
      position: 101
      prefix: --png-scale
  - id: prefix
    type:
      - 'null'
      - string
    doc: Prefix for output files.
    inputBinding:
      position: 101
      prefix: --prefix
  - id: root_branch
    type:
      - 'null'
      - int
    doc: Root branch length in pixels.
    default: 10
    inputBinding:
      position: 101
      prefix: --root-branch
  - id: rtab
    type:
      - 'null'
      - File
    doc: Rtab table of variants.
    inputBinding:
      position: 101
      prefix: --rtab
  - id: tip_pad
    type:
      - 'null'
      - int
    doc: Tip padding.
    default: 10
    inputBinding:
      position: 101
      prefix: --tip-pad
  - id: tree
    type:
      - 'null'
      - File
    doc: Tree file.
    inputBinding:
      position: 101
      prefix: --tree
  - id: tree_format
    type:
      - 'null'
      - string
    doc: Tree format.
    default: newick
    inputBinding:
      position: 101
      prefix: --tree-format
  - id: tree_width
    type:
      - 'null'
      - int
    doc: Width of the tree in pixels.
    default: 200
    inputBinding:
      position: 101
      prefix: --tree-width
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pangwas:0.1.0--pyh7e72e81_0
stdout: pangwas_heatmap.out
