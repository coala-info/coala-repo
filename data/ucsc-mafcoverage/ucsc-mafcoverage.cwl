cwlVersion: v1.2
class: CommandLineTool
baseCommand: mafCoverage
label: ucsc-mafcoverage
doc: "The provided text does not contain help information as it is a container runtime
  error log. mafCoverage is a UCSC tool used to calculate coverage from a MAF (Multiple
  Alignment Format) file.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-mafcoverage:482--h0b57e2e_0
stdout: ucsc-mafcoverage.out
