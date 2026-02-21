cwlVersion: v1.2
class: CommandLineTool
baseCommand: rna-seqc
label: rna-seqc
doc: "RNA-SeQC is a tool for computing quality control metrics for RNA-seq data. (Note:
  The provided text is a system error log and does not contain help documentation
  or argument definitions.)\n\nTool homepage: https://github.com/broadinstitute/rnaseqc"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rna-seqc:2.4.2--h29c0135_1
stdout: rna-seqc.out
