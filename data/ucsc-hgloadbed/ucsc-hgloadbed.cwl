cwlVersion: v1.2
class: CommandLineTool
baseCommand: hgLoadBed
label: ucsc-hgloadbed
doc: "The provided text does not contain help information as it reflects a container
  execution error (FATAL: Unable to handle docker uri). Under normal operation, this
  tool is used to load BED track data into a UCSC Genome Browser database.\n\nTool
  homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-hgloadbed:482--h0b57e2e_1
stdout: ucsc-hgloadbed.out
