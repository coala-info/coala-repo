cwlVersion: v1.2
class: CommandLineTool
baseCommand: strainge plot
label: strainge_plot
doc: "Generate plots for a given k-mer set.\n\nTool homepage: The package home page"
inputs:
  - id: kmerset
    type: string
    doc: The k-mer set to load
    inputBinding:
      position: 1
  - id: plot_type
    type:
      - 'null'
      - string
    doc: The kind of plot to generate.
    default: spectrum
    inputBinding:
      position: 102
      prefix: --plot-type
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output filename (PNG preferred).
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/strainge:1.3.9--py38h737be40_0
