cwlVersion: v1.2
class: CommandLineTool
baseCommand: gen-fq
label: dna-nn_gen-fq
doc: "Generate FASTQ from FASTA and BED files.\n\nTool homepage: https://github.com/lh3/dna-nn"
inputs:
  - id: input_fasta
    type: File
    doc: Input FASTA file
    inputBinding:
      position: 1
  - id: input_bed
    type: File
    doc: Input BED file
    inputBinding:
      position: 2
  - id: max_label_length
    type:
      - 'null'
      - int
    doc: Maximum label length
    inputBinding:
      position: 103
      prefix: -m
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dna-nn:0.1--h077b44d_3
stdout: dna-nn_gen-fq.out
