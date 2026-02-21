cwlVersion: v1.2
class: CommandLineTool
baseCommand: embl-api-validator
label: embl-api-validator
doc: "A tool for validating EMBL API data/formats.\n\nTool homepage: http://www.ebi.ac.uk/ena/software/flat-file-validator"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/embl-api-validator:1.1.180--1
stdout: embl-api-validator.out
