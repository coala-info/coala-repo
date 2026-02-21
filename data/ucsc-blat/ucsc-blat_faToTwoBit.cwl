cwlVersion: v1.2
class: CommandLineTool
baseCommand: faToTwoBit
label: ucsc-blat_faToTwoBit
doc: "The provided text contains a fatal error log from a container runtime and does
  not include the actual help documentation for the tool. Based on the tool name hint
  'ucsc-blat_faToTwoBit', this tool is used to convert DNA sequences from FASTA format
  to 2bit format.\n\nTool homepage: http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-blat:482--hdc0a859_0
stdout: ucsc-blat_faToTwoBit.out
