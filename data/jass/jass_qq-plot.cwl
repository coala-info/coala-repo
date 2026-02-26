cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - jass
  - qq-plot
label: jass_qq-plot
doc: "Generates a QQ plot from a worktable.\n\nTool homepage: http://statistical-genetics.pages.pasteur.fr/jass/"
inputs:
  - id: worktable_path
    type: File
    doc: Path to the input worktable file.
    inputBinding:
      position: 101
      prefix: --worktable-path
outputs:
  - id: plot_path
    type: File
    doc: Path to save the output QQ plot.
    outputBinding:
      glob: $(inputs.plot_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jass:2.3--pyhca03a8a_0
