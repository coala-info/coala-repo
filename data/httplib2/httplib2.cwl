cwlVersion: v1.2
class: CommandLineTool
baseCommand: httplib2
label: httplib2
doc: "The provided text does not contain help information for the tool. It appears
  to be a system error log regarding a container build failure (no space left on device).\n
  \nTool homepage: https://github.com/httplib2/httplib2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/httplib2:0.9.2--py35_0
stdout: httplib2.out
