cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - harpy
  - downsample
label: harpy_downsample
doc: "Downsample data using the harpy tool suite.\n\nTool homepage: https://github.com/pdimens/harpy/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/harpy:3.1--pyhdfd78af_2
stdout: harpy_downsample.out
