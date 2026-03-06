cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - makeblastdb
  - windowmasker
label: blast_windowmasker
doc: Application to create BLAST databases
inputs:
  - id: blastdb_version
    type:
      - 'null'
      - string
    doc: version
    inputBinding:
      position: 101
      prefix: -blastdb_version
  - id: db_type
    type: string
    doc: molecule_type
    inputBinding:
      position: 101
      prefix: -dbtype
  - id: gi_mask
    type:
      - 'null'
      - boolean
    doc: GI based mask
    inputBinding:
      position: 101
      prefix: -gi_mask
  - id: gi_mask_name
    type:
      - 'null'
      - string
    doc: gi_based_mask_names
    inputBinding:
      position: 101
      prefix: -gi_mask_name
  - id: hash_index
    type:
      - 'null'
      - boolean
    doc: create hash index
    inputBinding:
      position: 101
      prefix: -hash_index
  - id: input_file
    type: File
    doc: input_file
    inputBinding:
      position: 101
      prefix: -in
  - id: input_type
    type:
      - 'null'
      - string
    doc: type
    inputBinding:
      position: 101
      prefix: -input_type
  - id: logfile
    type:
      - 'null'
      - File
    doc: File_Name
    inputBinding:
      position: 101
      prefix: -logfile
  - id: mask_data
    type:
      - 'null'
      - File
    doc: mask_data_files
    inputBinding:
      position: 101
      prefix: -mask_data
  - id: mask_desc
    type:
      - 'null'
      - string
    doc: mask_algo_descriptions
    inputBinding:
      position: 101
      prefix: -mask_desc
  - id: mask_id
    type:
      - 'null'
      - string
    doc: mask_algo_ids
    inputBinding:
      position: 101
      prefix: -mask_id
  - id: max_file_size
    type:
      - 'null'
      - int
    doc: number_of_bytes
    inputBinding:
      position: 101
      prefix: -max_file_sz
  - id: metadata_output_prefix
    type:
      - 'null'
      - string
    doc: metadata_output_prefix
    inputBinding:
      position: 101
      prefix: -metadata_output_prefix
  - id: oid_masks
    type:
      - 'null'
      - string
    doc: oid_masks
    inputBinding:
      position: 101
      prefix: -oid_masks
  - id: output_database_name
    type:
      - 'null'
      - string
    doc: database_name
    inputBinding:
      position: 101
      prefix: -out
  - id: parse_seqids
    type:
      - 'null'
      - boolean
    doc: parse sequence identifiers
    inputBinding:
      position: 101
      prefix: -parse_seqids
  - id: taxid
    type:
      - 'null'
      - int
    doc: TaxID
    inputBinding:
      position: 101
      prefix: -taxid
  - id: taxid_map
    type:
      - 'null'
      - File
    doc: TaxIDMapFile
    inputBinding:
      position: 101
      prefix: -taxid_map
  - id: title
    type:
      - 'null'
      - string
    doc: database_title
    inputBinding:
      position: 101
      prefix: -title
outputs:
  - id: output_output_database_name
    type:
      - 'null'
      - File
    doc: database_name
    outputBinding:
      glob: $(inputs.output_database_name)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/blast:2.17.0--h66d330f_0
s:url: https://blast.ncbi.nlm.nih.gov/doc/blast-help/
$namespaces:
  s: https://schema.org/
