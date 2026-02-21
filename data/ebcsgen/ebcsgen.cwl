cwlVersion: v1.2
class: CommandLineTool
baseCommand: ebcsgen
label: ebcsgen
doc: "The provided text contains container runtime error messages and does not include
  the tool's help documentation or usage instructions. As a result, no arguments could
  be extracted.\n\nTool homepage: https://github.com/sybila/eBCSgen"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ebcsgen:2.2.0--pyhdfd78af_0
stdout: ebcsgen.out
