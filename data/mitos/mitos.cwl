cwlVersion: v1.2
class: CommandLineTool
baseCommand: mitos
label: mitos
doc: "The provided text does not contain help information for the tool. It is an error
  log indicating a failure to build a container image due to insufficient disk space.\n
  \nTool homepage: http://mitos.bioinf.uni-leipzig.de"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mitos:2.1.10--pyhdfd78af_0
stdout: mitos.out
