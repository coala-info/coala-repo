cwlVersion: v1.2
class: CommandLineTool
baseCommand: fermi2 correct
label: fermi2_correct
doc: "Correct sequencing errors in reads using an FMD index.\n\nTool homepage: https://github.com/lh3/fermi2"
inputs:
  - id: index_file
    type: File
    doc: FMD index file
    inputBinding:
      position: 1
  - id: reads_file
    type:
      - 'null'
      - File
    doc: Input reads in FASTQ format. If absent, solid k-mers are dumped.
    inputBinding:
      position: 2
  - id: drop_error_prone_reads
    type:
      - 'null'
      - boolean
    doc: drop error-prone reads
    inputBinding:
      position: 103
      prefix: -D
  - id: kmer_length
    type:
      - 'null'
      - int
    doc: k-mer length
    default: 17
    inputBinding:
      position: 103
      prefix: -k
  - id: max_corrections_per_window
    type:
      - 'null'
      - int
    doc: no more than 4 corrections per INT-bp window
    default: 8
    inputBinding:
      position: 103
      prefix: -w
  - id: min_solid_kmer_occurrence
    type:
      - 'null'
      - int
    doc: min occurrence for a solid k-mer
    default: 3
    inputBinding:
      position: 103
      prefix: -o
  - id: print_original_read_name
    type:
      - 'null'
      - boolean
    doc: print the original read name
    inputBinding:
      position: 103
      prefix: -O
  - id: protect_q_bases
    type:
      - 'null'
      - int
    doc: protect Q>INT bases unless they occur once
    default: 30
    inputBinding:
      position: 103
      prefix: -q
  - id: singleton_correction_distance
    type:
      - 'null'
      - int
    doc: correct singletons out of INT bases
    default: 17
    inputBinding:
      position: 103
      prefix: -d
  - id: solid_kmer_file
    type:
      - 'null'
      - File
    doc: get solid k-mer list from FILE
    default: 'null'
    inputBinding:
      position: 103
      prefix: -h
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads
    default: 1
    inputBinding:
      position: 103
      prefix: -t
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fermi2:r193--h577a1d6_10
stdout: fermi2_correct.out
