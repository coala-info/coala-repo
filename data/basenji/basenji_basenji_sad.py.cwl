cwlVersion: v1.2
class: CommandLineTool
baseCommand: basenji_sad.py
label: basenji_basenji_sad.py
doc: "The provided text does not contain help information for the tool, but rather
  system error messages related to a container build failure (no space left on device).\n
  \nTool homepage: https://github.com/calico/basenji"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/basenji:0.6--pyhdfd78af_0
stdout: basenji_basenji_sad.py.out
