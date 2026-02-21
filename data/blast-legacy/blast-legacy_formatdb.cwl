cwlVersion: v1.2
class: CommandLineTool
baseCommand: formatdb
label: blast-legacy_formatdb
doc: "Format protein or nucleotide databases for BLAST\n\nTool homepage: http://blast.ncbi.nlm.nih.gov"
inputs:
  - id: base_name
    type:
      - 'null'
      - string
    doc: Base name for BLAST files
    inputBinding:
      position: 101
      prefix: -n
  - id: binary_asn1
    type:
      - 'null'
      - string
    doc: 'ASN.1 database in binary mode: T - binary, F - text mode.'
    default: F
    inputBinding:
      position: 101
      prefix: -b
  - id: gifile
    type:
      - 'null'
      - File
    doc: Gifile (file containing list of gi's)
    inputBinding:
      position: 101
      prefix: -F
  - id: input_asn1
    type:
      - 'null'
      - string
    doc: Input file is database in ASN.1 format (otherwise FASTA is expected)
    default: F
    inputBinding:
      position: 101
      prefix: -a
  - id: input_file
    type:
      - 'null'
      - File
    doc: Input file(s) for formatting
    inputBinding:
      position: 101
      prefix: -i
  - id: is_protein
    type:
      - 'null'
      - string
    doc: 'Type of file: T - protein, F - nucleotide'
    default: T
    inputBinding:
      position: 101
      prefix: -p
  - id: parse_options
    type:
      - 'null'
      - string
    doc: 'Parse options: T - True: Parse SeqId and create indexes, F - False: Do not
      parse SeqId. Do not create indexes.'
    default: F
    inputBinding:
      position: 101
      prefix: -o
  - id: seq_entry
    type:
      - 'null'
      - string
    doc: Input is a Seq-entry
    default: F
    inputBinding:
      position: 101
      prefix: -e
  - id: sparse_indexes
    type:
      - 'null'
      - string
    doc: Create indexes limited only to accessions - sparse
    default: F
    inputBinding:
      position: 101
      prefix: -s
  - id: taxid_file
    type:
      - 'null'
      - File
    doc: Taxid file to set the taxonomy ids in ASN.1 deflines
    inputBinding:
      position: 101
      prefix: -T
  - id: title
    type:
      - 'null'
      - string
    doc: Title for database file
    inputBinding:
      position: 101
      prefix: -t
  - id: verbose
    type:
      - 'null'
      - string
    doc: 'Verbose: check for non-unique string ids in the database'
    default: F
    inputBinding:
      position: 101
      prefix: -V
  - id: volume_size
    type:
      - 'null'
      - int
    doc: Database volume size in millions of letters
    default: 4000
    inputBinding:
      position: 101
      prefix: -v
outputs:
  - id: logfile
    type:
      - 'null'
      - File
    doc: Logfile name
    outputBinding:
      glob: $(inputs.logfile)
  - id: alias_file
    type:
      - 'null'
      - File
    doc: Create an alias file with this name
    outputBinding:
      glob: $(inputs.alias_file)
  - id: binary_gifile
    type:
      - 'null'
      - File
    doc: Binary Gifile produced from the Gifile specified above
    outputBinding:
      glob: $(inputs.binary_gifile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/blast-legacy:2.2.26--h9ee0642_3
