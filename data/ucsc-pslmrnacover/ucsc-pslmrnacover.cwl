cwlVersion: v1.2
class: CommandLineTool
baseCommand: pslMrnaCover
label: ucsc-pslmrnacover
doc: "The provided text does not contain help information as it reflects a container
  build failure. pslMrnaCover is a UCSC Genome Browser utility used to calculate mRNA
  coverage from PSL files.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-pslmrnacover:482--h0b57e2e_0
stdout: ucsc-pslmrnacover.out
