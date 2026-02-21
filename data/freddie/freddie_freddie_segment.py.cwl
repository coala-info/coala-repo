cwlVersion: v1.2
class: CommandLineTool
baseCommand: freddie_freddie_segment.py
label: freddie_freddie_segment.py
doc: "A tool for segmentation (Note: The provided help text contains only system error
  messages and no usage information).\n\nTool homepage: https://github.com/vpc-ccg/freddie"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/freddie:0.4--hdfd78af_0
stdout: freddie_freddie_segment.py.out
