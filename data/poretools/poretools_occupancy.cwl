cwlVersion: v1.2
class: CommandLineTool
baseCommand: poretools_occupancy
label: poretools_occupancy
doc: "Calculate and plot the occupancy of pores over time.\n\nTool homepage: https://github.com/arq5x/poretools"
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
    doc: The type of plot to generate
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
  - id: saveas_path
    type: string
    doc: Output or path parameter `saveas_path`
    inputBinding:
      position: 103
      prefix: --saveas
outputs:
  - id: saveas
    type:
      - 'null'
      - File
    doc: Save the plot to a file. Extension (.pdf or .png) drives type.
    outputBinding:
      glob: $(inputs.saveas_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/poretools:0.6.1a0--py27_0
