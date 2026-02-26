cwlVersion: v1.2
class: CommandLineTool
baseCommand: skyline2isocor
label: skyline2isocor
doc: "Convert Skyline export files to IsoCor input format.\n\nTool homepage: https://pypi.org/project/skyline2isocor/"
inputs:
  - id: input_file
    type: File
    doc: The Skyline export file (CSV or TSV) to be converted.
    inputBinding:
      position: 1
outputs:
  - id: output_file
    type: File
    doc: The destination path for the converted IsoCor-compatible file.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/skyline2isocor:1.0.0--pyhdfd78af_0
