cwlVersion: v1.2
class: CommandLineTool
baseCommand: pslHisto
label: ucsc-pslhisto
doc: "The provided text does not contain help information for the tool. It appears
  to be a log of a failed container build process. pslHisto is a UCSC Genome Browser
  utility used to create a histogram of PSL alignment scores.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-pslhisto:482--h0b57e2e_0
stdout: ucsc-pslhisto.out
