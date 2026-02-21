cwlVersion: v1.2
class: CommandLineTool
baseCommand: aletsch_score.py
label: aletsch_score.py
doc: "A tool for scoring in the aletsch software suite. Note: The provided help text
  contains system error messages regarding a container build failure and does not
  list specific command-line arguments.\n\nTool homepage: https://github.com/Shao-Group/aletsch"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/aletsch:1.1.3--h503566f_1
stdout: aletsch_score.py.out
