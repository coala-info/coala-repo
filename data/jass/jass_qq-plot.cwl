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
  - id: plot_path_path
    type: string
    doc: Output or path parameter `plot_path_path`
    inputBinding:
      position: 102
      prefix: --plot-path
outputs:
  - id: plot_path
    type: File
    doc: Path to save the output QQ plot.
    outputBinding:
      glob: $(inputs.plot_path_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jass:2.3--pyhca03a8a_0
