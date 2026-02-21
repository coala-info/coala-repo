cwlVersion: v1.2
class: CommandLineTool
baseCommand: kegalign-full_split_input.py
label: kegalign-full_split_input.py
doc: "The provided text does not contain help information for the tool, but appears
  to be a container runtime error log indicating a failure to build a SIF image due
  to lack of disk space.\n\nTool homepage: https://github.com/galaxyproject/KegAlign"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kegalign-full:0.1.2.8--hdfd78af_0
stdout: kegalign-full_split_input.py.out
