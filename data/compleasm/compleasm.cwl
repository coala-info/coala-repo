cwlVersion: v1.2
class: CommandLineTool
baseCommand: compleasm
label: compleasm
doc: "A tool for assessing genome assembly completeness (Note: The provided text contains
  system error logs regarding container execution and disk space rather than the tool's
  help documentation).\n\nTool homepage: https://github.com/huangnengCSU/compleasm"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/compleasm:0.2.7--pyh7e72e81_1
stdout: compleasm.out
