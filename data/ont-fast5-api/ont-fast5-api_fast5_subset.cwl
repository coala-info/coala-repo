cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fast5_subset
label: ont-fast5-api_fast5_subset
doc: "The provided text does not contain help information or a description of the
  tool; it contains system log messages and a fatal error regarding disk space during
  a container build.\n\nTool homepage: https://github.com/nanoporetech/ont_fast5_api"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ont-fast5-api:4.1.3--pyhdfd78af_0
stdout: ont-fast5-api_fast5_subset.out
