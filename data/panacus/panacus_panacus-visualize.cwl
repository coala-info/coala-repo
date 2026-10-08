cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - panacus-visualize
label: panacus_panacus-visualize
doc: "Visualize growth stats. Figures in given (output) format will be plotted to stdout,
  or optionally splitted into in individual files that start with a given prefix. (Deprecated
  upstream in favour of `panacus report`.)\n\nTool homepage: https://github.com/marschall-lab/panacus"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: stats
    type: File
    doc: Growth/Histogram table computed by panacus
    inputBinding:
      position: 200
  - id: estimate_growth_params
    type:
      - 'null'
      - boolean
    doc: 'Estimate growth parameters based on least-squares fit (default: False)'
    inputBinding:
      position: 1
      prefix: --estimate_growth_params
  - id: legend_location
    type:
      - 'null'
      - type: enum
        symbols:
          - lower left
          - lower right
          - upper left
          - upper right
    doc: 'Location of the legend (default: upper left)'
    inputBinding:
      position: 1
      prefix: --legend_location
  - id: figsize
    type:
      - 'null'
      - type: array
        items: float
    doc: 'Set size of figure canvas, two numbers: width height (default: [10, 6])'
    inputBinding:
      position: 1
      prefix: --figsize
  - id: format
    type:
      - 'null'
      - type: enum
        symbols:
          - eps
          - jpg
          - jpeg
          - pdf
          - pgf
          - png
          - ps
          - raw
          - rgba
          - svg
          - svgz
          - tif
          - tiff
          - webp
    doc: 'Specify the format of the output (default: pdf)'
    inputBinding:
      position: 1
      prefix: --format
  - id: split_subfigures
    type:
      - 'null'
      - boolean
    doc: 'Split output into multiple files (default: False)'
    inputBinding:
      position: 1
      prefix: --split_subfigures
  - id: split_prefix
    type:
      - 'null'
      - string
    doc: 'Prefix given to the files generated when splitting into subfigures (default:
      out_)'
    inputBinding:
      position: 1
      prefix: --split_prefix
outputs:
  - id: figure
    type: stdout
    doc: Figure written to stdout (when not splitting into subfigures)
  - id: subfigures
    type:
      type: array
      items: File
    doc: Subfigure files (with split_subfigures)
    outputBinding:
      glob: "$(inputs.split_prefix ? inputs.split_prefix : 'out_')*"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/panacus:0.4.1--hc1c3326_0
stdout: "panacus_visualize.$(inputs.format ? inputs.format : 'pdf')"
