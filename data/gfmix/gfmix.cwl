cwlVersion: v1.2
class: CommandLineTool
baseCommand: gfmix
label: gfmix
doc: "The provided text contains container runtime error messages and does not include
  help documentation or usage instructions for the gfmix tool.\n\nTool homepage: https://www.mathstat.dal.ca/~tsusko/doc/gfmix.pdf"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gfmix:1.0.2--h503566f_3
stdout: gfmix.out
