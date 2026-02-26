cwlVersion: v1.2
class: CommandLineTool
baseCommand: java -jar simulator.jar
label: curesim
doc: "CuReSim version 1.3\n\nTool homepage: https://github.com/BenKearns/CureSim"
inputs:
  - id: deletion_rate
    type:
      - 'null'
      - float
    doc: deletion rate
    default: 0.01
    inputBinding:
      position: 101
      prefix: -d
  - id: input_file
    type: File
    doc: genome fasta file or reads fastq file
    inputBinding:
      position: 101
      prefix: -f
  - id: insertion_rate
    type:
      - 'null'
      - float
    doc: insertion rate
    default: 0.005
    inputBinding:
      position: 101
      prefix: -i
  - id: max_ns_per_read
    type:
      - 'null'
      - int
    doc: maximum number of Ns allowed per read
    default: 0
    inputBinding:
      position: 101
      prefix: -N
  - id: mean_read_size
    type:
      - 'null'
      - int
    doc: read mean size
    default: 200
    inputBinding:
      position: 101
      prefix: -m
  - id: num_random_reads
    type:
      - 'null'
      - int
    doc: number of random reads
    default: 0
    inputBinding:
      position: 101
      prefix: -r
  - id: num_reads
    type:
      - 'null'
      - int
    doc: number of reads to generate
    default: 50000
    inputBinding:
      position: 101
      prefix: -n
  - id: quality_encoding_char
    type:
      - 'null'
      - string
    doc: quality encoding character
    default: "'5'"
    inputBinding:
      position: 101
      prefix: -q
  - id: skip_correction
    type:
      - 'null'
      - boolean
    doc: skip the correction step
    default: false
    inputBinding:
      position: 101
      prefix: -skip
  - id: std_dev_read_size
    type:
      - 'null'
      - float
    doc: standard deviation for read size
    default: 20.0
    inputBinding:
      position: 101
      prefix: -sd
  - id: substitution_rate
    type:
      - 'null'
      - float
    doc: substitution rate
    default: 0.005
    inputBinding:
      position: 101
      prefix: -s
  - id: uniform_indels
    type:
      - 'null'
      - boolean
    doc: uniform distribution for indels
    inputBinding:
      position: 101
      prefix: -ui
  - id: uniform_substitutions
    type:
      - 'null'
      - boolean
    doc: uniform distribution for substitutions
    inputBinding:
      position: 101
      prefix: -us
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: verbose mode, you need R software in this mode
    default: false
    inputBinding:
      position: 101
      prefix: -v
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: name of output fastq file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/curesim:1.3--0
