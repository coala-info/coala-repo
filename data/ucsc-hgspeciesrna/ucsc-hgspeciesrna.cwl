cwlVersion: v1.2
class: CommandLineTool
baseCommand: hgSpeciesRna
label: ucsc-hgspeciesrna
doc: "A UCSC Genome Browser utility. Note: The provided input text contains container
  build logs and a fatal error message rather than the tool's help documentation,
  so no arguments could be extracted.\n\nTool homepage: http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-hgspeciesrna:482--h0b57e2e_1
stdout: ucsc-hgspeciesrna.out
