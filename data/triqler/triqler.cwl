cwlVersion: v1.2
class: CommandLineTool
baseCommand: triqler
label: triqler
doc: "Triqler (TRansparent Identification-Quantification Linked Error Rate estimation)
  is a tool for protein-level quantification of differential expression. (Note: The
  provided input text was an error log and did not contain help documentation).\n\n
  Tool homepage: https://github.com/statisticalbiotechnology/triqler"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/triqler:0.9.1--pyhdfd78af_0
stdout: triqler.out
