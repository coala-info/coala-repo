cwlVersion: v1.2
class: CommandLineTool
baseCommand: solexaqa
label: solexaqa
doc: "SolexaQA is a software package for calculating quality statistics and creating
  visual representations of data quality from Illumina (formerly Solexa) second-generation
  sequencing technology.\n\nTool homepage: http://solexaqa.sourceforge.net/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/solexaqa:3.1.7.1--h6f6f108_7
stdout: solexaqa.out
