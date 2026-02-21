cwlVersion: v1.2
class: CommandLineTool
baseCommand: flextaxd
label: flextaxd
doc: "A tool for flexible taxonomy database management (Note: The provided help text
  contains only system error messages and no usage information).\n\nTool homepage:
  https://github.com/FOI-Bioinformatics/flextaxd"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/flextaxd:0.4.4--pyhdfd78af_0
stdout: flextaxd.out
