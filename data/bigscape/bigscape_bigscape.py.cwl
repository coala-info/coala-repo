cwlVersion: v1.2
class: CommandLineTool
baseCommand: bigscape.py
label: bigscape_bigscape.py
doc: "The provided text does not contain help information or a description of the
  tool; it is an error log indicating a failure to build/extract a container image
  due to insufficient disk space.\n\nTool homepage: https://github.com/medema-group/BiG-SCAPE"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bigscape:2.0.2--pyhdfd78af_0
stdout: bigscape_bigscape.py.out
