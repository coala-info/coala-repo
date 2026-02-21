cwlVersion: v1.2
class: CommandLineTool
baseCommand: deepdirect_skempi_data_extract.py
label: deepdirect_skempi_data_extract.py
doc: "A tool for extracting SKEMPI data (Note: The provided help text contains only
  container runtime error messages and no usage information).\n\nTool homepage: https://github.com/Jappy0/deepdirect"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deepdirect:0.2.5--pyhdfd78af_0
stdout: deepdirect_skempi_data_extract.py.out
