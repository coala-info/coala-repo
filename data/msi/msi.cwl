cwlVersion: v1.2
class: CommandLineTool
baseCommand: msi
label: msi
doc: "The provided text is a system error message (out of disk space) encountered
  while attempting to run the 'msi' tool via a container, and does not contain help
  documentation or argument definitions.\n\nTool homepage: http://github.com/nunofonseca/msi/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/msi:0.3.8--hdfd78af_0
stdout: msi.out
