cwlVersion: v1.2
class: CommandLineTool
baseCommand: filesendercli
label: filesendercli
doc: "The provided text does not contain help information or a description of the
  tool; it contains container runtime error logs.\n\nTool homepage: https://github.com/WEHI-ResearchComputing/FileSenderCli"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/filesendercli:3.0.0
stdout: filesendercli.out
