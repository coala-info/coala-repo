cwlVersion: v1.2
class: CommandLineTool
baseCommand: pstrain_PStrain.py
label: pstrain_PStrain.py
doc: "PStrain is a tool for profiling strains from metagenomic sequencing data. (Note:
  The provided help text contains only system error logs and does not list specific
  command-line arguments.)\n\nTool homepage: https://github.com/wshuai294/PStrain"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pstrain:1.0.3--h9ee0642_0
stdout: pstrain_PStrain.py.out
