cwlVersion: v1.2
class: CommandLineTool
baseCommand: [pxfqfilt]
label: phyx_pxfqfilt
doc: |-
  Filter fastq files by mean quality.
  Data can be read from a file or STDIN.

  Tool homepage: https://github.com/FePhyFoFum/phyx
inputs:
  - id: mean
    type: float
    doc: "mean value under which seqs are filtered"
    inputBinding:
      prefix: -m
  - id: seq_file
    type: File
    doc: "input fastq file"
    inputBinding:
      prefix: -s
  - id: out_file_path
    type: string
    doc: "output sequence file name"
    inputBinding:
      prefix: -o
outputs:
  - id: out_file
    type: File
    doc: "filtered fastq file"
    outputBinding:
      glob: $(inputs.out_file_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyx:1.1--hc0837bd_5
