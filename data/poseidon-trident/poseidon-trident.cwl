cwlVersion: v1.2
class: CommandLineTool
baseCommand: trident
label: poseidon-trident
doc: "The provided text does not contain help information or usage instructions for
  poseidon-trident. It appears to be a log of a failed container build or fetch operation.\n
  \nTool homepage: https://poseidon-framework.github.io/#/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/poseidon-trident:1.6.7.1--hebebf5b_0
stdout: poseidon-trident.out
