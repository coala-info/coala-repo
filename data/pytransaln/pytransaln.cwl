cwlVersion: v1.2
class: CommandLineTool
baseCommand: pytransaln
label: pytransaln
doc: "Translation-guided alignment of protein-coding DNA sequences\n\nTool homepage:
  https://github.com/monagrland/pytransaln"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pytransaln:0.2.2--pyh7e72e81_0
stdout: pytransaln.out
