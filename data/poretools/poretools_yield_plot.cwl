cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - poretools
  - yield_plot
label: poretools_yield_plot
doc: "Generates a plot of yield per read from FAST5 files.\n\nTool homepage: https://github.com/arq5x/poretools"
inputs:
  - id: files
    type:
      type: array
      items: File
    doc: The input FAST5 files.
    inputBinding:
      position: 1
  - id: plot_type
    type:
      - 'null'
      - string
    doc: Save the wiggle plot to a file (def=reads).
    inputBinding:
      position: 102
      prefix: --plot-type
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Do not output warnings to stderr
    inputBinding:
      position: 102
      prefix: --quiet
  - id: savedf
    type:
      - 'null'
      - string
    doc: Save the data frame used to construct plot to a file.
    inputBinding:
      position: 102
      prefix: --savedf
  - id: skip
    type:
      - 'null'
      - int
    doc: Only plot every n points to reduce size
    inputBinding:
      position: 102
      prefix: --skip
  - id: theme_bw
    type:
      - 'null'
      - boolean
    doc: Use a black and white theme.
    inputBinding:
      position: 102
      prefix: --theme-bw
outputs:
  - id: saveas
    type:
      - 'null'
      - File
    doc: Save the plot to a file. Extension (.pdf or .png) drives type.
    outputBinding:
      glob: $(inputs.saveas)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/poretools:0.6.1a0--py27_0
