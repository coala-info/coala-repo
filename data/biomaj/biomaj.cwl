cwlVersion: v1.2
class: CommandLineTool
baseCommand: biomaj
label: biomaj
doc: "BioMAJ (Biological Management of Application for Jussieu) is a workflow engine
  dedicated to data management and synchronization.\n\nTool homepage: https://github.com/genouest/biomaj"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biomaj:3.0.19--py35_0
stdout: biomaj.out
