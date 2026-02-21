cwlVersion: v1.2
class: CommandLineTool
baseCommand: telometer
label: telometer
doc: "A tool for telomere length estimation (Note: The provided text contains container
  build logs rather than command-line help documentation; therefore, no arguments
  could be extracted).\n\nTool homepage: https://github.com/santiago-es/Telometer"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/telometer:1.1--pyhdfd78af_0
stdout: telometer.out
