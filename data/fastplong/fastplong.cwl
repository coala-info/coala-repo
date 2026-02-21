cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastplong
label: fastplong
doc: "A tool for long-read quality control and preprocessing.\n\nTool homepage: https://github.com/OpenGene/fastplong"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastplong:0.4.1--h224cc79_0
stdout: fastplong.out
