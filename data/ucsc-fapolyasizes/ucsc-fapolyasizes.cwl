cwlVersion: v1.2
class: CommandLineTool
baseCommand: faPolyASizes
label: ucsc-fapolyasizes
doc: "The provided text does not contain help information for the tool. It appears
  to be a container engine error log. Based on the tool name, this utility is typically
  used to calculate polyA tail sizes from FASTA files.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-fapolyasizes:482--h0b57e2e_0
stdout: ucsc-fapolyasizes.out
