cwlVersion: v1.2
class: CommandLineTool
baseCommand: scree_plot_pyseer
label: pyseer_scree_plot
doc: "Draw a scree-plot from MDS eigenvalues.\n\nTool homepage: https://github.com/mgalardini/pyseer"
inputs:
  - id: distances
    type: File
    doc: Strains distance square matrix.
    inputBinding:
      position: 1
  - id: max_dimensions
    type:
      - 'null'
      - int
    doc: Maximum dimensions to plot.
    inputBinding:
      position: 2
      prefix: --max-dimensions
  - id: output_path
    type:
      - 'null'
      - string
    doc: Plot filename.
    default: scree_plot.png
    inputBinding:
      position: 2
      prefix: --output
outputs:
  - id: scree_plot
    type: File
    doc: Scree plot image
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyseer:1.4.0--pyhdfd78af_0
