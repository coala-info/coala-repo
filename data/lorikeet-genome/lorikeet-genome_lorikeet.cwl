cwlVersion: v1.2
class: CommandLineTool
baseCommand: lorikeet
label: lorikeet-genome_lorikeet
doc: "The provided text does not contain help information or a description of the
  tool. It contains system log messages and a fatal error regarding disk space during
  a container build.\n\nTool homepage: https://github.com/rhysnewell/Lorikeet"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lorikeet-genome:0.8.2--h8e1a5b0_0
stdout: lorikeet-genome_lorikeet.out
