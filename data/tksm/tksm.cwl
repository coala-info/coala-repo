cwlVersion: v1.2
class: CommandLineTool
baseCommand: tksm
label: tksm
doc: "tksm: Transcriptome Kernel-based Simulation Model. A modular framework for simulating
  long-read RNA-seq data.\n\nTool homepage: https://github.com/vpc-ccg/tksm"
inputs:
  - id: subcommand
    type: string
    doc: The subcommand to execute (kd, model, play, sequence, tag, unsegment, shuffler,
      transcribe, flip, polyA, or sc-tksm)
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tksm:0.6.1--py310ha025fb0_1
stdout: tksm.out
