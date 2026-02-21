cwlVersion: v1.2
class: CommandLineTool
baseCommand: simple_sv_annotation_simple_sv_annotation.py
label: simple_sv_annotation_simple_sv_annotation.py
doc: "A tool for simple structural variant (SV) annotation. Note: The provided help
  text contains only system logs and error messages, so no specific arguments could
  be extracted.\n\nTool homepage: https://github.com/AstraZeneca-NGS/simple_sv_annotation"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/simple_sv_annotation:2019.02.18--py_0
stdout: simple_sv_annotation_simple_sv_annotation.py.out
