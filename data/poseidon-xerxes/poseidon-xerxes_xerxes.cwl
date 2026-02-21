cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - xerxes
label: poseidon-xerxes_xerxes
doc: "The provided text does not contain help information for the tool, but appears
  to be a log of a failed container build or fetch operation.\n\nTool homepage: https://poseidon-framework.github.io/#/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/poseidon-xerxes:1.0.1.1--hf48d1a7_0
stdout: poseidon-xerxes_xerxes.out
