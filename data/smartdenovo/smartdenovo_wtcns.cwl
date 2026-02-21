cwlVersion: v1.2
class: CommandLineTool
baseCommand: smartdenovo_wtcns
label: smartdenovo_wtcns
doc: "The provided text contains container runtime error logs and does not include
  help information or usage instructions for the tool.\n\nTool homepage: https://github.com/ruanjue/smartdenovo"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/smartdenovo:1.0.0--h7b50bb2_8
stdout: smartdenovo_wtcns.out
