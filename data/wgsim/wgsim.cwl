cwlVersion: v1.2
class: CommandLineTool
baseCommand: wgsim
label: wgsim
doc: "short read simulator\n\nTool homepage: https://github.com/lh3/wgsim"
inputs:
  - id: input_ref_fa
    type: File
    doc: Input reference FASTA file
    inputBinding:
      position: 1
  - id: ambiguous_base_fraction_threshold
    type:
      - 'null'
      - float
    doc: disgard if the fraction of ambiguous bases higher than FLOAT
    inputBinding:
      position: 102
      prefix: -A
  - id: base_error_rate
    type:
      - 'null'
      - float
    doc: base error rate
    inputBinding:
      position: 102
      prefix: -e
  - id: haplotype_mode
    type:
      - 'null'
      - boolean
    doc: haplotype mode
    inputBinding:
      position: 102
      prefix: -h
  - id: indel_extension_prob
    type:
      - 'null'
      - float
    doc: probability an indel is extended
    inputBinding:
      position: 102
      prefix: -X
  - id: indel_fraction
    type:
      - 'null'
      - float
    doc: fraction of indels
    inputBinding:
      position: 102
      prefix: -R
  - id: length_read1
    type:
      - 'null'
      - int
    doc: length of the first read
    inputBinding:
      position: 102
      prefix: '-1'
  - id: length_read2
    type:
      - 'null'
      - int
    doc: length of the second read
    inputBinding:
      position: 102
      prefix: '-2'
  - id: mutation_rate
    type:
      - 'null'
      - float
    doc: rate of mutations
    inputBinding:
      position: 102
      prefix: -r
  - id: num_read_pairs
    type:
      - 'null'
      - int
    doc: number of read pairs
    inputBinding:
      position: 102
      prefix: -N
  - id: outer_distance
    type:
      - 'null'
      - int
    doc: outer distance between the two ends
    inputBinding:
      position: 102
      prefix: -d
  - id: random_seed
    type:
      - 'null'
      - int
    doc: seed for random generator
    inputBinding:
      position: 102
      prefix: -S
  - id: standard_deviation
    type:
      - 'null'
      - int
    doc: standard deviation
    inputBinding:
      position: 102
      prefix: -s
outputs:
  - id: output_read1_fq
    type: File
    doc: Output FASTQ file for read 1
    outputBinding:
      glob: '*.out'
  - id: output_read2_fq
    type: File
    doc: Output FASTQ file for read 2
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wgsim:1.0--h577a1d6_10
