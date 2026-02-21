cwlVersion: v1.2
class: CommandLineTool
baseCommand: lotus2
label: lotus2
doc: "The provided text does not contain help information or a description of the
  tool; it contains system log messages and a fatal error regarding disk space during
  a container build.\n\nTool homepage: http://lotus2.earlham.ac.uk/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lotus2:2.34.1--hdfd78af_1
stdout: lotus2.out
