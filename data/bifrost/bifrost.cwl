cwlVersion: v1.2
class: CommandLineTool
baseCommand: bifrost
label: bifrost
doc: "A tool for construction and querying of colored de Bruijn graphs (Note: The
  provided text is a system error log and does not contain CLI help information).\n
  \nTool homepage: https://github.com/pmelsted/bifrost"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bifrost:1.3.5--h43eeafb_0
stdout: bifrost.out
