cwlVersion: v1.2
class: CommandLineTool
baseCommand: json2isatab
label: json2isatab
doc: "File path to ISA-JSON file\n\nTool homepage: https://github.com/phnmnl/container-json2isatab"
inputs:
  - id: json_file
    type: File
    doc: Path to ISA-JSON file
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/json2isatab:phenomenal-v0.9.4_cv0.5.39
stdout: json2isatab.out
