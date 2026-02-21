cwlVersion: v1.2
class: CommandLineTool
baseCommand: quickmirseq_QuickMIRSeq.pl
label: quickmirseq_QuickMIRSeq.pl
doc: "QuickMIRSeq is a pipeline for the analysis of miRNA-seq data, including quantification
  of known miRNAs and isomiRs.\n\nTool homepage: https://sourceforge.net/projects/quickmirseq/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/quickmirseq:1.0.0--hdfd78af_3
stdout: quickmirseq_QuickMIRSeq.pl.out
