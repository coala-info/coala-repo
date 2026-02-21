cwlVersion: v1.2
class: CommandLineTool
baseCommand: figtree
label: figtree
doc: "FigTree is a graphical viewer of phylogenetic trees and as a program for producing
  publication-ready figures.\n\nTool homepage: https://github.com/rambaut/figtree"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/figtree:v1.4.4-3-deb_cv1
stdout: figtree.out
