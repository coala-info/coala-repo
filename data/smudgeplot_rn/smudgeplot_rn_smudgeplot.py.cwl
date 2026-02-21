cwlVersion: v1.2
class: CommandLineTool
baseCommand: smudgeplot_rn_smudgeplot.py
label: smudgeplot_rn_smudgeplot.py
doc: "Smudgeplot tool (Note: The provided text is a container runtime error log and
  does not contain help documentation or argument definitions).\n\nTool homepage:
  https://github.com/RNieuwenhuis/smudgeplot"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/smudgeplot:0.5.3--py314h577a1d6_0
stdout: smudgeplot_rn_smudgeplot.py.out
