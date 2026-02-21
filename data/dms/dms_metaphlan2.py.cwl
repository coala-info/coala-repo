cwlVersion: v1.2
class: CommandLineTool
baseCommand: dms_metaphlan2.py
label: dms_metaphlan2.py
doc: "A tool for MetaPhlAn2 analysis. Note: The provided help text contains only container
  runtime error messages and does not list command-line arguments.\n\nTool homepage:
  https://github.com/qibebt-bioinfo/dynamic-meta-storms"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dms:1.1--h9948957_2
stdout: dms_metaphlan2.py.out
