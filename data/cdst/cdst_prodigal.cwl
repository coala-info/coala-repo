cwlVersion: v1.2
class: CommandLineTool
baseCommand: cdst_prodigal
label: cdst_prodigal
doc: "The provided text does not contain help documentation for the tool. It consists
  of system logs and a fatal error message regarding a container build failure (no
  space left on device).\n\nTool homepage: https://github.com/l1-mh/CDST"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cdst:0.2.1--pyhdfd78af_0
stdout: cdst_prodigal.out
