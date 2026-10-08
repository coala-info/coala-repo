cwlVersion: v1.2
class: CommandLineTool
baseCommand: plot_gubbins.R
label: gubbins_plot_gubbins
doc: "Produce publication-ready figures of Gubbins analyses\n\nTool homepage: https://github.com/nickjcroucher/gubbins"
inputs:
  - id: no_heatmap
    type:
      - 'null'
      - boolean
    doc: "Do not plot recombination heatmap"
    inputBinding:
      position: 101
      prefix: --no-heatmap
  - id: show_taxa
    type:
      - 'null'
      - boolean
    doc: "Show taxa names on tree"
    inputBinding:
      position: 102
      prefix: --show-taxa
  - id: annotation_labels
    type:
      - 'null'
      - boolean
    doc: "Show GFF gene names on annotation"
    inputBinding:
      position: 103
      prefix: --annotation-labels
  - id: opts
    type:
      - 'null'
      - File
    doc: "RDS file containing argument values"
    inputBinding:
      position: 104
      prefix: --opts
  - id: tree
    type:
      - 'null'
      - File
    doc: "Gubbins tree (Newick file)"
    inputBinding:
      position: 105
      prefix: --tree
  - id: rec
    type:
      - 'null'
      - File
    doc: "Gubbins recombination inference (GFF file)"
    inputBinding:
      position: 106
      prefix: --rec
  - id: annotation
    type:
      - 'null'
      - File
    doc: "Reference genome annotation (GFF file)"
    inputBinding:
      position: 107
      prefix: --annotation
  - id: markup
    type:
      - 'null'
      - File
    doc: "Genome loci to mark (CSV file; columns are 'start','end','label')"
    inputBinding:
      position: 108
      prefix: --markup
  - id: meta
    type:
      - 'null'
      - File
    doc: "Metadata for each sequence (CSV file; first column is 'id')"
    inputBinding:
      position: 109
      prefix: --meta
  - id: clades
    type:
      - 'null'
      - File
    doc: "Assignment of taxa to clades (CSV file; columns are 'id','clade')"
    inputBinding:
      position: 110
      prefix: --clades
  - id: output
    type:
      - 'null'
      - string
    doc: "Output file name (PNG or PDF suffix)"
    inputBinding:
      position: 111
      prefix: --output
  - id: tree_width
    type:
      - 'null'
      - float
    doc: "Width of tree relative to recombination panel"
    inputBinding:
      position: 112
      prefix: --tree-width
  - id: meta_width
    type:
      - 'null'
      - float
    doc: "Width of metadata panel relative to recombination panel"
    inputBinding:
      position: 113
      prefix: --meta-width
  - id: annotation_height
    type:
      - 'null'
      - float
    doc: "Height of annotation panel relative to recombination panel"
    inputBinding:
      position: 114
      prefix: --annotation-height
  - id: markup_height
    type:
      - 'null'
      - float
    doc: "Height of markup panel relative to recombination panel"
    inputBinding:
      position: 115
      prefix: --markup-height
  - id: heatmap_height
    type:
      - 'null'
      - float
    doc: "Height of heatmap relative to recombination panel"
    inputBinding:
      position: 116
      prefix: --heatmap-height
  - id: legend_height
    type:
      - 'null'
      - float
    doc: "Height of legends relative to recombination panel"
    inputBinding:
      position: 117
      prefix: --legend-height
  - id: start_coordinate
    type:
      - 'null'
      - int
    doc: "Left boundary of genomic region to plot"
    inputBinding:
      position: 118
      prefix: --start-coordinate
  - id: end_coordinate
    type:
      - 'null'
      - int
    doc: "Right boundary of genomic region to plot"
    inputBinding:
      position: 119
      prefix: --end-coordinate
  - id: heatmap_y_nudge
    type:
      - 'null'
      - float
    doc: "Size of metadata labels"
    inputBinding:
      position: 120
      prefix: --heatmap-y-nudge
  - id: heatmap_x_nudge
    type:
      - 'null'
      - float
    doc: "Size of metadata labels"
    inputBinding:
      position: 121
      prefix: --heatmap-x-nudge
  - id: legend_direction
    type:
      - 'null'
      - string
    doc: "Orientation of legends (horizontal or vertical)"
    inputBinding:
      position: 122
      prefix: --legend-direction
  - id: taxon_label_size
    type:
      - 'null'
      - float
    doc: "Size of taxon labels"
    inputBinding:
      position: 123
      prefix: --taxon-label-size
  - id: meta_label_size
    type:
      - 'null'
      - float
    doc: "Size of metadata labels"
    inputBinding:
      position: 124
      prefix: --meta-label-size
  - id: max_branch_length
    type:
      - 'null'
      - float
    doc: "Maximum length at which to truncate branches"
    inputBinding:
      position: 125
      prefix: --max-branch-length
  - id: branch_width
    type:
      - 'null'
      - float
    doc: "Width of branches on tree plot"
    inputBinding:
      position: 126
      prefix: --branch-width
  - id: tree_axis_expansion
    type:
      - 'null'
      - float
    doc: "Space between tree and right panel"
    inputBinding:
      position: 127
      prefix: --tree-axis-expansion
  - id: output_height
    type:
      - 'null'
      - float
    doc: "Height of output file (inches)"
    inputBinding:
      position: 128
      prefix: --output-height
  - id: output_width
    type:
      - 'null'
      - float
    doc: "Width of output file (inches)"
    inputBinding:
      position: 129
      prefix: --output-width
outputs:
  - id: plot
    type:
      - 'null'
      - File
    doc: "Output figure (PNG or PDF)"
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gubbins:3.4.3--py39h746d604_0
