cwlVersion: v1.2
class: CommandLineTool
baseCommand: faFrag
label: ucsc-fafrag
doc: "The provided text does not contain help information for the tool. It contains
  container execution error messages. faFrag is a UCSC Genome Browser utility used
  to extract fragments from a FASTA file.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-fafrag:482--h0b57e2e_0
stdout: ucsc-fafrag.out
