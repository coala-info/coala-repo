cwlVersion: v1.2
class: CommandLineTool
baseCommand: shortreadsconnector
label: shortreadsconnector
doc: 'A tool for connecting short reads (Note: The provided text is a container build
  error log and does not contain usage instructions or argument definitions).'
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/shortreadsconnector:1.1.3--0
stdout: shortreadsconnector.out
