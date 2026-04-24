cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyfastx_sample
label: pyfastx_sample
doc: "Sample sequences from a FASTA or FASTQ file.\n\nTool homepage: https://github.com/lmdu/pyfastx"
inputs:
  - id: fastx
    type: File
    doc: fasta or fastq file, gzip support
    inputBinding:
      position: 1
  - id: number_of_sequences
    type:
      - 'null'
      - int
    doc: number of sequences to be sampled
    inputBinding:
      position: 102
      prefix: -n
  - id: proportion_of_sequences
    type:
      - 'null'
      - float
    doc: proportion of sequences to be sampled, 0~1
    inputBinding:
      position: 102
      prefix: -p
  - id: seed
    type:
      - 'null'
      - int
    doc: random seed
    inputBinding:
      position: 102
      prefix: --seed
  - id: sequential_read
    type:
      - 'null'
      - boolean
    doc: start sequential reading, particularly suitable for sampling large 
      numbers of sequences
    inputBinding:
      position: 102
      prefix: --sequential-read
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: output file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyfastx:2.3.0--py312h4711d71_1
