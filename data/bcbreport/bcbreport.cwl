cwlVersion: v1.2
class: CommandLineTool
baseCommand: bcbreport
label: bcbreport
doc: The provided text does not contain help information or a description of the tool;
  it is an error log indicating a failure to build a container image due to insufficient
  disk space.
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bcbreport:0.99.29--py35_0
stdout: bcbreport.out
