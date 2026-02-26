cwlVersion: v1.2
class: CommandLineTool
baseCommand: makeblastdb
label: fgap_makeblastdb
doc: "Application to create BLAST databases, version 2.16.0+\n\nTool homepage: https://github.com/pirovc/fgap"
inputs:
  - id: blastdb_version
    type:
      - 'null'
      - int
    doc: Version of BLAST database to be created
    default: 5
    inputBinding:
      position: 101
      prefix: -blastdb_version
  - id: dbtype
    type: string
    doc: Molecule type of target db
    inputBinding:
      position: 101
      prefix: -dbtype
  - id: gi_mask
    type:
      - 'null'
      - boolean
    doc: Create GI indexed masking data.
    inputBinding:
      position: 101
      prefix: -gi_mask
  - id: gi_mask_name
    type:
      - 'null'
      - string
    doc: Comma-separated list of masking data output files.
    inputBinding:
      position: 101
      prefix: -gi_mask_name
  - id: hash_index
    type:
      - 'null'
      - boolean
    doc: Create index of sequence hash values.
    inputBinding:
      position: 101
      prefix: -hash_index
  - id: input_file
    type:
      - 'null'
      - File
    doc: Input file/database name
    default: "'-'"
    inputBinding:
      position: 101
      prefix: -in
  - id: input_type
    type:
      - 'null'
      - string
    doc: Type of the data specified in input_file
    default: fasta
    inputBinding:
      position: 101
      prefix: -input_type
  - id: logfile
    type:
      - 'null'
      - File
    doc: File to which the program log should be redirected
    inputBinding:
      position: 101
      prefix: -logfile
  - id: mask_data
    type:
      - 'null'
      - string
    doc: Comma-separated list of input files containing masking data as produced
      by NCBI masking applications (e.g. dustmasker, segmasker, windowmasker)
    inputBinding:
      position: 101
      prefix: -mask_data
  - id: mask_desc
    type:
      - 'null'
      - string
    doc: Comma-separated list of free form strings to describe the masking 
      algorithm details
    inputBinding:
      position: 101
      prefix: -mask_desc
  - id: mask_id
    type:
      - 'null'
      - string
    doc: Comma-separated list of strings to uniquely identify the masking 
      algorithm
    inputBinding:
      position: 101
      prefix: -mask_id
  - id: max_file_sz
    type:
      - 'null'
      - string
    doc: Maximum file size for BLAST database files
    default: 3GB
    inputBinding:
      position: 101
      prefix: -max_file_sz
  - id: metadata_output_prefix
    type:
      - 'null'
      - string
    doc: Path prefix for location of database files in metadata
    inputBinding:
      position: 101
      prefix: -metadata_output_prefix
  - id: oid_masks
    type:
      - 'null'
      - int
    doc: 0x01 Exclude Model
    inputBinding:
      position: 101
      prefix: -oid_masks
  - id: out
    type:
      - 'null'
      - string
    doc: Name of BLAST database to be created
    default: input file name provided to -in argument
    inputBinding:
      position: 101
      prefix: -out
  - id: parse_seqids
    type:
      - 'null'
      - boolean
    doc: Option to parse seqid for FASTA input if set, for all other input types
      seqids are parsed automatically
    inputBinding:
      position: 101
      prefix: -parse_seqids
  - id: taxid
    type:
      - 'null'
      - int
    doc: Taxonomy ID to assign to all sequences
    inputBinding:
      position: 101
      prefix: -taxid
  - id: taxid_map
    type:
      - 'null'
      - File
    doc: "Text file mapping sequence IDs to taxonomy IDs.\n   Format:<SequenceId>
      <TaxonomyId><newline>"
    inputBinding:
      position: 101
      prefix: -taxid_map
  - id: title
    type:
      - 'null'
      - string
    doc: Title for BLAST database
    default: input file name provided to -in argument
    inputBinding:
      position: 101
      prefix: -title
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fgap:1.8.1--hdfd78af_2
stdout: fgap_makeblastdb.out
