cwlVersion: v1.2
class: CommandLineTool
baseCommand: amber.py
label: cami-amber
doc: "AMBER: Assessment of Metagenome BinnERs. A tool for evaluating metagenome binners
  based on the CAMI (Critical Assessment of Metagenome Interpretation) benchmarks.\n
  \nTool homepage: https://github.com/CAMI-challenge/AMBER"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cami-amber:2.0.7--pyhdfd78af_0
stdout: cami-amber.out
