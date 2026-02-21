cwlVersion: v1.2
class: CommandLineTool
baseCommand: hypercluster
label: hypercluster
doc: "The provided text does not contain help information; it is a system error log
  indicating a failure to build the container image due to insufficient disk space.\n
  \nTool homepage: https://github.com/liliblu/hypercluster"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hypercluster:0.1.13--0
stdout: hypercluster.out
