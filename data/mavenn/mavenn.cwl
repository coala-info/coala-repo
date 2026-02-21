cwlVersion: v1.2
class: CommandLineTool
baseCommand: mavenn
label: mavenn
doc: "MAVE-NN (Multiplexed Assays of Variant Effect Neural Network) is a tool for
  inferring quantitative models of genotype-phenotype maps from MAVE datasets.\n\n
  Tool homepage: http://mavenn.readthedocs.io"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mavenn:1.1.3--pyhdfd78af_0
stdout: mavenn.out
