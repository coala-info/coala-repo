cwlVersion: v1.2
class: CommandLineTool
baseCommand: mimseq
label: mimseq
doc: "A tool for tRNA sequencing analysis (Note: The provided text is an error log
  and does not contain help information).\n\nTool homepage: https://github.com/nedialkova-lab/mim-tRNAseq"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mimseq:1.3.10--pyhdfd78af_0
stdout: mimseq.out
