cwlVersion: v1.2
class: CommandLineTool
baseCommand: hymet2
label: hymet2
doc: "The provided text contains system error logs and does not include the tool's
  help documentation or usage instructions.\n\nTool homepage: https://github.com/inesbmartins02/HYMET2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hymet2:1.0.0--hdfd78af_0
stdout: hymet2.out
