cwlVersion: v1.2
class: CommandLineTool
baseCommand: clinCNV.R
label: clincnv_clinCNV.R
doc: "The provided text is a system error log (out of disk space during container
  extraction) and does not contain the help documentation or argument definitions
  for the tool.\n\nTool homepage: https://github.com/imgag/ClinCNV"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/clincnv:1.19.1--hdfd78af_0
stdout: clincnv_clinCNV.R.out
