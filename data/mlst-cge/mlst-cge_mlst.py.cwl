cwlVersion: v1.2
class: CommandLineTool
baseCommand: mlst-cge_mlst.py
label: mlst-cge_mlst.py
doc: "MLST (Multi-Locus Sequence Typing) tool from the Center for Genomic Epidemiology
  (CGE).\n\nTool homepage: https://bitbucket.org/genomicepidemiology/mlst"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mlst-cge:2.0.9--hdfd78af_0
stdout: mlst-cge_mlst.py.out
