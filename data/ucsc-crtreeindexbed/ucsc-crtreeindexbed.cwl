cwlVersion: v1.2
class: CommandLineTool
baseCommand: crTreeIndexBed
label: ucsc-crtreeindexbed
doc: "The provided text does not contain help information for the tool, but is an
  error log from a container runtime failure. Based on the tool name, this is a UCSC
  Genome Browser utility used to create a chromosome tree index for a BED file.\n\n
  Tool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-crtreeindexbed:482--h0b57e2e_0
stdout: ucsc-crtreeindexbed.out
