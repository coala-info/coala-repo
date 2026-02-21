cwlVersion: v1.2
class: CommandLineTool
baseCommand: mmannot_createConfigFile
label: mmannot_createConfigFile
doc: "Create a configuration file for mmannot. (Note: The provided help text contains
  only container runtime error messages and does not list specific command-line arguments.)\n
  \nTool homepage: https://github.com/mzytnicki/mmannot"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mmannot:1.1--h077b44d_3
stdout: mmannot_createConfigFile.out
