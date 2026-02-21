cwlVersion: v1.2
class: CommandLineTool
baseCommand: cuppa
label: hmftools-cuppa
doc: "CUPPA (Cancer of Unknown Primary Prediction Algorithm)\n\nTool homepage: https://github.com/hartwigmedical/hmftools/blob/master/cuppa/README.md"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hmftools-cuppa:2.4--py311r42hdfd78af_0
stdout: hmftools-cuppa.out
