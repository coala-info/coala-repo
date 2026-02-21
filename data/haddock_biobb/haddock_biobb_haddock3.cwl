cwlVersion: v1.2
class: CommandLineTool
baseCommand: haddock3
label: haddock_biobb_haddock3
doc: "HADDOCK3 (High Ambiguity Driven protein-protein DOCKing) BioBB wrapper. Note:
  The provided text contains container execution errors and does not list command-line
  arguments.\n\nTool homepage: https://github.com/haddocking/haddock3"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/haddock_biobb:2025.5--py39he88f293_3
stdout: haddock_biobb_haddock3.out
