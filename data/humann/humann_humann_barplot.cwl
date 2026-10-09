cwlVersion: v1.2
class: CommandLineTool
baseCommand: humann_barplot
label: humann_humann_barplot
doc: "HUMAnN utility for plotting a single stratified feature. Plots the taxon-stratified contributions of a specified function.\n\nTool homepage: http://huttenhower.sph.harvard.edu/humann"
inputs:
  - id: input
    type:
      - 'null'
      - File
    doc: "HUMAnN table (.tsv or .biom format)"
    inputBinding:
      position: 101
      prefix: "--input"
  - id: last_metadata
    type:
      - 'null'
      - string
    doc: "The name (header) of the last row containing metadata, if any"
    inputBinding:
      position: 102
      prefix: "--last-metadata"
  - id: focal_feature
    type: string
    doc: "Feature ID of interest (give ID not full name)"
    inputBinding:
      position: 103
      prefix: "--focal-feature"
  - id: output_path
    type:
      - 'null'
      - string
    doc: "Where and how to save the figure (default humann_barplot.png)"
    inputBinding:
      position: 104
      prefix: "--output"
  - id: top_taxa
    type:
      - 'null'
      - int
    doc: "Max taxon stratifications (by grand mean) to highlight [18]"
    inputBinding:
      position: 105
      prefix: "--top-taxa"
  - id: as_genera
    type:
      - 'null'
      - boolean
    doc: "Collapse species to genera"
    inputBinding:
      position: 106
      prefix: "--as-genera"
  - id: exclude_unclassified
    type:
      - 'null'
      - boolean
    doc: "Do not include the 'unclassified' taxon"
    inputBinding:
      position: 107
      prefix: "--exclude-unclassified"
  - id: remove_zeros
    type:
      - 'null'
      - boolean
    doc: "Do not analyze samples with zero sum for this feature"
    inputBinding:
      position: 108
      prefix: "--remove-zeros"
  - id: sort
    type:
      - 'null'
      - type: array
        items: string
    doc: "Sample sorting methods (can use more than one; evaluated in order): none, sum, dominant, braycurtis, braycurtis_w, metadata, file"
    inputBinding:
      position: 109
      prefix: "--sort"
  - id: taxa_colormap
    type:
      - 'null'
      - string
    doc: "Color space for taxa: a named colormap or a colormap file [automatic]"
    inputBinding:
      position: 110
      prefix: "--taxa-colormap"
  - id: write_taxa_colors
    type:
      - 'null'
      - string
    doc: "Write taxa colors to a file for cross-plot consistency"
    inputBinding:
      position: 111
      prefix: "--write-taxa-colors"
  - id: focal_metadata
    type:
      - 'null'
      - string
    doc: "Indicate metadata to highlight / group by"
    inputBinding:
      position: 112
      prefix: "--focal-metadata"
  - id: max_metalevels
    type:
      - 'null'
      - int
    doc: "Keep the most frequent metadata levels and collapse others [7]"
    inputBinding:
      position: 113
      prefix: "--max-metalevels"
  - id: meta_colormap
    type:
      - 'null'
      - string
    doc: "Color space for metadata levels: a named colormap or a colormap file [automatic]"
    inputBinding:
      position: 114
      prefix: "--meta-colormap"
  - id: scaling
    type:
      - 'null'
      - string
    doc: "Scaling options for total bar heights: original, logstack or totalsum"
    inputBinding:
      position: 115
      prefix: "--scaling"
  - id: ylims
    type:
      - 'null'
      - type: array
        items: float
    doc: "Fix limits for y-axis: two numbers (lower, upper)"
    inputBinding:
      position: 116
      prefix: "--ylims"
  - id: no_grid
    type:
      - 'null'
      - boolean
    doc: "Don't plot y-axis grid lines"
    inputBinding:
      position: 117
      prefix: "--no-grid"
  - id: dimensions
    type:
      - 'null'
      - type: array
        items: float
    doc: "Image width and height in inches: two numbers [11 6]"
    inputBinding:
      position: 118
      prefix: "--dimensions"
  - id: units
    type:
      - 'null'
      - string
    doc: "Name for y-axis abundance units [generic]"
    inputBinding:
      position: 119
      prefix: "--units"
  - id: legend_cols
    type:
      - 'null'
      - int
    doc: "Number of legend columns [3]"
    inputBinding:
      position: 120
      prefix: "--legend-cols"
  - id: legend_rows
    type:
      - 'null'
      - int
    doc: "Number of legend rows [10]"
    inputBinding:
      position: 121
      prefix: "--legend-rows"
  - id: legend_height
    type:
      - 'null'
      - float
    doc: "Ratio of legend to data axis height [1.0]"
    inputBinding:
      position: 122
      prefix: "--legend-height"
  - id: sample_order
    type:
      - 'null'
      - File
    doc: "Read sample order from this file"
    inputBinding:
      position: 123
      prefix: "--sample-order"
  - id: write_sample_order
    type:
      - 'null'
      - string
    doc: "Write sample order to this file"
    inputBinding:
      position: 124
      prefix: "--write-sample-order"
outputs:
  - id: figure
    type: File
    doc: "the barplot figure"
    outputBinding:
      glob: "$(inputs.output_path ? inputs.output_path : 'humann_barplot.png')"
  - id: sample_order_file
    type:
      - 'null'
      - File
    doc: "sample order file"
    outputBinding:
      glob: '$(inputs.write_sample_order)'
  - id: taxa_colors_file
    type:
      - 'null'
      - File
    doc: "taxa colors file"
    outputBinding:
      glob: '$(inputs.write_taxa_colors)'
requirements:
  - class: InlineJavascriptRequirement
  - class: EnvVarRequirement
    envDef:
      - envName: MPLCONFIGDIR
        envValue: $(runtime.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/humann:3.9--py312hdfd78af_0
