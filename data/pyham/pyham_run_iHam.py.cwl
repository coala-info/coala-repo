cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyham_run_iHam.py
label: pyham_run_iHam.py
doc: "Phylogenetic HOG Analysis Method (pyHam) runner for iHam.\n\nTool homepage:
  https://github.com/DessimozLab/pyham"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyham:1.1.11--pyh7cba7a3_0
stdout: pyham_run_iHam.py.out
