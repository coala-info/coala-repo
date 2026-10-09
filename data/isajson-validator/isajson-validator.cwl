cwlVersion: v1.2
class: CommandLineTool
label: isajson-validator
doc: "Validate an ISA JSON file with the ISA API. The container entrypoint is
  run_validator.py, which takes the ISA JSON file as its only argument and writes
  report.json in the working directory.\n\nTool homepage: https://github.com/phnmnl/container-isajson-validator"
inputs:
  - id: isajson_file
    type: File
    doc: Path to ISA JSON file
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: report
    type:
      - 'null'
      - File
    doc: Validation report in JSON format
    outputBinding:
      glob: report.json
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/isajson-validator:phenomenal-v0.9.4_cv0.4.38
stdout: isajson-validator.out
