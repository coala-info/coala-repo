cwlVersion: v1.2
class: CommandLineTool
baseCommand: editdistance
label: editdistance
doc: "The provided text does not contain help information or usage instructions; it
  consists of system logs and a fatal error regarding container image creation.\n\n
  Tool homepage: https://github.com/roy-ht/editdistance"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/editdistance:0.4--py36_0
stdout: editdistance.out
