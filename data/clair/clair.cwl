cwlVersion: v1.2
class: CommandLineTool
baseCommand: clair
label: clair
doc: "Clair is an open source project for the static analysis of vulnerabilities in
  application containers (currently including OCI and docker).\n\nTool homepage: https://github.com/HKU-BAL/Clair"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/clair:2.1.1--hdfd78af_1
stdout: clair.out
