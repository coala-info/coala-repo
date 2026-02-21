cwlVersion: v1.2
class: CommandLineTool
baseCommand: prophasm
label: prophasm
doc: "A tool for computing the assembly of a set of genomes. (Note: The provided input
  text appears to be a container engine error log rather than help text; therefore,
  no arguments could be extracted.)\n\nTool homepage: https://github.com/prophyle/prophasm"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/prophasm:0.1.1--h077b44d_5
stdout: prophasm.out
