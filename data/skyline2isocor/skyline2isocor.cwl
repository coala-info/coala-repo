cwlVersion: v1.2
class: CommandLineTool
baseCommand: skyline2isocor
label: skyline2isocor
doc: "A tool to convert Skyline export files to IsoCor format.\n\nTool homepage: https://pypi.org/project/skyline2isocor/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/skyline2isocor:1.0.0--pyhdfd78af_0
stdout: skyline2isocor.out
