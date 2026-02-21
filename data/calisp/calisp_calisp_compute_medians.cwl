cwlVersion: v1.2
class: CommandLineTool
baseCommand: calisp
label: calisp_calisp_compute_medians
doc: "The provided text does not contain help information for the tool. It is an error
  log indicating a failure to extract the container image due to lack of disk space.\n
  \nTool homepage: https://github.com/kinestetika/Calisp"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/calisp:3.1.4--pyhdfd78af_0
stdout: calisp_calisp_compute_medians.out
