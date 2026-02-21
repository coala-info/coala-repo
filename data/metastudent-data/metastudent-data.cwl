cwlVersion: v1.2
class: CommandLineTool
baseCommand: metastudent-data
label: metastudent-data
doc: 'A tool for managing or downloading data for Metastudent. (Note: The provided
  text contains only system error logs and no specific help documentation or arguments.)'
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/metastudent-data:v2.0.1-4-deb_cv1
stdout: metastudent-data.out
