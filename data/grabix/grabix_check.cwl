cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - grabix
  - check
label: grabix_check
doc: "Check whether a file is bgzipped (prints yes or no).\n\nTool homepage: https://github.com/arq5x/grabix"
inputs:
  - id: bgzf_file
    type: File
    doc: file to test
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: yes or no
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/grabix:0.1.8--h077b44d_12
stdout: grabix_check.out
