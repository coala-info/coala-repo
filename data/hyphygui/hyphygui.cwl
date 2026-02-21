cwlVersion: v1.2
class: CommandLineTool
baseCommand: hyphygui
label: hyphygui
doc: 'HyPhy (Hypothesis testing using Phylogenies) Graphical User Interface. Note:
  The provided help text contains only system error messages regarding container execution
  and does not list specific command-line arguments.'
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/hyphygui:v2.2.7dfsg-1b2-deb_cv1
stdout: hyphygui.out
