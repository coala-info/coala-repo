cwlVersion: v1.2
class: CommandLineTool
baseCommand: multi_to_single_fast5
label: ont-fast5-api_multi_to_single_fast5
doc: "A tool from the ont-fast5-api package to convert multi-read FAST5 files to single-read
  FAST5 files. (Note: The provided help text contains only system error logs and does
  not list specific command-line arguments).\n\nTool homepage: https://github.com/nanoporetech/ont_fast5_api"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ont-fast5-api:4.1.3--pyhdfd78af_0
stdout: ont-fast5-api_multi_to_single_fast5.out
