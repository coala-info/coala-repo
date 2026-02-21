cwlVersion: v1.2
class: CommandLineTool
baseCommand: pgv-gui
label: pygenomeviz_pgv-gui
doc: "Launch the pyGenomeViz Graphical User Interface (GUI) for genome visualization.\n
  \nTool homepage: https://github.com/moshi4/pyGenomeViz/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pygenomeviz:0.4.4--pyhdfd78af_0
stdout: pygenomeviz_pgv-gui.out
