cwlVersion: v1.2
class: CommandLineTool
baseCommand: deepchopper
label: deepchopper-cli_deepchopper
doc: "DeepChopper is a tool for genomic data processing (Note: Help text provided
  was a container runtime error and did not contain specific argument details).\n\n
  Tool homepage: https://github.com/ylab-hi/DeepChopper"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deepchopper-cli:1.2.9--py310h9e6395a_0
stdout: deepchopper-cli_deepchopper.out
