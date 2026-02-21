cwlVersion: v1.2
class: CommandLineTool
baseCommand: cnasim
label: cnasim
doc: "Copy Number Alteration Simulator (Note: The provided text contains container
  runtime error messages rather than tool help text; no arguments could be extracted).\n
  \nTool homepage: https://github.com/samsonweiner/CNAsim"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cnasim:1.3.5--pyhdfd78af_0
stdout: cnasim.out
