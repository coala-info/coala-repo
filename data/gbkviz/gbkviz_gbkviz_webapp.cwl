cwlVersion: v1.2
class: CommandLineTool
baseCommand: gbkviz_webapp
label: gbkviz_gbkviz_webapp
doc: "Simple web application to visualize and compare genomes in Genbank files\n\n\
  Tool homepage: https://github.com/moshi4/GBKviz/"
inputs:
  - id: port
    type:
      - 'null'
      - int
    doc: Port number to open web server
    inputBinding:
      position: 101
      prefix: --port
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gbkviz:1.2.0--pyhdfd78af_0
stdout: gbkviz_gbkviz_webapp.out
