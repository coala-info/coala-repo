cwlVersion: v1.2
class: CommandLineTool
baseCommand: pgv-gui
label: pygenomeviz_pgv-gui
doc: "Launch pyGenomeViz WebApp\n\nTool homepage: https://github.com/moshi4/pyGenomeViz/"
inputs:
  - id: port
    type:
      - 'null'
      - int
    doc: Port number to open web browser
    inputBinding:
      position: 101
      prefix: --port
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pygenomeviz:0.4.4--pyhdfd78af_0
stdout: pygenomeviz_pgv-gui.out
