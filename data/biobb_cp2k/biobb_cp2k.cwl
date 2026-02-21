cwlVersion: v1.2
class: CommandLineTool
baseCommand: biobb_cp2k
label: biobb_cp2k
doc: "The provided text does not contain help information or usage instructions. It
  appears to be a system error log indicating a failure to build or extract a container
  image due to insufficient disk space ('no space left on device').\n\nTool homepage:
  https://github.com/bioexcel/biobb_cp2k"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biobb_cp2k:5.2.0--pyhdfd78af_0
stdout: biobb_cp2k.out
