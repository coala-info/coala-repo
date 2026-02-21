cwlVersion: v1.2
class: CommandLineTool
baseCommand: repeatscout
label: repeatscout
doc: "The provided text does not contain help information or usage instructions for
  the tool. It contains container runtime logs and a fatal error message regarding
  an image build failure.\n\nTool homepage: https://github.com/Dfam-consortium/RepeatScout"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/repeatscout:1.0.7--h7b50bb2_1
stdout: repeatscout.out
