cwlVersion: v1.2
class: CommandLineTool
baseCommand: indelible
label: indelible_indelible.py
doc: "INDELible is a powerful and flexible simulator of biological sequence evolution.
  (Note: The provided help text contains only system error logs and no argument definitions).\n
  \nTool homepage: https://github.com/HurlesGroupSanger/indelible"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/indelible:v1.03-4-deb_cv1
stdout: indelible_indelible.py.out
