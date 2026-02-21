cwlVersion: v1.2
class: CommandLineTool
baseCommand: svim
label: svim
doc: "SVIM (Structural Variant Identification using Mapped Long Reads) is a tool for
  detecting and classifying structural variants from long-read alignments.\n\nTool
  homepage: https://github.com/eldariont/svim"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/svim:2.0.0--pyhdfd78af_0
stdout: svim.out
