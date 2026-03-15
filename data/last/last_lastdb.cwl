cwlVersion: v1.2
class: CommandLineTool
baseCommand: lastdb
label: last_lastdb
doc: Prepare sequences for subsequent alignment with lastal.
inputs:
  - id: output_name
    type: string
    doc: Output name for the database files
    inputBinding:
      position: 1
  - id: fasta_sequence_files
    type:
      type: array
      items: File
    doc: Input FASTA sequence file(s)
    inputBinding:
      position: 2
  - id: proteins
    type:
      - 'null'
      - boolean
    doc: interpret the sequences as proteins
    inputBinding:
      position: 103
      prefix: -p
  - id: soft_mask
    type:
      - 'null'
      - boolean
    doc: soft-mask lowercase letters (in reference *and* query sequences)
    inputBinding:
      position: 103
      prefix: -c
  - id: seeding_scheme
    type:
      - 'null'
      - string
    doc: 'seeding scheme (default: YASS if DNA, else PSEUDO if -q, else exact-match)'
    inputBinding:
      position: 103
      prefix: -u
  - id: parallel_threads
    type:
      - 'null'
      - int
    doc: number of parallel threads
    inputBinding:
      position: 103
      prefix: -P
  - id: proteins_append_stop
    type:
      - 'null'
      - boolean
    doc: interpret the sequences as proteins and append */STOP
    inputBinding:
      position: 103
      prefix: -q
  - id: strand
    type:
      - 'null'
      - int
    doc: 'strand: 0=reverse, 1=forward, 2=both'
    inputBinding:
      position: 103
      prefix: -S
  - id: lowercase_simple_sequence_options
    type:
      - 'null'
      - string
    doc: 'lowercase & simple-sequence options (default: 03 for -q, else 01)'
    inputBinding:
      position: 103
      prefix: -R
  - id: max_tandem_repeat_unit_length
    type:
      - 'null'
      - int
    doc: 'maximum tandem repeat unit length (protein: 50, DNA: 100 or 400)'
    inputBinding:
      position: 103
      prefix: -U
  - id: initial_matches_step
    type:
      - 'null'
      - int
    doc: use initial matches starting at every w-th position in each sequence
    inputBinding:
      position: 103
      prefix: -w
  - id: sliding_window_min_positions
    type:
      - 'null'
      - int
    doc: use "minimum" positions in sliding windows of W consecutive positions
    inputBinding:
      position: 103
      prefix: -W
  - id: input_format
    type:
      - 'null'
      - string
    doc: 'input format: fastx, keep, sanger, solexa, illumina'
    inputBinding:
      position: 103
      prefix: -Q
  - id: volume_size
    type:
      - 'null'
      - string
    doc: volume size
    inputBinding:
      position: 103
      prefix: -s
  - id: seed_patterns
    type:
      - 'null'
      - string
    doc: seed patterns (1=match, 0=anything, @=transition)
    inputBinding:
      position: 103
      prefix: -m
  - id: dna_seed_patterns
    type:
      - 'null'
      - string
    doc: DNA seed patterns (N=match, n=anything, R=purine match, etc.)
    inputBinding:
      position: 103
      prefix: -d
  - id: user_defined_alphabet
    type:
      - 'null'
      - string
    doc: user-defined alphabet
    inputBinding:
      position: 103
      prefix: -a
  - id: min_initial_matches_limit
    type:
      - 'null'
      - int
    doc: minimum limit on initial matches per query position
    inputBinding:
      position: 103
      prefix: -i
  - id: max_bucket_length
    type:
      - 'null'
      - int
    doc: maximum length for buckets
    inputBinding:
      position: 103
      prefix: -b
  - id: bucket_memory_ratio
    type:
      - 'null'
      - int
    doc: use max bucket length with memory <= (memory for stored positions) / B
    inputBinding:
      position: 103
      prefix: -B
  - id: child_table_type
    type:
      - 'null'
      - int
    doc: 'child table type: 0=none, 1=byte-size, 2=short-size, 3=full'
    inputBinding:
      position: 103
      prefix: -C
  - id: count_only
    type:
      - 'null'
      - boolean
    doc: just count sequences and letters
    inputBinding:
      position: 103
      prefix: -x
  - id: print_all_sequences
    type:
      - 'null'
      - boolean
    doc: print all sequences in lastdb files
    inputBinding:
      position: 103
      prefix: -D
  - id: bits_per_base
    type:
      - 'null'
      - int
    doc: use this many bits per base for DNA sequence
    inputBinding:
      position: 103
      prefix: --bits
  - id: circular
    type:
      - 'null'
      - boolean
    doc: these sequences are circular
    inputBinding:
      position: 103
      prefix: --circular
outputs:
  - id: out_output_name
    type:
      type: array
      items: File
    doc: Output name for the database files
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/last:1650--h5ca1c30_0
s:url: https://gitlab.com/mcfrith/last
$namespaces:
  s: https://schema.org/
