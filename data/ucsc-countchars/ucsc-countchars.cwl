cwlVersion: v1.2
class: CommandLineTool
baseCommand: countChars
label: ucsc-countchars
doc: "A tool to count characters in a file. (Note: The provided help text contains
  only container runtime error messages and does not list specific arguments.)\n\n
  Tool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-countchars:482--h0b57e2e_0
stdout: ucsc-countchars.out
