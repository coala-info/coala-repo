cwlVersion: v1.2
class: CommandLineTool
baseCommand: fast5_compress
label: ont-fast5-api_fast5_compress
doc: "The provided text does not contain help information. It is an error message
  indicating a failure to pull a container image due to insufficient disk space. No
  arguments could be extracted from the input.\n\nTool homepage: https://github.com/nanoporetech/ont_fast5_api"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ont-fast5-api:4.1.3--pyhdfd78af_0
stdout: ont-fast5-api_fast5_compress.out
