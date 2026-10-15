cwlVersion: v1.2
class: CommandLineTool
baseCommand: [pxboot]
label: phyx_pxboot
doc: |-
  Sequence alignment bootstrap or jackknife resampling.
  This will take fasta, fastq, phylip, and nexus formats from a file or STDIN.

  Tool homepage: https://github.com/FePhyFoFum/phyx
inputs:
  - id: seq_file
    type: File
    doc: "input sequence file (fasta, fastq, phylip or nexus)"
    inputBinding:
      prefix: -s
  - id: out_file_path
    type: string
    doc: "output sequence file name"
    inputBinding:
      prefix: -o
  - id: part_file
    type: ['null', File]
    doc: "file listing empirical partitions: NAME = START-STOP[\\INTERVAL]"
    inputBinding:
      prefix: -p
  - id: frac
    type: ['null', float]
    doc: "jackknife percentage, default bootstrap (i.e. -f 1.0)"
    inputBinding:
      prefix: -f
  - id: seed
    type: ['null', int]
    doc: "random number seed, clock otherwise"
    inputBinding:
      prefix: -x
outputs:
  - id: out_file
    type: File
    doc: "resampled alignment (fasta)"
    outputBinding:
      glob: $(inputs.out_file_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyx:1.1--hc0837bd_5
