cwlVersion: v1.2
class: CommandLineTool
baseCommand: umitools
label: umitools_simulate
doc: "See https://github.com/weng-lab/umitools for more information.\n           \
  \   For UMI RNA-seq: First, use umitools reformat_fastq to identify\n          \
  \    UMIs in UMI RNA-seq. Then, use umitools mark_duplicates to mark\n         \
  \     PCR duplicates. For UMI small RNA-seq: Use umitools\n              reformat_sra_fastq
  to identify UMIs and PCR duplicates. To\n              simulate UMIs, use umitools
  simulate.\n\nTool homepage: https://github.com/weng-lab/umitools"
inputs:
  - id: subcommand
    type: string
    doc: "See https://github.com/weng-lab/umitools for more information.\n       \
      \       For UMI RNA-seq: First, use umitools reformat_fastq to identify\n  \
      \            UMIs in UMI RNA-seq. Then, use umitools mark_duplicates to mark\n\
      \              PCR duplicates. For UMI small RNA-seq: Use umitools\n       \
      \       reformat_sra_fastq to identify UMIs and PCR duplicates. To\n       \
      \       simulate UMIs, use umitools simulate."
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/umitools:0.3.4--py36_0
stdout: umitools_simulate.out
