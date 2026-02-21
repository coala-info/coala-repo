cwlVersion: v1.2
class: CommandLineTool
baseCommand: ncbi-amr
label: ncbi-amr
doc: "The provided text does not contain help documentation or usage instructions.
  It contains a system error message indicating a failure to build or convert a container
  image due to insufficient disk space ('no space left on device').\n\nTool homepage:
  https://github.com/ncbi/amr/wiki"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ncbi-amr:1.04--h6bb024c_0
stdout: ncbi-amr.out
