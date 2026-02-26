cwlVersion: v1.2
class: CommandLineTool
baseCommand: Bifrost
label: bifrost_Bifrost
doc: "Highly parallel construction, indexing and querying of colored and compacted
  de Bruijn graphs\n\nTool homepage: https://github.com/pmelsted/bifrost"
inputs:
  - id: command
    type: string
    doc: Command to execute (build, update, query)
    inputBinding:
      position: 1
  - id: parameters
    type:
      - 'null'
      - string
    doc: Parameters specific to the chosen command
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bifrost:1.3.5--h5ca1c30_3
stdout: bifrost_Bifrost.out
