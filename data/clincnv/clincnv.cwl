cwlVersion: v1.2
class: CommandLineTool
baseCommand: clincnv
label: clincnv
doc: "The provided text contains system error logs related to a container build failure
  (no space left on device) and does not contain the help text or usage information
  for the clincnv tool.\n\nTool homepage: https://github.com/imgag/ClinCNV"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/clincnv:1.19.1--hdfd78af_0
stdout: clincnv.out
