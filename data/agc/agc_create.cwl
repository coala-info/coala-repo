cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - agc
  - create
label: agc_create
doc: "AGC (Assembled Genomes Compressor) - Create a compressed archive from assembled
  genomes in FASTA format.\n\nTool homepage: https://github.com/refresh-bio/agc"
inputs:
  - id: reference_fasta
    type: File
    doc: Reference FASTA file
    inputBinding:
      position: 1
  - id: input_fastas
    type:
      - 'null'
      - type: array
        items: File
    doc: Additional input FASTA files to compress
    inputBinding:
      position: 2
  - id: adaptive_mode
    type:
      - 'null'
      - boolean
    doc: adaptive mode
    default: false
    inputBinding:
      position: 103
      prefix: -a
  - id: batch_size
    type:
      - 'null'
      - int
    doc: 'batch size (min: 1; max: 1000000000)'
    default: 50
    inputBinding:
      position: 103
      prefix: -b
  - id: concatenated_genomes
    type:
      - 'null'
      - boolean
    doc: concatenated genomes in a single file
    default: false
    inputBinding:
      position: 103
      prefix: -c
  - id: do_not_store_cmd_line
    type:
      - 'null'
      - boolean
    doc: do not store cmd-line
    default: true
    inputBinding:
      position: 103
      prefix: -d
  - id: fallback_minimizers_fraction
    type:
      - 'null'
      - float
    doc: 'fraction of fall-back minimizers (min: 0.000000; max: 0.050000)'
    default: 0.0
    inputBinding:
      position: 103
      prefix: -f
  - id: input_file_list
    type:
      - 'null'
      - File
    doc: file with FASTA file names (alternative to listing file names explicitly
      in command line)
    inputBinding:
      position: 103
      prefix: -i
  - id: kmer_length
    type:
      - 'null'
      - int
    doc: 'k-mer length (min: 17; max: 32)'
    default: 31
    inputBinding:
      position: 103
      prefix: -k
  - id: min_match_length
    type:
      - 'null'
      - int
    doc: 'min. match length (min: 15; max: 32)'
    default: 20
    inputBinding:
      position: 103
      prefix: -l
  - id: segment_size
    type:
      - 'null'
      - int
    doc: 'expected segment size (min: 100; max: 1000000)'
    default: 60000
    inputBinding:
      position: 103
      prefix: -s
  - id: threads
    type:
      - 'null'
      - int
    doc: 'no of threads (min: 1; max: 56)'
    default: 28
    inputBinding:
      position: 103
      prefix: -t
  - id: verbosity
    type:
      - 'null'
      - int
    doc: 'verbosity level (min: 0; max: 2)'
    default: 0
    inputBinding:
      position: 103
      prefix: -v
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: 'output to file (default: output is sent to stdout)'
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/agc:3.2.1--h9ee0642_0
