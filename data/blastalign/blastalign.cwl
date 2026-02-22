cwlVersion: v1.2
class: CommandLineTool
baseCommand: blastalign
label: blastalign
doc: The provided text does not contain help information or usage instructions 
  for the tool. It consists of system error messages related to container 
  execution and disk space issues.
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/blastalign:1.4--py36pl5.22.0_2
stdout: blastalign.out
