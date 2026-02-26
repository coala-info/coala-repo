cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sylph
  - sketch
label: sylph_sketch
doc: "Sketch sequences into samples (reads) and databases (genomes). Each sample.fq
  -> sample.sylsp. All *.fa -> *.syldb\n\nTool homepage: https://github.com/bluenote-1577/sylph"
inputs:
  - id: files
    type:
      - 'null'
      - type: array
        items: File
    doc: 'fasta/fastq files; gzip optional. Default: fastq file produces a sample
      sketch (*.sylsp) while fasta files are combined into a database (*.syldb).'
    inputBinding:
      position: 1
  - id: db_out_name
    type:
      - 'null'
      - string
    doc: Output name for database sketch (with .syldb appended)
    default: database
    inputBinding:
      position: 102
      prefix: --out-name-db
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Debug output
    inputBinding:
      position: 102
      prefix: --debug
  - id: first_pairs
    type:
      - 'null'
      - type: array
        items: File
    doc: First pairs for paired end reads
    inputBinding:
      position: 102
      prefix: --first-pairs
  - id: fpr
    type:
      - 'null'
      - float
    doc: False positive rate for read deduplicate hashing; valid values in 
      [0,1).
    default: 0.0001
    inputBinding:
      position: 102
      prefix: --fpr
  - id: genomes
    type:
      - 'null'
      - type: array
        items: File
    doc: Genomes in fasta format
    inputBinding:
      position: 102
      prefix: --genomes
  - id: individual_records
    type:
      - 'null'
      - boolean
    doc: Use individual records (contigs) for database construction
    inputBinding:
      position: 102
      prefix: --individual-records
  - id: k
    type:
      - 'null'
      - int
    doc: Value of k. Only k = 21, 31 are currently supported
    default: 31
    inputBinding:
      position: 102
      prefix: -k
  - id: list_first_pair
    type:
      - 'null'
      - File
    doc: Newline delimited file; inputs are first pair of PE reads
    inputBinding:
      position: 102
      prefix: --l1
  - id: list_genomes
    type:
      - 'null'
      - File
    doc: Newline delimited file; inputs assumed genomes
    inputBinding:
      position: 102
      prefix: --gl
  - id: list_sample_names
    type:
      - 'null'
      - File
    doc: Newline delimited file; read sketches are renamed to given sample names
    inputBinding:
      position: 102
      prefix: --lS
  - id: list_second_pair
    type:
      - 'null'
      - File
    doc: Newline delimited file; inputs are second pair of PE reads
    inputBinding:
      position: 102
      prefix: --l2
  - id: list_sequence
    type:
      - 'null'
      - File
    doc: Newline delimited file with inputs; fastas -> database, fastq -> sample
    inputBinding:
      position: 102
      prefix: -l
  - id: min_spacing_kmer
    type:
      - 'null'
      - int
    doc: Minimum spacing between selected k-mers on the genomes
    default: 30
    inputBinding:
      position: 102
      prefix: --min-spacing
  - id: no_dedup
    type:
      - 'null'
      - boolean
    doc: Disable read deduplication procedure. Reduces memory; not recommended 
      for illumina data
    inputBinding:
      position: 102
      prefix: --no-dedup
  - id: reads
    type:
      - 'null'
      - type: array
        items: File
    doc: Single-end fasta/fastq reads
    inputBinding:
      position: 102
      prefix: --reads
  - id: sample_names
    type:
      - 'null'
      - type: array
        items: string
    doc: Read sketches are renamed to given sample names
    inputBinding:
      position: 102
      prefix: -S
  - id: sample_output_directory
    type:
      - 'null'
      - Directory
    doc: Output directory for sample sketches
    default: ./
    inputBinding:
      position: 102
      prefix: --sample-output-directory
  - id: second_pairs
    type:
      - 'null'
      - type: array
        items: File
    doc: Second pairs for paired end reads
    inputBinding:
      position: 102
      prefix: --second-pairs
  - id: subsampling_rate
    type:
      - 'null'
      - int
    doc: Subsampling rate
    default: 200
    inputBinding:
      position: 102
      prefix: -c
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    default: 3
    inputBinding:
      position: 102
      prefix: -t
  - id: trace
    type:
      - 'null'
      - boolean
    doc: 'Trace output (caution: very verbose)'
    inputBinding:
      position: 102
      prefix: --trace
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sylph:0.9.0--ha6fb395_0
stdout: sylph_sketch.out
