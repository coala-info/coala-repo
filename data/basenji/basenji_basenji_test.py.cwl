cwlVersion: v1.2
class: CommandLineTool
baseCommand: basenji_test.py
label: basenji_basenji_test.py
doc: "The provided text does not contain help information for the tool. It appears
  to be a system error log regarding a failed container build (no space left on device).\n
  \nTool homepage: https://github.com/calico/basenji"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/basenji:0.6--pyhdfd78af_0
stdout: basenji_basenji_test.py.out
