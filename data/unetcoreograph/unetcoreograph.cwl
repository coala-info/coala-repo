cwlVersion: v1.2
class: CommandLineTool
baseCommand: unetcoreograph
label: unetcoreograph
doc: "A tool for processing or analyzing images, likely related to UNet architectures
  (description not provided in help text).\n\nTool homepage: https://github.com/HMS-IDAC/UNetCoreograph"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/unetcoreograph:2.4.6--hdfd78af_0
stdout: unetcoreograph.out
