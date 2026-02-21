cwlVersion: v1.2
class: CommandLineTool
baseCommand: velocyto.py
label: velocyto.py
doc: "The provided text is a container execution error log and does not contain help
  documentation or usage instructions for velocyto.py. No arguments could be extracted.\n
  \nTool homepage: https://github.com/velocyto-team/velocyto.py"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/velocyto.py:0.17.17--py38h24c8ff8_6
stdout: velocyto.py.out
