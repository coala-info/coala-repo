cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sshash
  - query
label: sshash_query
doc: "Query a SSHash dictionary with the k-mers of the reads or sequences in a FASTA
  or FASTQ file (streaming membership queries).\n\nTool homepage: https://github.com/jermp/sshash"
inputs:
  - id: index_filename
    type: File
    doc: 'REQUIRED: A file generated with the tool build.'
    inputBinding:
      position: 101
      prefix: -i
  - id: query_filename
    type: File
    doc: "REQUIRED: FASTA/FASTQ file (.fa/fasta or .fq/fastq extension), gzip-compressed
      or not."
    inputBinding:
      position: 101
      prefix: -q
  - id: multiline
    type:
      - 'null'
      - boolean
    doc: Use this option if more than one DNA line must be parsed after each 
      header. Only valid for FASTA files (not FASTQ).
    inputBinding:
      position: 101
      prefix: --multiline
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose output.
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sshash:5.0.0--haf24da9_0
stdout: sshash_query.out
