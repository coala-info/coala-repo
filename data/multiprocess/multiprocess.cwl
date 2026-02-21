cwlVersion: v1.2
class: CommandLineTool
baseCommand: multiprocess
label: multiprocess
doc: "A Python package that provides enhanced multiprocessing capabilities. (Note:
  The provided input text was an error log from a container runtime and did not contain
  CLI help documentation.)\n\nTool homepage: https://github.com/slact/nchan"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/multiprocess:0.70.4--py36_0
stdout: multiprocess.out
