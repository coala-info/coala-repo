cwlVersion: v1.2
class: CommandLineTool
baseCommand: grepq
label: grepq_Count
doc: "Searches the sequence line of FASTQ records for regular expressions that are
  contained in a text or JSON file, or it searches for the absence of those regular
  expressions when used with the `inverted` command. The FASTQ file on which it operates
  can be supplied uncompressed or in gzip or zstd compressed format.\n\nTool homepage:
  https://github.com/Rbfinch/grepq"
inputs:
  - id: patterns
    type: File
    doc: Path to the patterns file in plain text or JSON format
    inputBinding:
      position: 1
  - id: file
    type: File
    doc: Path to the FASTQ file in plain text or gzip compressed format
    inputBinding:
      position: 2
  - id: command
    type:
      - 'null'
      - string
    doc: Command to execute (tune, inverted, summarise, help)
    inputBinding:
      position: 3
  - id: best
    type:
      - 'null'
      - boolean
    doc: Use best compression
    inputBinding:
      position: 104
      prefix: --best
  - id: bucket
    type:
      - 'null'
      - boolean
    doc: Write matched sequences to separate files named after each regexName
    inputBinding:
      position: 104
      prefix: --bucket
  - id: count
    type:
      - 'null'
      - boolean
    doc: Count the number of matching FASTQ records
    inputBinding:
      position: 104
      prefix: --count
  - id: fast
    type:
      - 'null'
      - boolean
    doc: Use fast compression
    inputBinding:
      position: 104
      prefix: --fast
  - id: fasta
    type:
      - 'null'
      - boolean
    doc: Output in FASTA format
    inputBinding:
      position: 104
      prefix: --fasta
  - id: include_id
    type:
      - 'null'
      - boolean
    doc: Include record ID in the output
    inputBinding:
      position: 104
      prefix: --includeID
  - id: include_record
    type:
      - 'null'
      - boolean
    doc: Include record ID, sequence, separator, and quality field in the output
      (i.e. FASTQ format)
    inputBinding:
      position: 104
      prefix: --includeRecord
  - id: num_tetranucleotides
    type:
      - 'null'
      - int
    doc: Limit the number of tetranucleotides written to the TNF field of the 
      fastq_data SQLite table, these being the most or equal most frequent 
      tetranucleotides in the sequence field of the matched FASTQ records
    inputBinding:
      position: 104
      prefix: --num-tetranucleotides
  - id: read_gzip
    type:
      - 'null'
      - boolean
    doc: Read the FASTQ file in gzip compressed format
    inputBinding:
      position: 104
      prefix: --read-gzip
  - id: read_zstd
    type:
      - 'null'
      - boolean
    doc: Read the FASTQ file in zstd compressed format
    inputBinding:
      position: 104
      prefix: --read-zstd
  - id: write_gzip
    type:
      - 'null'
      - boolean
    doc: Write the output in gzip compressed format
    inputBinding:
      position: 104
      prefix: --write-gzip
  - id: write_sql
    type:
      - 'null'
      - boolean
    doc: Write matching records to SQLite database, along with length of the 
      sequence field (length), percent GC content (GC), percent GC content as an
      integer (GC_int), number of unique tetranucleotides in the sequence (nTN),
      percent tetranucleotide frequency within the sequence (TNF), and average 
      quality score for the sequence field (average_quality)
    inputBinding:
      position: 104
      prefix: --writeSQL
  - id: write_zstd
    type:
      - 'null'
      - boolean
    doc: Write the output in zstd compressed format
    inputBinding:
      position: 104
      prefix: --write-zstd
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/grepq:1.5.4--h6ce8773_0
stdout: grepq_Count.out
