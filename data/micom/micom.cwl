cwlVersion: v1.2
class: CommandLineTool
baseCommand: micom
label: micom
doc: "MICOM is a Python package for metabolic modeling of microbial communities. (Note:
  The provided text is an error log and does not contain help information.)\n\nTool
  homepage: https://github.com/micom-dev/micom"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/micom:0.37.1--pyhdfd78af_0
stdout: micom.out
