cwlVersion: v1.2
class: CommandLineTool
baseCommand: genomicconsensus
label: genomicconsensus
doc: "The provided text does not contain help information for the tool; it contains
  system error messages related to a container runtime failure (no space left on device).\n
  \nTool homepage: https://github.com/PacificBiosciences/pbbioconda"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genomicconsensus:3.0.2--py27_0
stdout: genomicconsensus.out
