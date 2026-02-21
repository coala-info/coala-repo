cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fasten
  - repair
label: fasten_fasten_repair
doc: "The provided text contains only system error messages and does not include help
  documentation for the tool. No arguments could be extracted.\n\nTool homepage: https://github.com/lskatz/fasten"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fasten:0.9.0--hc1c3326_0
stdout: fasten_fasten_repair.out
