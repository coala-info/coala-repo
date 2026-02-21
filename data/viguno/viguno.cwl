cwlVersion: v1.2
class: CommandLineTool
baseCommand: viguno
label: viguno
doc: "The provided text does not contain help information or usage instructions for
  the tool 'viguno'. It appears to be a system log showing a failure to pull or build
  a container image.\n\nTool homepage: https://github.com/bihealth/viguno"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viguno:0.4.0--h13c227e_0
stdout: viguno.out
