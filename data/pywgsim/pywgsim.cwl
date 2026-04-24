cwlVersion: v1.2
class: CommandLineTool
baseCommand: pywgsim
label: pywgsim
doc: "Short read simulator for paired end reads based on wgsim.\n\nTool homepage:
  https://github.com/ialbert/pywgsim"
inputs:
  - id: genome
    type: File
    doc: FASTA reference sequence
    inputBinding:
      position: 1
  - id: read1
    type:
      - 'null'
      - File
    doc: FASTQ file for first in pair (read1.fq)
    inputBinding:
      position: 2
  - id: read2
    type:
      - 'null'
      - File
    doc: FASTQ file for second in pair (read2.fq)
    inputBinding:
      position: 3
  - id: ambiguous_base_fraction
    type:
      - 'null'
      - float
    doc: disregard if the fraction of ambiguous bases higher than FLOAT
    inputBinding:
      position: 104
      prefix: --amb
  - id: error_rate
    type:
      - 'null'
      - float
    doc: the base error rate
    inputBinding:
      position: 104
      prefix: --err
  - id: fixed_chromosome_sequences
    type:
      - 'null'
      - boolean
    doc: each chromosome gets N sequences
    inputBinding:
      position: 104
      prefix: --fixed
  - id: indel_extension_probability
    type:
      - 'null'
      - float
    doc: probability an indel is extended
    inputBinding:
      position: 104
      prefix: --ext
  - id: indel_fraction
    type:
      - 'null'
      - float
    doc: fraction of indels
    inputBinding:
      position: 104
      prefix: --frac
  - id: mutation_rate
    type:
      - 'null'
      - float
    doc: rate of mutations
    inputBinding:
      position: 104
      prefix: --mut
  - id: num_read_pairs
    type:
      - 'null'
      - int
    doc: number of read pairs
    inputBinding:
      position: 104
      prefix: --num
  - id: outer_distance
    type:
      - 'null'
      - int
    doc: outer distance between the two ends
    inputBinding:
      position: 104
      prefix: --dist
  - id: random_seed
    type:
      - 'null'
      - int
    doc: seed for the random generator
    inputBinding:
      position: 104
      prefix: --seed
  - id: read1_length
    type:
      - 'null'
      - int
    doc: length of the first read
    inputBinding:
      position: 104
      prefix: --L1
  - id: read2_length
    type:
      - 'null'
      - int
    doc: length of the second read
    inputBinding:
      position: 104
      prefix: --L2
  - id: standard_deviation
    type:
      - 'null'
      - int
    doc: standard deviation
    inputBinding:
      position: 104
      prefix: --stdev
outputs:
  - id: gff_output_file
    type:
      - 'null'
      - File
    doc: GFF output file
    outputBinding:
      glob: $(inputs.gff_output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pywgsim:0.6.0--py310h397c9d8_0
