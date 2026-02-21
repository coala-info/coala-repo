cwlVersion: v1.2
class: CommandLineTool
baseCommand: gsearch
label: gsearch
doc: "The provided text does not contain help information for the tool. It contains
  system log messages and a fatal error regarding a container build failure (no space
  left on device).\n\nTool homepage: https://github.com/jean-pierreBoth/gsearch"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gsearch:0.3.4--hafc0c1d_0
stdout: gsearch.out
