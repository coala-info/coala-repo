cwlVersion: v1.2
class: CommandLineTool
baseCommand: soi
label: soi
doc: "The provided text does not contain help information or a description for the
  tool 'soi'. It appears to be an error log from a container build process.\n\nTool
  homepage: https://github.com/zhangrengang/SOI/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/soi:1.2.3--pyhdfd78af_0
stdout: soi.out
