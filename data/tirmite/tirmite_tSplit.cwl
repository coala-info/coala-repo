cwlVersion: v1.2
class: CommandLineTool
baseCommand: tirmite_tSplit
label: tirmite_tSplit
doc: "A tool within the TIRmite package. (Note: The provided help text contains container
  build error logs and does not include usage information or argument definitions).\n
  \nTool homepage: https://github.com/Adamtaranto/TIRmite"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tirmite:1.3.0--pyhdfd78af_0
stdout: tirmite_tSplit.out
