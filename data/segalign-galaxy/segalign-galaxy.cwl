cwlVersion: v1.2
class: CommandLineTool
baseCommand: segalign
label: segalign-galaxy
doc: "A tool for sequence alignment (Note: The provided text is a container build
  error log and does not contain CLI help information).\n\nTool homepage: https://github.com/gsneha26/SegAlign"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/segalign-galaxy:0.1.2.7--hdfd78af_2
stdout: segalign-galaxy.out
