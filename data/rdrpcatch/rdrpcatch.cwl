cwlVersion: v1.2
class: CommandLineTool
baseCommand: rdrpcatch
label: rdrpcatch
doc: "RdRpCatch is a tool for detecting RNA-dependent RNA polymerase (RdRp) sequences.
  (Note: The provided text is a container build error log and does not contain usage
  or argument information).\n\nTool homepage: https://github.com/dimitris-karapliafis/RdRpCATCH"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rdrpcatch:0.0.9--pyhdfd78af_0
stdout: rdrpcatch.out
