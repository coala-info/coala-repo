cwlVersion: v1.2
class: CommandLineTool
baseCommand: hgFakeAgp
label: ucsc-hgfakeagp
doc: "Create a fake AGP file from a FASTA file (Note: The provided help text contains
  only system error messages and no usage information).\n\nTool homepage: http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-hgfakeagp:482--h0b57e2e_0
stdout: ucsc-hgfakeagp.out
