cwlVersion: v1.2
class: CommandLineTool
baseCommand: easydev
label: easydev
doc: "A Python library to help developers (no specific help text provided in the input)\n
  \nTool homepage: https://github.com/nisrulz/easydeviceinfo"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/easydev:v0.9.37-1-deb-py2_cv1
stdout: easydev.out
