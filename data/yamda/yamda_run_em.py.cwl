cwlVersion: v1.2
class: CommandLineTool
baseCommand: yamda_run_em.py
label: yamda_run_em.py
doc: "The provided text does not contain help information or usage instructions for
  the tool. It appears to be a log of a failed container build or execution process.\n
  \nTool homepage: https://github.com/daquang/YAMDA"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/yamda:0.1.00e9c9d--py_0
stdout: yamda_run_em.py.out
