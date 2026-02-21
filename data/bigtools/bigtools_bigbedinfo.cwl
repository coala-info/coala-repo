cwlVersion: v1.2
class: CommandLineTool
baseCommand: bigbedinfo
label: bigtools_bigbedinfo
doc: "The provided text does not contain help information or a description for the
  tool, as it is an error log reporting a failure to build/extract a container image
  due to lack of disk space.\n\nTool homepage: https://github.com/jackh726/bigtools/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bigtools:0.5.6--hc1c3326_1
stdout: bigtools_bigbedinfo.out
