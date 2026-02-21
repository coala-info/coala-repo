cwlVersion: v1.2
class: CommandLineTool
baseCommand: dampa
label: dampa
doc: "The provided text does not contain help information or a description of the
  tool; it is a system error log indicating a failure to build or run a container
  due to insufficient disk space.\n\nTool homepage: https://github.com/MultipathogenGenomics/dampa"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dampa:0.2.0--pyhdfd78af_0
stdout: dampa.out
