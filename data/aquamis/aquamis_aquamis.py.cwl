cwlVersion: v1.2
class: CommandLineTool
baseCommand: aquamis_aquamis.py
label: aquamis_aquamis.py
doc: "AQUAMIS (Assembly-based QUAlity control for Microbial Isolate Sequencing) is
  a tool for the quality control of microbial isolate sequencing data.\n\nTool homepage:
  https://gitlab.com/bfr_bioinformatics/AQUAMIS"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/aquamis:1.4.0--hdfd78af_0
stdout: aquamis_aquamis.py.out
