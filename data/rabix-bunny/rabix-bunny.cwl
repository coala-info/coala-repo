cwlVersion: v1.2
class: CommandLineTool
baseCommand: rabix
label: rabix-bunny
doc: "Rabix Bunny is an execution engine for Common Workflow Language (CWL). Note:
  The provided text appears to be a container engine error log rather than help text,
  so no arguments could be extracted.\n\nTool homepage: https://github.com/rabix/bunny"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rabix-bunny:1.0.4--0
stdout: rabix-bunny.out
