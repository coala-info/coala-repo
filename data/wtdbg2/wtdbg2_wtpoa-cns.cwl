cwlVersion: v1.2
class: CommandLineTool
baseCommand: wtpoa-cns
label: wtdbg2_wtpoa-cns
doc: "The provided text contains container execution logs and error messages rather
  than the tool's help documentation. No arguments could be extracted.\n\nTool homepage:
  https://github.com/ruanjue/wtdbg2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wtdbg2:2.0--h470a237_0
stdout: wtdbg2_wtpoa-cns.out
