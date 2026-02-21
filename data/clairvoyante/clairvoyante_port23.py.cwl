cwlVersion: v1.2
class: CommandLineTool
baseCommand: clairvoyante_port23.py
label: clairvoyante_port23.py
doc: "The provided text is an error log from a container build process and does not
  contain help information or argument definitions for the tool.\n\nTool homepage:
  https://github.com/aquaskyline/Clairvoyante"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/clairvoyante:1.02--0
stdout: clairvoyante_port23.py.out
