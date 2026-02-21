cwlVersion: v1.2
class: CommandLineTool
baseCommand: smartdenovo_wtclp
label: smartdenovo_wtclp
doc: "The provided text does not contain help information for the tool. It appears
  to be a log of a failed container image retrieval/build process.\n\nTool homepage:
  https://github.com/ruanjue/smartdenovo"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/smartdenovo:1.0.0--h7b50bb2_8
stdout: smartdenovo_wtclp.out
