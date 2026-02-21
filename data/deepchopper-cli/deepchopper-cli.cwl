cwlVersion: v1.2
class: CommandLineTool
baseCommand: deepchopper-cli
label: deepchopper-cli
doc: "DeepChopper is a tool for chopping long reads into short reads. (Note: The provided
  help text contains only system error messages and no usage information; arguments
  could not be extracted.)\n\nTool homepage: https://github.com/ylab-hi/DeepChopper"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deepchopper-cli:1.2.9--py310h9e6395a_0
stdout: deepchopper-cli.out
