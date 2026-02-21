cwlVersion: v1.2
class: CommandLineTool
baseCommand: haddock3-copy
label: haddock_biobb_haddock3-copy
doc: "HADDOCK3 copy tool (Note: The provided help text contains only system error
  messages and no usage information).\n\nTool homepage: https://github.com/haddocking/haddock3"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/haddock_biobb:2025.5--py39he88f293_3
stdout: haddock_biobb_haddock3-copy.out
