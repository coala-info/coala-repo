cwlVersion: v1.2
class: CommandLineTool
baseCommand: bbknn
label: bbknn
doc: "The provided text does not contain help information for the tool. It consists
  of system logs and a fatal error message regarding a container build failure (no
  space left on device).\n\nTool homepage: https://github.com/Teichlab/bbknn"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bbknn:1.6.0--py39hf95cd2a_0
stdout: bbknn.out
