cwlVersion: v1.2
class: CommandLineTool
baseCommand: gather_postproc.py
label: gather_postproc.py
doc: "A tool for post-processing gathered data. (Note: The provided help text contains
  only system error logs and no usage information; therefore, no arguments could be
  extracted.)\n\nTool homepage: https://github.com/Neuroimmunology-UiO/gather"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gather:1.0.1--pyh7e72e81_1
stdout: gather_postproc.py.out
