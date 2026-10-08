cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - grepq
label: grepq
doc: "Quickly filter FASTQ files: print the records whose sequence matches any regex pattern from a text or JSON pattern file, with optional record IDs, FASTQ/FASTA output, counts, per-pattern bucket files or a SQLite database.\n\nTool homepage: https://github.com/Rbfinch/grepq"
inputs:
  - id: output_name
    type: string
    default: grepq_output.txt
    doc: "Name of the file that receives the standard output."
  - id: include_id
    type:
      - 'null'
      - boolean
    doc: "Include record ID in the output"
    inputBinding:
      position: 1
      prefix: --includeID
  - id: include_record
    type:
      - 'null'
      - boolean
    doc: "Include record ID, sequence, separator, and quality field in the output (i.e. FASTQ format)"
    inputBinding:
      position: 1
      prefix: --includeRecord
  - id: fasta
    type:
      - 'null'
      - boolean
    doc: "Output in FASTA format"
    inputBinding:
      position: 1
      prefix: --fasta
  - id: count
    type:
      - 'null'
      - boolean
    doc: "Count the number of matching FASTQ records"
    inputBinding:
      position: 1
      prefix: --count
  - id: read_gzip
    type:
      - 'null'
      - boolean
    doc: "Read the FASTQ file in gzip compressed format"
    inputBinding:
      position: 1
      prefix: --read-gzip
  - id: write_gzip
    type:
      - 'null'
      - boolean
    doc: "Write the output in gzip compressed format"
    inputBinding:
      position: 1
      prefix: --write-gzip
  - id: read_zstd
    type:
      - 'null'
      - boolean
    doc: "Read the FASTQ file in zstd compressed format"
    inputBinding:
      position: 1
      prefix: --read-zstd
  - id: write_zstd
    type:
      - 'null'
      - boolean
    doc: "Write the output in zstd compressed format"
    inputBinding:
      position: 1
      prefix: --write-zstd
  - id: fast
    type:
      - 'null'
      - boolean
    doc: "Use fast compression"
    inputBinding:
      position: 1
      prefix: --fast
  - id: best
    type:
      - 'null'
      - boolean
    doc: "Use best compression"
    inputBinding:
      position: 1
      prefix: --best
  - id: bucket
    type:
      - 'null'
      - boolean
    doc: "Write matched sequences to separate files named after each regexName"
    inputBinding:
      position: 1
      prefix: --bucket
  - id: write_sql
    type:
      - 'null'
      - boolean
    doc: "Write matching records to a SQLite database (fastq_*.db) with sequence length, GC content, tetranucleotide counts and frequencies, and average quality"
    inputBinding:
      position: 1
      prefix: --writeSQL
  - id: num_tetranucleotides
    type:
      - 'null'
      - int
    doc: "Limit the number of tetranucleotides written to the TNF field of the fastq_data SQLite table"
    inputBinding:
      position: 1
      prefix: --num-tetranucleotides
  - id: patterns
    type: File
    doc: "Patterns file in plain text (one regex per line) or JSON format."
    inputBinding:
      position: 2
  - id: fastq
    type: File
    doc: "FASTQ file in plain text, gzip or zstd compressed format."
    inputBinding:
      position: 3
outputs:
  - id: output
    type: stdout
    doc: "Matching sequences, records or counts (format set by the options)."
  - id: bucket_files
    type: File[]
    doc: "Per-pattern files named after each regexName (with --bucket)."
    outputBinding:
      glob: "*.fastq*"
      outputEval: $(self.filter(function(f) { return f.basename != inputs.output_name; }))
  - id: sqlite_db
    type:
      - 'null'
      - File
    doc: "SQLite database fastq_*.db (with --writeSQL)."
    outputBinding:
      glob: fastq_*.db
stdout: $(inputs.output_name)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/grepq:1.5.4--h6ce8773_0
