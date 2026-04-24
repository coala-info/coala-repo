cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phylorank
  - outliers
label: phylorank_outliers
doc: "Create information for identifying taxonomic outliers\n\nTool homepage: https://github.com/dparks1134/PhyloRank"
inputs:
  - id: input_tree
    type: File
    doc: decorated tree for inferring RED outliers
    inputBinding:
      position: 1
  - id: taxonomy_file
    type: File
    doc: taxonomy file for inferring RED outliers
    inputBinding:
      position: 2
  - id: dpi
    type:
      - 'null'
      - int
    doc: DPI of plots
    inputBinding:
      position: 103
      prefix: --dpi
  - id: fixed_root
    type:
      - 'null'
      - boolean
    doc: use single fixed root to infer outliers
    inputBinding:
      position: 103
      prefix: --fixed_root
  - id: fmeasure_mono
    type:
      - 'null'
      - float
    doc: minimum F-measure to consider taxa monophyletic
    inputBinding:
      position: 103
      prefix: --fmeasure_mono
  - id: fmeasure_table
    type:
      - 'null'
      - File
    doc: table indicating F-measure score for each taxa
    inputBinding:
      position: 103
      prefix: --fmeasure_table
  - id: highlight_polyphyly
    type:
      - 'null'
      - boolean
    doc: highlight taxa with an F-measure less than --fmeasure_mono
    inputBinding:
      position: 103
      prefix: --highlight_polyphyly
  - id: highlight_taxa_file
    type:
      - 'null'
      - File
    doc: file indicating taxa to highlight
    inputBinding:
      position: 103
      prefix: --highlight_taxa_file
  - id: mblet
    type:
      - 'null'
      - boolean
    doc: calculate 'mean branch length to extent taxa' instead of 'relative evolutionary
      distances'
    inputBinding:
      position: 103
      prefix: --mblet
  - id: min_children
    type:
      - 'null'
      - int
    doc: minimum required child taxa to consider taxa when inferring distribution
    inputBinding:
      position: 103
      prefix: --min_children
  - id: min_fmeasure
    type:
      - 'null'
      - float
    doc: minimum F-measure to consider taxa when inferring distribution
    inputBinding:
      position: 103
      prefix: --min_fmeasure
  - id: min_support
    type:
      - 'null'
      - float
    doc: minimum support value to consider taxa when inferring distribution
    inputBinding:
      position: 103
      prefix: --min_support
  - id: plot_dist_taxa_only
    type:
      - 'null'
      - boolean
    doc: only plot taxa used to infer distribution
    inputBinding:
      position: 103
      prefix: --plot_dist_taxa_only
  - id: plot_domain
    type:
      - 'null'
      - boolean
    doc: show domain rank in plot
    inputBinding:
      position: 103
      prefix: --plot_domain
  - id: plot_taxa_file
    type:
      - 'null'
      - File
    doc: 'file indicating taxonomic groups to plot (default: all taxa)'
    inputBinding:
      position: 103
      prefix: --plot_taxa_file
  - id: skip_mpld3
    type:
      - 'null'
      - boolean
    doc: skip plots requiring mpld3
    inputBinding:
      position: 103
      prefix: --skip_mpld3
  - id: trusted_taxa_file
    type:
      - 'null'
      - File
    doc: 'file indicating trusted taxonomic groups to use for inferring distribution
      (default: all taxa)'
    inputBinding:
      position: 103
      prefix: --trusted_taxa_file
  - id: verbose_table
    type:
      - 'null'
      - boolean
    doc: add additional columns to output table
    inputBinding:
      position: 103
      prefix: --verbose_table
  - id: viral
    type:
      - 'null'
      - boolean
    doc: indicates a viral input tree and taxonomy
    inputBinding:
      position: 103
      prefix: --viral
outputs:
  - id: output_dir
    type: Directory
    doc: desired output directory for generated files
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phylorank:0.1.12--pyhdfd78af_0
