cwlVersion: v1.2
class: CommandLineTool
baseCommand: SolexaQA++
label: solexaqa_SolexaQA++
doc: "SolexaQA++ is a software package for calculating quality statistics and trimming
  Illumina (Solexa) second-generation sequencing data. (Note: The provided help text
  contains only container runtime error messages and no CLI usage information.)\n\n
  Tool homepage: http://solexaqa.sourceforge.net/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/solexaqa:3.1.7.1--h6f6f108_7
stdout: solexaqa_SolexaQA++.out
