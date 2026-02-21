cwlVersion: v1.2
class: CommandLineTool
baseCommand: pacini_typing
label: pacini_typing
doc: "The provided help text contains fatal system errors (no space left on device)
  and environment info rather than the tool's usage instructions. No arguments could
  be extracted.\n\nTool homepage: https://github.com/RIVM-bioinformatics/Pacini-typing"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pacini_typing:2.0.2--pyhdfd78af_0
stdout: pacini_typing.out
