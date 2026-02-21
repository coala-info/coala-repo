cwlVersion: v1.2
class: CommandLineTool
baseCommand: BICseq2-seg.pl
label: bicseq2-seg_BICseq2-seg.pl
doc: "BICseq2-seg (Note: The provided text contains system error messages regarding
  a container build failure and does not include the actual help documentation or
  usage instructions for the tool.)\n\nTool homepage: http://compbio.med.harvard.edu/BIC-seq/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bicseq2-seg:0.7.2--hec16e2b_3
stdout: bicseq2-seg_BICseq2-seg.pl.out
