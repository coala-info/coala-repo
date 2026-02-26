cwlVersion: v1.2
class: CommandLineTool
baseCommand: FastK
label: fastk_FastK
doc: "FastK is a tool for k-mer counting and analysis.\n\nTool homepage: https://github.com/thegenemyers/FASTK"
inputs:
  - id: source
    type:
      type: array
      items: File
    doc: Input source file(s) (e.g., .cram, .sam, .bam, .db, .dam, .fasta, 
      .fastq, .fastq.gz)
    inputBinding:
      position: 1
  - id: homopolymer_compress
    type:
      - 'null'
      - boolean
    doc: Homopolymer compress every sequence
    inputBinding:
      position: 102
      prefix: -c
  - id: ignore_barcode_prefix
    type:
      - 'null'
      - int
    doc: Ignore prefix of each read of given length (e.g. bar code)
    inputBinding:
      position: 102
      prefix: -bc
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: k-mer size.
    default: 40
    inputBinding:
      position: 102
      prefix: -k
  - id: memory_gb
    type:
      - 'null'
      - int
    doc: Use -M GB of memory in downstream sorting steps of KMcount.
    default: 12
    inputBinding:
      position: 102
      prefix: -M
  - id: output_dir_prefix
    type:
      - 'null'
      - string
    doc: Use given path for output directory and root name prefix.
    inputBinding:
      position: 102
      prefix: -N
  - id: produce_table
    type:
      - 'null'
      - boolean
    doc: Produce table of sorted k-mers & counts >= level specified
    inputBinding:
      position: 102
      prefix: -t
  - id: profile_table
    type:
      - 'null'
      - File
    doc: Table file for sequence count profiles.
    inputBinding:
      position: 102
      prefix: -p
  - id: sequence_count_profiles
    type:
      - 'null'
      - boolean
    doc: Produce sequence count profiles (w.r.t. table if given)
    inputBinding:
      position: 102
      prefix: -p
  - id: sort_dir
    type:
      - 'null'
      - Directory
    doc: Place block level sorts in directory -P.
    default: $TMPDIR
    inputBinding:
      position: 102
      prefix: -P
  - id: table_level
    type:
      - 'null'
      - int
    doc: Minimum count level for producing table of sorted k-mers.
    inputBinding:
      position: 102
      prefix: -t
  - id: threads
    type:
      - 'null'
      - int
    doc: Use -T threads.
    default: 4
    inputBinding:
      position: 102
      prefix: -T
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose mode, output statistics as proceed.
    inputBinding:
      position: 102
      prefix: -v
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastk:1.2--h71df26d_1
stdout: fastk_FastK.out
