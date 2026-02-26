cwlVersion: v1.2
class: CommandLineTool
baseCommand: cblaster
label: cblaster_gui
doc: "A tool for finding homologous sequences in a database using BLAST.\n\nTool homepage:
  https://github.com/gamcil/cblaster"
inputs:
  - id: config
    type:
      - 'null'
      - boolean
    doc: Run cblaster config to set up configuration.
    inputBinding:
      position: 101
      prefix: config
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cblaster:1.4.0--pyhdfd78af_0
stdout: cblaster_gui.out
