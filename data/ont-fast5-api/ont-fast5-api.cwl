cwlVersion: v1.2
class: CommandLineTool
baseCommand: ont-fast5-api
label: ont-fast5-api
doc: "The provided text does not contain help information or a description of the
  tool. It is a system error message indicating a failure to build or run a container
  image due to insufficient disk space.\n\nTool homepage: https://github.com/nanoporetech/ont_fast5_api"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ont-fast5-api:4.1.3--pyhdfd78af_0
stdout: ont-fast5-api.out
