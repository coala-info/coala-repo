cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - jass
  - plot-manhattan
label: jass_plot-manhattan
doc: "Generates a Manhattan plot from a JASS worktable.\n\nTool homepage: http://statistical-genetics.pages.pasteur.fr/jass/"
inputs:
  - id: worktable_path
    type: File
    doc: Path to the JASS worktable file.
    inputBinding:
      position: 101
      prefix: --worktable-path
outputs:
  - id: plot_path
    type: File
    doc: Path to save the generated Manhattan plot.
    outputBinding:
      glob: $(inputs.plot_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jass:2.3--pyhca03a8a_0
