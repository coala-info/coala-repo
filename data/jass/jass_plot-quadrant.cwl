cwlVersion: v1.2
class: CommandLineTool
baseCommand: jass plot-quadrant
label: jass_plot-quadrant
doc: "Generates a quadrant plot from a worktable.\n\nTool homepage: http://statistical-genetics.pages.pasteur.fr/jass/"
inputs:
  - id: significance_treshold
    type:
      - 'null'
      - float
    doc: threshold at which a p-value is considered significant
    inputBinding:
      position: 101
      prefix: --significance-treshold
  - id: worktable_path
    type: File
    doc: path to the worktable file containing the data
    inputBinding:
      position: 101
      prefix: --worktable-path
outputs:
  - id: plot_path
    type: File
    doc: path to the quadrant plot file to generate
    outputBinding:
      glob: $(inputs.plot_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jass:2.3--pyhca03a8a_0
