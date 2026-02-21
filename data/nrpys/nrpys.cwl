cwlVersion: v1.2
class: CommandLineTool
baseCommand: nrpys
label: nrpys
doc: "The provided text does not contain help information or usage instructions; it
  is a set of error logs indicating a failure to build a container image due to insufficient
  disk space.\n\nTool homepage: https://github.com/kblin/nrpys"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nrpys:0.1.1--py311ha96b9cd_5
stdout: nrpys.out
