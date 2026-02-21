cwlVersion: v1.2
class: CommandLineTool
baseCommand: snpick
label: snpick
doc: "The provided text does not contain a description of the tool; it is a log of
  a failed container image build/fetch process.\n\nTool homepage: https://github.com/PathoGenOmics-Lab/snpick"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snpick:1.0.0--h3f2c17f_0
stdout: snpick.out
