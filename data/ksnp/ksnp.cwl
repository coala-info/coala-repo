cwlVersion: v1.2
class: CommandLineTool
baseCommand: ksnp
label: ksnp
doc: "The provided text does not contain help information for the tool. It is an error
  message indicating a failure to build a container image due to insufficient disk
  space.\n\nTool homepage: https://github.com/zhouqiansolab/KSNP"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ksnp:1.0.3--h077b44d_2
stdout: ksnp.out
