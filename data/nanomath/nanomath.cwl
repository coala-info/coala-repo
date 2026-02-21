cwlVersion: v1.2
class: CommandLineTool
baseCommand: nanomath
label: nanomath
doc: "The provided text contains container runtime error messages rather than tool
  help text. No usage information or arguments could be extracted.\n\nTool homepage:
  https://github.com/wdecoster/nanomath"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nanomath:1.4.0--pyhdfd78af_0
stdout: nanomath.out
