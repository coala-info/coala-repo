cwlVersion: v1.2
class: CommandLineTool
baseCommand: syngap initdb
label: syngap_initdb
doc: "Initialize a new syngap database by importing a masterdb.\n\nTool homepage:
  https://github.com/yanyew/SynGAP"
inputs:
  - id: file
    type: File
    doc: The compressed file of masterdb (.tar.gz) to be imported
    inputBinding:
      position: 101
      prefix: --file
  - id: sp
    type: string
    doc: The species type of masterdb to be imported, plant|animal
    inputBinding:
      position: 101
      prefix: --sp
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/syngap:1.2.5--py312hdfd78af_0
stdout: syngap_initdb.out
