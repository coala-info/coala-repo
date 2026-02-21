cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - demux_fast5
label: ont-fast5-api_demux_fast5
doc: "The provided text does not contain help information for the tool. It appears
  to be a system error log indicating a failure to build a container image due to
  insufficient disk space.\n\nTool homepage: https://github.com/nanoporetech/ont_fast5_api"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ont-fast5-api:4.1.3--pyhdfd78af_0
stdout: ont-fast5-api_demux_fast5.out
