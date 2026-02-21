cwlVersion: v1.2
class: CommandLineTool
baseCommand: recur
label: recur
doc: "A tool for repetitive element curation (Note: The provided text contains build
  logs and error messages rather than help documentation; no arguments could be extracted).\n
  \nTool homepage: https://github.com/OrthoFinder/RECUR"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/recur:1.0.0--pyhdfd78af_0
stdout: recur.out
