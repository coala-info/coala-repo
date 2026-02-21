cwlVersion: v1.2
class: CommandLineTool
baseCommand: hl7
label: hl7
doc: "A tool for processing HL7 (Health Level Seven International) messages.\n\nTool
  homepage: https://github.com/hapifhir/hapi-fhir"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/hl7:v0.3.4-3-deb-py3_cv1
stdout: hl7.out
