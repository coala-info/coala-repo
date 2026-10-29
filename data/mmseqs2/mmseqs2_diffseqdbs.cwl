cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mmseqs
  - diffseqdbs
label: mmseqs2_diffseqdbs
doc: 'Compute the difference of two sequence databases: removed, kept and new sequence keys.


  By Clovis Galiez & Martin Steinegger <martin.steinegger@snu.ac.kr>


  Tool homepage: https://github.com/soedinglab/mmseqs2'
inputs:
  - id: old_sequence_db
    type: Directory
    doc: Old sequence database
    inputBinding:
      position: 1
      valueFrom: $(self.path)/$(inputs.old_sequence_db_name)
  - id: old_sequence_db_name
    type: string
    doc: Name (prefix) of the database inside the directory, e.g. db for db, db.index, db.dbtype,
      db_h
  - id: new_sequence_db
    type: Directory
    doc: New sequence database
    inputBinding:
      position: 2
      valueFrom: $(self.path)/$(inputs.new_sequence_db_name)
  - id: new_sequence_db_name
    type: string
    doc: Name (prefix) of the database inside the directory, e.g. db for db, db.index, db.dbtype,
      db_h
  - id: rm_seq_keys_file
    type: string
    doc: Name of the output file with keys of sequences that are only in the old database
    inputBinding:
      position: 3
  - id: kept_seq_keys_file
    type: string
    doc: Name of the output file with keys of sequences that are in both databases
    inputBinding:
      position: 4
  - id: new_seq_keys_file
    type: string
    doc: Name of the output file with keys of sequences that are only in the new database
    inputBinding:
      position: 5
  - id: use_seq_id
    type:
      - 'null'
      - int
    doc: Sequence ID (Uniprot, GenBank, ...) is used for identifying matches between the old
      and the new DB (0 or 1)
    inputBinding:
      position: 104
      prefix: --use-seq-id
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of CPU-cores used (all by default)
    inputBinding:
      position: 104
      prefix: --threads
  - id: compressed
    type:
      - 'null'
      - int
    doc: Write compressed output
    inputBinding:
      position: 104
      prefix: --compressed
  - id: v
    type:
      - 'null'
      - int
    doc: 'Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info'
    inputBinding:
      position: 104
      prefix: -v
outputs:
  - id: output_removed_keys
    type: File
    doc: Keys removed since the old database
    outputBinding:
      glob: $(inputs.rm_seq_keys_file)
  - id: output_kept_keys
    type: File
    doc: Keys kept in the new database
    outputBinding:
      glob: $(inputs.kept_seq_keys_file)
  - id: output_new_keys
    type: File
    doc: Keys new in the new database
    outputBinding:
      glob: $(inputs.new_seq_keys_file)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
