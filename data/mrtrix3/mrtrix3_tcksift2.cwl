cwlVersion: v1.2
class: CommandLineTool
baseCommand: tcksift2
label: mrtrix3_tcksift2
doc: "The provided text does not contain help information for the tool. It appears
  to be a container runtime error log indicating a failure to build or pull the image
  due to insufficient disk space ('no space left on device').\n\nTool homepage: https://www.mrtrix.org"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
stdout: mrtrix3_tcksift2.out
