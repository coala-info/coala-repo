cwlVersion: v1.2
class: CommandLineTool
baseCommand: cerberus.py
label: cerberus-x_cerberus.py
doc: "The provided text does not contain help information or a description of the
  tool. It appears to be a system error log indicating a failure to build a container
  image due to lack of disk space.\n\nTool homepage: https://github.com/raw-lab/cerberus"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cerberus-x:1.5.0--pyhdfd78af_0
stdout: cerberus-x_cerberus.py.out
