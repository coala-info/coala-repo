cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - exact-tandems
label: mummer_exact-tandems
doc: "Find exact tandem repeats in the specified file involving an exact duplicate of at least the specified length.\n\nTool homepage: https://github.com/mummer4/mummer"
inputs:
  - id: file
    type: File
    doc: "Input FASTA file"
    inputBinding:
      position: 100
  - id: min_match_len
    type: int
    doc: "Minimum length of the exact duplicate"
    inputBinding:
      position: 101
outputs:
  - id: stdout_out
    type: stdout
    doc: "Tandem repeats"
  - id: log
    type: stderr
    doc: "Progress and warning messages"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mummer:3.23--pl5321hdbdd923_18
stdout: mummer_exact-tandems.out
stderr: mummer_exact-tandems.log
