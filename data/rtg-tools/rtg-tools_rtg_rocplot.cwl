cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - rtg
  - rocplot
label: rtg-tools_rtg_rocplot
doc: 'Plot ROC curves from vcfeval ROC data files, either to an image, or an interactive GUI. Tool homepage: https://github.com/RealTimeGenomics/rtg-tools'
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: curve
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --curve
    doc: 'ROC data file with title optionally specified (path[=title]). May be specified 0 or more times'
    inputBinding:
      position: 101
  - id: png
    type:
      - 'null'
      - string
    doc: 'if set, output a PNG image to the given file'
    inputBinding:
      position: 101
      prefix: --png
  - id: svg
    type:
      - 'null'
      - string
    doc: 'if set, output a SVG image to the given file'
    inputBinding:
      position: 101
      prefix: --svg
  - id: zoom
    type:
      - 'null'
      - string
    doc: 'show a zoomed view with the given coordinates, supplied in the form <xmax>,<ymax> or <xmin>,<ymin>,<xmax>,<ymax>'
    inputBinding:
      position: 101
      prefix: --zoom
  - id: cmd
    type:
      - 'null'
      - File
    doc: 'if set, print rocplot command used in previously saved image'
    inputBinding:
      position: 101
      prefix: --cmd
  - id: hide_sidepane
    type:
      - 'null'
      - boolean
    doc: 'if set, hide the side pane from the GUI on startup'
    inputBinding:
      position: 101
      prefix: --hide-sidepane
  - id: interpolate
    type:
      - 'null'
      - boolean
    doc: 'if set, interpolate curves at regular intervals'
    inputBinding:
      position: 101
      prefix: --interpolate
  - id: line_width
    type:
      - 'null'
      - int
    doc: 'sets the plot line width (Default is 2)'
    inputBinding:
      position: 101
      prefix: --line-width
  - id: palette
    type:
      - 'null'
      - string
    doc: 'name of color palette to use. Allowed values are [blind_13, blind_15, blind_8, brewer_accent, brewer_dark2, brewer_paired, brewer_pastel1, brewer_pastel2, brewer_set1, brewer_set2, brewer_set3, classic] (Default is classic)'
    inputBinding:
      position: 101
      prefix: --palette
  - id: plain
    type:
      - 'null'
      - boolean
    doc: 'if set, use a plain plot style'
    inputBinding:
      position: 101
      prefix: --plain
  - id: points
    type:
      - 'null'
      - boolean
    doc: 'if set, show points on each curve'
    inputBinding:
      position: 101
      prefix: --points
  - id: precision_sensitivity
    type:
      - 'null'
      - boolean
    doc: 'if set, plot precision vs sensitivity rather than ROC'
    inputBinding:
      position: 101
      prefix: --precision-sensitivity
  - id: scores
    type:
      - 'null'
      - boolean
    doc: 'if set, show scores on the plot'
    inputBinding:
      position: 101
      prefix: --scores
  - id: title
    type:
      - 'null'
      - string
    doc: 'title for the plot'
    inputBinding:
      position: 101
      prefix: --title
  - id: files
    type:
      - 'null'
      - type: array
        items: File
    doc: 'ROC data file. May be specified 0 or more times'
    inputBinding:
      position: 200
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: png_file
    type:
      - 'null'
      - File
    doc: 'PNG image of the ROC plot'
    outputBinding:
      glob: $(inputs.png)
  - id: svg_file
    type:
      - 'null'
      - File
    doc: 'SVG image of the ROC plot'
    outputBinding:
      glob: $(inputs.svg)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rtg-tools:3.13--hdfd78af_0
stdout: rtg-tools_rtg_rocplot.out
