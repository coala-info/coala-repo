cwlVersion: v1.2
class: CommandLineTool
baseCommand: pydotplus
label: pydotplus
doc: "The provided text does not contain help information for the tool; it is an error
  log from a container build process.\n\nTool homepage: https://github.com/carlos-jenkins/pydotplus"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pydotplus:2.0.2--py36_0
stdout: pydotplus.out
