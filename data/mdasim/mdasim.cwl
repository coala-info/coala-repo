cwlVersion: v1.2
class: CommandLineTool
baseCommand: mdasim
label: mdasim
doc: "Metagenomic Data Assembly Simulator (Note: The provided help text contains only
  system error messages and no usage information).\n\nTool homepage: https://sourceforge.net/projects/mdasim/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mdasim:2.1.1--hf316886_7
stdout: mdasim.out
