cwlVersion: v1.2
class: CommandLineTool
baseCommand: cdbfasta
label: cdbtools_cdbfasta
doc: "Creates an index file for records from a multi-fasta file. By default (without
  -m/-n/-c/-C option), only the first space-delimited token from the defline is used
  as a key.\n\nTool homepage: https://github.com/gpertea/cdbfasta"
inputs:
  - id: fasta_file
    type: File
    doc: The multi-fasta file to index
    inputBinding:
      position: 1
  - id: index_file
    type:
      - 'null'
      - string
    doc: Name of the index file (-o). Default is the fasta file name plus the 
      suffix '.cidx', written in the output directory.
  - id: record_delimiter
    type:
      - 'null'
      - string
    doc: "A string of characters at the beginning of line marking the start of a
      record (default: '>')"
    inputBinding:
      position: 3
      prefix: -r
  - id: fastq
    type:
      - 'null'
      - boolean
    doc: Treat input as fastq format, i.e. with '@' as record delimiter and with
      records expected to have at least 4 lines
    inputBinding:
      position: 3
      prefix: -Q
  - id: compressed_db
    type:
      - 'null'
      - string
    doc: Database is compressed into the file <compressed_db> before indexing
    inputBinding:
      position: 3
      prefix: -z
  - id: strip_chars
    type:
      - 'null'
      - string
    doc: Strip extraneous characters from *around* the space delimited tokens, 
      for the multikey options (-m,-n,-f)
    inputBinding:
      position: 3
      prefix: -s
  - id: multi_key
    type:
      - 'null'
      - boolean
    doc: ("multi-key" option) create hash entries pointing to the same record 
      for all tokens found in the defline
    inputBinding:
      position: 3
      prefix: -m
  - id: num_keys
    type:
      - 'null'
      - int
    doc: Same as -m, but only takes the first <numkeys> tokens from the defline
    inputBinding:
      position: 3
      prefix: -n
  - id: fields
    type:
      - 'null'
      - string
    doc: Indexes *space* delimited tokens (fields) in the defline as given by 
      LIST of fields or fields ranges (the same syntax as UNIX 'cut')
    inputBinding:
      position: 3
      prefix: -f
      separate: false
  - id: stopwords
    type:
      - 'null'
      - File
    doc: Exclude from indexing all the words found in this file (for options -m,
      -n and -k)
    inputBinding:
      position: 3
      prefix: -w
  - id: case_insensitive
    type:
      - 'null'
      - boolean
    doc: Do case insensitive indexing (create additional keys for all-lowercase 
      tokens used for indexing from the defline)
    inputBinding:
      position: 3
      prefix: -i
  - id: first_db_accession
    type:
      - 'null'
      - boolean
    doc: For deflines in the format db1|accession1|db2|accession2|..., only the 
      first db-accession pair ('db1|accession1') is taken as key
    inputBinding:
      position: 3
      prefix: -c
  - id: all_db_accessions
    type:
      - 'null'
      - boolean
    doc: Like -c, but also subsequent db|accession constructs are indexed, along
      with the full (default) token
    inputBinding:
      position: 3
      prefix: -C
  - id: accession_mode
    type:
      - 'null'
      - boolean
    doc: Accession mode, like -C option, but indexes the 'accession' part for 
      all 'db|accession' constructs found
    inputBinding:
      position: 3
      prefix: -a
  - id: accession_and_db_mode
    type:
      - 'null'
      - boolean
    doc: Like -a and -C together (both accessions and 'db|accession' constructs
      are used as keys)
    inputBinding:
      position: 3
      prefix: -A
arguments:
  - prefix: -o
    position: 2
    valueFrom: "$(inputs.index_file ? inputs.index_file : inputs.fasta_file.basename
      + '.cidx')"
outputs:
  - id: output_index
    type: File
    doc: The CDB index file
    outputBinding:
      glob: "$(inputs.index_file ? inputs.index_file : inputs.fasta_file.basename
        + '.cidx')"
  - id: compressed_db_file
    type:
      - 'null'
      - File
    doc: The compressed database file (with -z)
    outputBinding:
      glob: $(inputs.compressed_db)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cdbtools:0.99--h077b44d_12
