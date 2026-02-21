cwlVersion: v1.2
class: CommandLineTool
baseCommand: freddie_freddie_split.py
label: freddie_freddie_split.py
doc: "A tool for splitting data within the FREDDIE pipeline. (Note: The provided help
  text contains only system error messages and no argument definitions.)\n\nTool homepage:
  https://github.com/vpc-ccg/freddie"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/freddie:0.4--hdfd78af_0
stdout: freddie_freddie_split.py.out
