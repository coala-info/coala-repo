cwlVersion: v1.2
class: CommandLineTool
baseCommand: emirge_emirge_makedb.py
label: emirge_emirge_makedb.py
doc: "The provided text does not contain help information for the tool; it contains
  system error messages related to a container runtime failure (no space left on device).\n
  \nTool homepage: https://github.com/csmiller/EMIRGE"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/emirge:0.61.1--py27_1
stdout: emirge_emirge_makedb.py.out
