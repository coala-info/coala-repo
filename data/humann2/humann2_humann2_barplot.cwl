cwlVersion: v1.2
class: CommandLineTool
baseCommand: humann2_barplot
label: humann2_humann2_barplot
doc: "HUMAnN2 plotting tool\n\nTool homepage: http://huttenhower.sph.harvard.edu/humann2"
inputs:
  - id: input
    type: File
    doc: "HUMAnN2 table with optional metadata"
    inputBinding:
      position: 101
      prefix: "--input"
  - id: focal_feature
    type:
      - 'null'
      - string
    doc: "Feature ID of interest (give ID not full name)"
    inputBinding:
      position: 102
      prefix: "--focal-feature"
  - id: top_strata
    type:
      - 'null'
      - int
    doc: "Number of top stratifications to highlight (top = highest grand means)"
    inputBinding:
      position: 103
      prefix: "--top-strata"
  - id: sort
    type:
      - 'null'
      - type: array
        items: string
    doc: "Sample sorting methods (can use more than one; evaluated in order): none, sum, dominant, similarity, usimilarity, metadata"
    inputBinding:
      position: 104
      prefix: "--sort"
  - id: last_metadatum
    type:
      - 'null'
      - string
    doc: "Indicate end of metadata rows"
    inputBinding:
      position: 105
      prefix: "--last-metadatum"
  - id: focal_metadatum
    type:
      - 'null'
      - string
    doc: "Indicate metadatum to highlight / group by"
    inputBinding:
      position: 106
      prefix: "--focal-metadatum"
  - id: colormap
    type:
      - 'null'
      - string
    doc: "Color space for stratifications"
    inputBinding:
      position: 107
      prefix: "--colormap"
  - id: meta_colormap
    type:
      - 'null'
      - string
    doc: "Color space for metadata levels"
    inputBinding:
      position: 108
      prefix: "--meta-colormap"
  - id: exclude_unclassified
    type:
      - 'null'
      - boolean
    doc: "Do not include the 'unclassified' stratum"
    inputBinding:
      position: 109
      prefix: "--exclude-unclassified"
  - id: output_path
    type: string
    doc: "Where to save the figure (file.ext)"
    inputBinding:
      position: 110
      prefix: "--output"
  - id: scaling
    type:
      - 'null'
      - string
    doc: "Scaling options for total bar heights: none, pseudolog or normalize"
    inputBinding:
      position: 111
      prefix: "--scaling"
  - id: as_genera
    type:
      - 'null'
      - boolean
    doc: "Collapse species to genera"
    inputBinding:
      position: 112
      prefix: "--as-genera"
  - id: grid
    type:
      - 'null'
      - boolean
    doc: "Add y-axis grid"
    inputBinding:
      position: 113
      prefix: "--grid"
  - id: remove_zeroes
    type:
      - 'null'
      - boolean
    doc: "Do not plot samples with zero sum for this feature"
    inputBinding:
      position: 114
      prefix: "--remove-zeroes"
  - id: width
    type:
      - 'null'
      - int
    doc: "Relative width of the plot vs. legend (default: 5)"
    inputBinding:
      position: 115
      prefix: "--width"
  - id: dimensions
    type:
      - 'null'
      - type: array
        items: float
    doc: "Image height and width in inches: two numbers (default: 8 4)"
    inputBinding:
      position: 116
      prefix: "--dimensions"
  - id: ylims
    type:
      - 'null'
      - type: array
        items: float
    doc: "Fix limits for y-axis: two numbers"
    inputBinding:
      position: 117
      prefix: "--ylims"
  - id: legend_stretch
    type:
      - 'null'
      - boolean
    doc: "Stretch/compress legend elements"
    inputBinding:
      position: 118
      prefix: "--legend-stretch"
outputs:
  - id: figure
    type: File
    doc: "the barplot figure"
    outputBinding:
      glob: '$(inputs.output_path)'
requirements:
  - class: InlineJavascriptRequirement
  - class: EnvVarRequirement
    envDef:
      - envName: MPLCONFIGDIR
        envValue: $(runtime.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/humann2:2.8.1--py27_0
