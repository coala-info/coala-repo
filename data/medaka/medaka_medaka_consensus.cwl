cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - medaka
  - consensus
label: medaka_medaka_consensus
doc: "The provided text does not contain help information for the tool, but rather
  an error message indicating a failure to run the container (no space left on device).\n
  \nTool homepage: https://github.com/nanoporetech/medaka"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/medaka:2.2.0--py311h1d3aea1_0
stdout: medaka_medaka_consensus.out
