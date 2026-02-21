cwlVersion: v1.2
class: CommandLineTool
baseCommand: amos
label: amos
doc: "The provided text does not contain help information for the tool 'amos'. It
  consists of system logs and an error message indicating that the executable was
  not found in the environment.\n\nTool homepage: https://github.com/pku-liang/AMOS"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/amos:3.1.0--py27pl5.22.0_3
stdout: amos.out
