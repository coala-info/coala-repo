cwlVersion: v1.2
class: CommandLineTool
baseCommand: msisensor2
label: msisensor2
doc: "The provided text does not contain help information or usage instructions; it
  is a system error log indicating a failure to build a container image due to insufficient
  disk space.\n\nTool homepage: https://github.com/niu-lab/msisensor2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/msisensor2:0.1--h077b44d_4
stdout: msisensor2.out
