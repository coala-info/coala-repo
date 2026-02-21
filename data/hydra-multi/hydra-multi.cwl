cwlVersion: v1.2
class: CommandLineTool
baseCommand: hydra-multi
label: hydra-multi
doc: "A tool for identifying structural variations and multi-breakpoints in genomic
  data (Note: The provided text contains container runtime error messages rather than
  command-line help documentation).\n\nTool homepage: https://github.com/arq5x/Hydra"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hydra-multi:0.5.4--py27h5ca1c30_4
stdout: hydra-multi.out
