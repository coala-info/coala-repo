cwlVersion: v1.2
class: CommandLineTool
baseCommand: eva-sub-cli
label: eva-sub-cli
doc: "The provided text does not contain help information; it is an error log indicating
  a failure to pull or build the container image due to insufficient disk space.\n
  \nTool homepage: https://github.com/EBIvariation/eva-sub-cli"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/eva-sub-cli:0.5.3--py313hdfd78af_0
stdout: eva-sub-cli.out
