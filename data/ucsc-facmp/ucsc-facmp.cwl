cwlVersion: v1.2
class: CommandLineTool
baseCommand: faCmp
label: ucsc-facmp
doc: "Compare two FASTA files to see if they are identical.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-facmp:482--h0b57e2e_0
stdout: ucsc-facmp.out
