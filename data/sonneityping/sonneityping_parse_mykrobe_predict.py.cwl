cwlVersion: v1.2
class: CommandLineTool
baseCommand: sonneityping_parse_mykrobe_predict.py
label: sonneityping_parse_mykrobe_predict.py
doc: "Parse Mykrobe predict results for sonneityping. (Note: The provided text contains
  container runtime logs and error messages rather than the tool's help documentation;
  therefore, no arguments could be extracted.)\n\nTool homepage: https://github.com/katholt/sonneityping"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sonneityping:20210201
stdout: sonneityping_parse_mykrobe_predict.py.out
