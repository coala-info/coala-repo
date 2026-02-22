cwlVersion: v1.2
class: CommandLineTool
baseCommand: sccaller
label: sccaller
doc: "Single-cell variant calling tool. (Note: The provided text contains system error
  messages regarding container execution and does not include the actual help documentation
  for the tool.)\n\nTool homepage: https://github.com/biosinodx/SCcaller"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sccaller:2.0.0--0
stdout: sccaller.out
