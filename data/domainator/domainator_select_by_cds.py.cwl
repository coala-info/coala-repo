cwlVersion: v1.2
class: CommandLineTool
baseCommand: domainator_select_by_cds.py
label: domainator_select_by_cds.py
doc: "A tool from the Domainator suite, likely used for selecting sequences or records
  based on Coding Sequence (CDS) criteria. (Note: The provided help text contains
  only container runtime error messages and no argument definitions.)\n\nTool homepage:
  https://github.com/nebiolabs/domainator"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/domainator:0.8.0--pyhdfd78af_0
stdout: domainator_select_by_cds.py.out
