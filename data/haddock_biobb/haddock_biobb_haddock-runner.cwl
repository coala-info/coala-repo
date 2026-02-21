cwlVersion: v1.2
class: CommandLineTool
baseCommand: haddock-runner
label: haddock_biobb_haddock-runner
doc: "A tool for running HADDOCK (High Ambiguity Driven protein-protein DOCKing) workflows,
  likely within the BioBB (BioExcel Building Blocks) ecosystem.\n\nTool homepage:
  https://github.com/haddocking/haddock3"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/haddock_biobb:2025.5--py39he88f293_3
stdout: haddock_biobb_haddock-runner.out
