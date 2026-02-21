cwlVersion: v1.2
class: CommandLineTool
baseCommand: strainy_strainy.py
label: strainy_strainy.py
doc: "Strainy is a tool for strain-level analysis of microbial communities. (Note:
  The provided text contains container build logs and error messages rather than the
  tool's help documentation; therefore, no arguments could be extracted.)\n\nTool
  homepage: https://github.com/katerinakazantseva/strainy"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/strainy:1.2--pyhdfd78af_1
stdout: strainy_strainy.py.out
