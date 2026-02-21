cwlVersion: v1.2
class: CommandLineTool
baseCommand: smartdenovo_wtgbo
label: smartdenovo_wtgbo
doc: "The provided text does not contain help information or usage instructions for
  the tool; it appears to be a container runtime error log.\n\nTool homepage: https://github.com/ruanjue/smartdenovo"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/smartdenovo:1.0.0--h7b50bb2_8
stdout: smartdenovo_wtgbo.out
