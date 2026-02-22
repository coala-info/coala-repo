cwlVersion: v1.2
class: CommandLineTool
baseCommand: annosine2
label: annosine2
doc: "A tool for annotation (description not available in provided text)\n\nTool homepage:
  https://github.com/liaoherui/AnnoSINE"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/annosine2:2.0.9--pyh7e72e81_0
stdout: annosine2.out
