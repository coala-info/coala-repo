cwlVersion: v1.2
class: CommandLineTool
baseCommand: smartdenovo_wtmsa
label: smartdenovo_wtmsa
doc: "A tool from the smartdenovo suite (Note: The provided help text contains only
  container build logs and no usage information).\n\nTool homepage: https://github.com/ruanjue/smartdenovo"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/smartdenovo:1.0.0--h7b50bb2_8
stdout: smartdenovo_wtmsa.out
