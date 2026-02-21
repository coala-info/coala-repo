cwlVersion: v1.2
class: CommandLineTool
baseCommand: StrainScan.py
label: strainscan_StrainScan.py
doc: "StrainScan is a tool for strain-level identification and quantification. (Note:
  The provided help text contains only container execution errors and no usage information.)\n
  \nTool homepage: https://github.com/liaoherui/StrainScan"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/strainscan:1.0.14--pyhdfd78af_1
stdout: strainscan_StrainScan.py.out
