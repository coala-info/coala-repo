cwlVersion: v1.2
class: CommandLineTool
baseCommand: suds-jurko
label: suds-jurko
doc: "The provided text does not contain help information or documentation for the
  suds-jurko tool; it is a log of a failed container build process.\n\nTool homepage:
  https://github.com/suds-community/suds"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/suds-jurko:0.6--py36_1
stdout: suds-jurko.out
