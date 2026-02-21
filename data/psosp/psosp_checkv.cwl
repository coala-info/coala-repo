cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - psosp
  - checkv
label: psosp_checkv
doc: "The provided text does not contain help information or a description of the
  tool; it is an error log from a container build process.\n\nTool homepage: https://github.com/mujiezhang/PSOSP"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/psosp:1.1.2--pyhdfd78af_2
stdout: psosp_checkv.out
