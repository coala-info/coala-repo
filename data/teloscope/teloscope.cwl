cwlVersion: v1.2
class: CommandLineTool
baseCommand: teloscope
label: teloscope
doc: "The provided text does not contain help information or a description of the
  tool; it is a log of a failed container image build/fetch process.\n\nTool homepage:
  https://github.com/vgl-hub/teloscope"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/teloscope:0.1.3--h35c04b2_0
stdout: teloscope.out
