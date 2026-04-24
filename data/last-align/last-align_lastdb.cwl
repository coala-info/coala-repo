cwlVersion: v1.2
class: CommandLineTool
baseCommand: lastdb
label: last-align_lastdb
doc: "Prepare sequences for subsequent alignment with lastal.\n\nTool homepage: https://gitlab.com/mcfrith/last"
inputs:
  - id: output_name
    type: string
    doc: Name for the output database
    inputBinding:
      position: 1
  - id: fasta_sequence_files
    type:
      type: array
      items: File
    doc: Fasta sequence file(s) to prepare
    inputBinding:
      position: 2
  - id: bucket_depth
    type:
      - 'null'
      - string
    doc: Bucket depth
    inputBinding:
      position: 103
      prefix: -b
  - id: child_table_type
    type:
      - 'null'
      - int
    doc: 'Child table type: 0=none, 1=byte-size, 2=short-size, 3=full'
    inputBinding:
      position: 103
      prefix: -C
  - id: count_sequences_and_letters
    type:
      - 'null'
      - boolean
    doc: Just count sequences and letters
    inputBinding:
      position: 103
      prefix: -x
  - id: initial_match_interval
    type:
      - 'null'
      - int
    doc: Use initial matches starting at every w-th position in each sequence
    inputBinding:
      position: 103
      prefix: -w
  - id: input_format
    type:
      - 'null'
      - int
    doc: 'Input format: 0=fasta or fastq-ignore, 1=fastq-sanger, 2=fastq-solexa, 3=fastq-illumina'
    inputBinding:
      position: 103
      prefix: -Q
  - id: interpret_as_proteins
    type:
      - 'null'
      - boolean
    doc: Interpret the sequences as proteins
    inputBinding:
      position: 103
      prefix: -p
  - id: min_limit_initial_matches
    type:
      - 'null'
      - int
    doc: Minimum limit on initial matches per query position
    inputBinding:
      position: 103
      prefix: -i
  - id: min_positions_in_window
    type:
      - 'null'
      - int
    doc: Use "minimum" positions in sliding windows of W consecutive positions
    inputBinding:
      position: 103
      prefix: -W
  - id: parallel_threads
    type:
      - 'null'
      - int
    doc: Number of parallel threads
    inputBinding:
      position: 103
      prefix: -P
  - id: repeat_marking_options
    type:
      - 'null'
      - int
    doc: Repeat-marking options
    inputBinding:
      position: 103
      prefix: -R
  - id: seed_pattern
    type:
      - 'null'
      - string
    doc: Seed pattern
    inputBinding:
      position: 103
      prefix: -m
  - id: seeding_scheme
    type:
      - 'null'
      - string
    doc: 'Seeding scheme (default: YASS for DNA, else exact-match seeds)'
    inputBinding:
      position: 103
      prefix: -u
  - id: soft_mask_lowercase
    type:
      - 'null'
      - boolean
    doc: Soft-mask lowercase letters (in reference *and* query sequences)
    inputBinding:
      position: 103
      prefix: -c
  - id: strand
    type:
      - 'null'
      - int
    doc: 'Strand: 0=reverse, 1=forward, 2=both'
    inputBinding:
      position: 103
      prefix: -S
  - id: user_alphabet
    type:
      - 'null'
      - string
    doc: User-defined alphabet
    inputBinding:
      position: 103
      prefix: -a
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: 'Be verbose: write messages about what lastdb is doing'
    inputBinding:
      position: 103
      prefix: -v
  - id: volume_size
    type:
      - 'null'
      - string
    doc: Volume size (unlimited)
    inputBinding:
      position: 103
      prefix: -s
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/last-align:v963-2-deb_cv1
stdout: last-align_lastdb.out
