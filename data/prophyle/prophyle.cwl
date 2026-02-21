cwlVersion: v1.2
class: CommandLineTool
baseCommand: prophyle
label: prophyle
doc: "ProPhyle is a phylogeny-based metagenomic classifier. (Note: The provided text
  appears to be a container engine log rather than CLI help text, so no arguments
  could be extracted.)\n\nTool homepage: https://github.com/karel-brinda/prophyle"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/prophyle:0.3.3.2--py310h5140242_4
stdout: prophyle.out
