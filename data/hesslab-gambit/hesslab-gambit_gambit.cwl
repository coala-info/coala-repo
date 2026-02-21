cwlVersion: v1.2
class: CommandLineTool
baseCommand: gambit
label: hesslab-gambit_gambit
doc: "Gambit (Genomic Approximation Map-Based Identification Tool) is a tool for rapid
  taxonomic identification of microbial whole-genome sequencing reads or assemblies.\n
  \nTool homepage: https://github.com/hesslab-gambit/gambit"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hesslab-gambit:0.5.1--py39hbcbf7aa_1
stdout: hesslab-gambit_gambit.out
