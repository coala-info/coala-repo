cwlVersion: v1.2
class: CommandLineTool
baseCommand: haddock_biobb
label: haddock_biobb
doc: "The provided text does not contain help documentation or usage instructions.
  It appears to be a system error log indicating a failure to build a container image
  due to insufficient disk space.\n\nTool homepage: https://github.com/haddocking/haddock3"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/haddock_biobb:2025.5--py39he88f293_3
stdout: haddock_biobb.out
