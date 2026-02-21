cwlVersion: v1.2
class: CommandLineTool
baseCommand: hapsolo_hapsolo.py
label: hapsolo_hapsolo.py
doc: "HapSolo is a tool for identifying and removing haplotypic duplication in genomic
  assemblies.\n\nTool homepage: https://github.com/esolares/HapSolo"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hapsolo:2021.10.09--py27hdfd78af_0
stdout: hapsolo_hapsolo.py.out
