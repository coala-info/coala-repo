cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cressent
  - plot_tree
label: cressent_plot_tree
doc: "Plot phylogenetic trees using ggtree.\n\nTool homepage: https://github.com/ricrocha82/cressent"
inputs:
  - id: tree
    type:
      - 'null'
      - File
    doc: "Input tree file (Newick format)"
    inputBinding:
      position: 101
      prefix: --tree
  - id: dist_matrix
    type:
      - 'null'
      - File
    doc: "Use distance matrix method for tree construction"
    inputBinding:
      position: 101
      prefix: --dist_matrix
  - id: output_dir
    type: string
    doc: "Path to the output directory (created by the tool; collected as the output)"
    inputBinding:
      position: 101
      prefix: --output
  - id: metadata_1
    type:
      - 'null'
      - File
    doc: "Optional CSV metadata file"
    inputBinding:
      position: 101
      prefix: --metadata_1
  - id: metadata_2
    type:
      - 'null'
      - File
    doc: "Optional TSV name table file"
    inputBinding:
      position: 101
      prefix: --metadata_2
  - id: alignment
    type:
      - 'null'
      - File
    doc: "Optional alignment file (FASTA) to include in the plot"
    inputBinding:
      position: 101
      prefix: --alignment
  - id: layout
    type:
      - 'null'
      - string
    doc: "Tree layout (e.g., rectangular, circular, unrooted) Default: rectangular"
    inputBinding:
      position: 101
      prefix: --layout
  - id: branch_length
    type:
      - 'null'
      - string
    doc: "Branch length parameter for ggtree (Default: branch.length)"
    inputBinding:
      position: 101
      prefix: --branch_length
  - id: open_angle
    type:
      - 'null'
      - float
    doc: "Open angle for circular/unrooted layouts (default = 0)"
    inputBinding:
      position: 101
      prefix: --open_angle
  - id: offset
    type:
      - 'null'
      - float
    doc: "Tip label offset (default = 0)"
    inputBinding:
      position: 101
      prefix: --offset
  - id: tip_label
    type:
      - 'null'
      - string
    doc: "Column name to use as the tip label (default = family)"
    inputBinding:
      position: 101
      prefix: --tip_label
  - id: color
    type:
      - 'null'
      - string
    doc: "Color tree by group, True or False (requires metadata) (default = True)"
    inputBinding:
      position: 101
      prefix: --color
  - id: fig_width
    type:
      - 'null'
      - float
    doc: "Figure width (ggsave) (default = 7)"
    inputBinding:
      position: 101
      prefix: --fig_width
  - id: fig_height
    type:
      - 'null'
      - float
    doc: "Figure height (ggsave) (default = 7)"
    inputBinding:
      position: 101
      prefix: --fig_height
  - id: plot_tips
    type:
      - 'null'
      - string
    doc: "Include tip labels in the plot, True or False (default = True)"
    inputBinding:
      position: 101
      prefix: --plot_tips
  - id: plot_name
    type:
      - 'null'
      - string
    doc: "Name of the output plot file (default: tree_plot.pdf)"
    inputBinding:
      position: 101
      prefix: --plot_name
outputs:
  - id: output
    type: Directory
    doc: Output directory with all result files
    outputBinding:
      glob: $(inputs.output_dir)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cressent:1.0.2--pyhdfd78af_0
