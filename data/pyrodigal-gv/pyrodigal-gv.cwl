cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyrodigal-gv
label: pyrodigal-gv
doc: "The provided text does not contain help information, but appears to be a container
  execution error log. Pyrodigal-gv is a tool for gene prediction in giant virus genomes.\n
  \nTool homepage: https://github.com/althonos/pyrodigal-gv"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyrodigal-gv:0.3.2--pyh7e72e81_0
stdout: pyrodigal-gv.out
