cwlVersion: v1.2
class: CommandLineTool
baseCommand: mp3treesim
label: mp3treesim
doc: "A tool for computing the MP3 similarity between phylogenetic trees.\n\nTool
  homepage: https://algolab.github.io/mp3treesim/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mp3treesim:1.0.6--py_0
stdout: mp3treesim.out
