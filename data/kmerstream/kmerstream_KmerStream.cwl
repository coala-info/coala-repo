cwlVersion: v1.2
class: CommandLineTool
baseCommand: KmerStream
label: kmerstream_KmerStream
doc: "Estimates occurrences of k-mers in fastq or fasta files and saves results\n\n\
  Tool homepage: https://github.com/pmelsted/KmerStream"
inputs:
  - id: fastq_files
    type:
      type: array
      items: File
    doc: FASTQ files
    inputBinding:
      position: 1
  - id: error_rate
    type:
      - 'null'
      - float
    doc: Error rate guaranteed
    inputBinding:
      position: 102
      prefix: --error-rate
  - id: input_bam
    type:
      - 'null'
      - boolean
    doc: Input is in BAM format
    inputBinding:
      position: 102
      prefix: --bam
  - id: kmer_size
    type:
      - 'null'
      - string
    doc: Size of k-mers, either a single value or comma separated list
    inputBinding:
      position: 102
      prefix: --kmer-size
  - id: online
    type:
      - 'null'
      - boolean
    doc: Prints out estimates every 100K reads
    inputBinding:
      position: 102
      prefix: --online
  - id: output_binary
    type:
      - 'null'
      - boolean
    doc: Output is written in binary format
    inputBinding:
      position: 102
      prefix: --binary
  - id: output_tsv
    type:
      - 'null'
      - boolean
    doc: Output is written in TSV format
    inputBinding:
      position: 102
      prefix: --tsv
  - id: phred64
    type:
      - 'null'
      - boolean
    doc: set if PHRED+64 scores are used (@...h) default used PHRED+33
    inputBinding:
      position: 102
      prefix: --q64
  - id: quality_cutoff
    type:
      - 'null'
      - string
    doc: Comma separated list, keep k-mers with bases above quality threshold in
      PHRED
    inputBinding:
      position: 102
      prefix: --quality-cutoff
  - id: seed
    type:
      - 'null'
      - int
    doc: Seed value for the randomness (default value 0, use time based 
      randomness)
    inputBinding:
      position: 102
      prefix: --seed
  - id: threads
    type:
      - 'null'
      - int
    doc: SNumber of threads to use
    inputBinding:
      position: 102
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print lots of messages during run
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Filename for output
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kmerstream:1.1--h077b44d_6
