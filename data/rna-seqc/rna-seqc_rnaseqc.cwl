cwlVersion: v1.2
class: CommandLineTool
baseCommand: rnaseqc
label: rna-seqc_rnaseqc
doc: "RNA-SeQC is a tool for computing quality control metrics for RNA-seq data. (Note:
  The provided input text contains container runtime logs and a fatal error rather
  than the tool's help documentation, so no arguments could be extracted).\n\nTool
  homepage: https://github.com/broadinstitute/rnaseqc"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rna-seqc:2.4.2--h29c0135_1
stdout: rna-seqc_rnaseqc.out
