cwlVersion: v1.2
class: CommandLineTool
baseCommand: scrnasim-toolz
label: scrnasim-toolz
doc: "A tool for single-cell RNA simulation (Note: The provided text contains system
  error logs regarding a failed container build and does not include help documentation
  or argument definitions).\n\nTool homepage: https://github.com/zavolanlab/scRNAsim-toolz"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scrnasim-toolz:0.1.1--pyhdfd78af_0
stdout: scrnasim-toolz.out
