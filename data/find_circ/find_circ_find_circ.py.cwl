cwlVersion: v1.2
class: CommandLineTool
baseCommand: find_circ_find_circ.py
label: find_circ_find_circ.py
doc: "The provided text does not contain help information or usage instructions; it
  contains system error messages related to a container runtime environment failure
  (no space left on device).\n\nTool homepage: https://github.com/marvin-jens/find_circ"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/find_differential_primers:0.1.4--py_0
stdout: find_circ_find_circ.py.out
