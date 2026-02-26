cwlVersion: v1.2
class: CommandLineTool
baseCommand: mmft_gc
label: mmft_gc
doc: "Calculate GC content of fasta file records.\n\nTool homepage: https://github.com/ARU-life-sciences/mmft"
inputs:
  - id: fasta_files
    type:
      type: array
      items: File
    doc: Input fasta file path(s).
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mmft:0.3.2--hc1c3326_0
stdout: mmft_gc.out
