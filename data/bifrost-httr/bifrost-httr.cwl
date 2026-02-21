cwlVersion: v1.2
class: CommandLineTool
baseCommand: bifrost-httr
label: bifrost-httr
doc: "The provided text does not contain help information for the tool, but rather
  log messages indicating a failure to build or extract the container image due to
  insufficient disk space.\n\nTool homepage: https://github.com/seqera-services/bifrost-httr"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bifrost-httr:0.5.0--pyhdfd78af_0
stdout: bifrost-httr.out
