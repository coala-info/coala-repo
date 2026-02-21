cwlVersion: v1.2
class: CommandLineTool
baseCommand: mitos_runmitos.py
label: mitos_runmitos.py
doc: "Mitochondrial genome annotation (Note: The provided help text contains only
  system error messages regarding container execution and does not list command-line
  arguments).\n\nTool homepage: http://mitos.bioinf.uni-leipzig.de"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mitos:2.1.10--pyhdfd78af_0
stdout: mitos_runmitos.py.out
