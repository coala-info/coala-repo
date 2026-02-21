cwlVersion: v1.2
class: CommandLineTool
baseCommand: howdesbt
label: howdesbt
doc: "HowDeSBT (How De Bruijn Graph Sequence Bloom Tree) is a tool for topological
  analysis of large collections of De Bruijn graphs. Note: The provided text is a
  container runtime error log and does not contain command-line argument definitions.\n
  \nTool homepage: https://github.com/medvedevgroup/HowDeSBT"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/howdesbt:2.00.15--h9948957_2
stdout: howdesbt.out
