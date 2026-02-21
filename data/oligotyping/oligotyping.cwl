cwlVersion: v1.2
class: CommandLineTool
baseCommand: oligotyping
label: oligotyping
doc: "The provided text does not contain help information for the tool. It is a system
  error message regarding a container build failure (no space left on device).\n\n
  Tool homepage: https://github.com/merenlab/oligotyping"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/oligotyping:2.1--py27_0
stdout: oligotyping.out
