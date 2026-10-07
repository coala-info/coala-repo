cwlVersion: v1.2
class: CommandLineTool
baseCommand: cdbyank
label: cdbtools_cdbyank
doc: "Retrieves fasta records from a multi-fasta file using an index file created
  previously with cdbfasta.\n\nTool homepage: https://github.com/gpertea/cdbfasta"
inputs:
  - id: index_file
    type: File
    doc: The index file created previously with cdbfasta (usually having a 
      ".cidx" suffix)
    inputBinding:
      position: 1
  - id: fasta_file
    type:
      - 'null'
      - File
    doc: The fasta file to pull records from; if not specified, cdbyank looks in
      the directory of <index_file> for a file with the same name but without 
      the ".cidx" suffix
    inputBinding:
      position: 2
      prefix: -d
  - id: key
    type:
      - 'null'
      - string
    doc: The sequence name (accession) for a fasta record to be retrieved; if 
      not given, a list of accessions is expected at stdin
    inputBinding:
      position: 2
      prefix: -a
  - id: keys_file
    type:
      - 'null'
      - File
    doc: File with a list of accessions (one per line), given to cdbyank on 
      stdin when no key is set
  - id: out_file
    type:
      - 'null'
      - string
    doc: The records found are written to file <outfile> instead of stdout
    inputBinding:
      position: 2
      prefix: -o
  - id: multiple
    type:
      - 'null'
      - boolean
    doc: Allows retrieval of multiple records per key, if the indexed database 
      had records with the same key (non-unique keys)
    inputBinding:
      position: 2
      prefix: -x
  - id: case_insensitive
    type:
      - 'null'
      - boolean
    doc: Case insensitive query (expects the <index_file> to have been created 
      with cdbfasta -i option)
    inputBinding:
      position: 2
      prefix: -i
  - id: show_key
    type:
      - 'null'
      - boolean
    doc: Output the query key surrounded by character '%' before the 
      corresponding record
    inputBinding:
      position: 2
      prefix: -Q
  - id: key_char
    type:
      - 'null'
      - string
    doc: Same as -Q but use character <char> instead of '%'
    inputBinding:
      position: 2
      prefix: -q
  - id: warnings
    type:
      - 'null'
      - boolean
    doc: Enable warnings (sent to stderr) when a key is not found
    inputBinding:
      position: 2
      prefix: -w
  - id: defline_only
    type:
      - 'null'
      - boolean
    doc: Pulls only the defline for each record (discard the sequence)
    inputBinding:
      position: 2
      prefix: -F
  - id: positions
    type:
      - 'null'
      - boolean
    doc: Only displays the position(s) (file offset) within the database file, 
      for the requested record(s)
    inputBinding:
      position: 2
      prefix: -P
  - id: range
    type:
      - 'null'
      - boolean
    doc: "Sequence range extraction: expects the input key(s) to have the format
      '<seq_name> <start> <end>' and pulls only the specified sequence range"
    inputBinding:
      position: 2
      prefix: -R
  - id: decompress
    type:
      - 'null'
      - File
    doc: Decompress the entire file <dbfasta.cdbz> (assumes it was built using 
      cdbfasta with '-z' option)
    inputBinding:
      position: 2
      prefix: -z
  - id: num_records
    type:
      - 'null'
      - boolean
    doc: Display the number of records indexed
    inputBinding:
      position: 2
      prefix: -n
  - id: list_keys
    type:
      - 'null'
      - boolean
    doc: List all keys stored in <index_file>
    inputBinding:
      position: 2
      prefix: -l
  - id: summary
    type:
      - 'null'
      - boolean
    doc: Display indexing summary info
    inputBinding:
      position: 2
      prefix: -s
outputs:
  - id: stdout
    type: stdout
    doc: Retrieved records or index information (when no out_file is given)
  - id: output_file
    type:
      - 'null'
      - File
    doc: Retrieved records written with -o
    outputBinding:
      glob: $(inputs.out_file)
stdin: "$(inputs.keys_file ? inputs.keys_file.path : null)"
stdout: cdbyank.out
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cdbtools:0.99--h077b44d_12
