cwlVersion: v1.2
class: CommandLineTool
baseCommand: genmap
label: genmap
doc: "GenMap is a tool for computing the mappability of genomes.\n\nTool homepage:
  https://github.com/cpockrandt/genmap"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genmap:1.3.0--h9948957_4
stdout: genmap.out
