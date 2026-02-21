cwlVersion: v1.2
class: CommandLineTool
baseCommand: longcallr_asj_to_bed.py
label: longcallr_asj_to_bed.py
doc: "A tool to convert ASJ format to BED format.\n\nTool homepage: https://github.com/huangnengCSU/longcallR"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/longcallr:1.12.0--py312h67e1f27_0
stdout: longcallr_asj_to_bed.py.out
