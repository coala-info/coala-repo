cwlVersion: v1.2
class: CommandLineTool
baseCommand: mutamr
label: mutamr
doc: "The provided text does not contain help information for the tool 'mutamr'. It
  appears to be a system error log indicating a failure to build a container image
  due to lack of disk space.\n\nTool homepage: https://github.com/MDU-PHL/mutamr"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mutamr:0.0.2--pyhdfd78af_0
stdout: mutamr.out
