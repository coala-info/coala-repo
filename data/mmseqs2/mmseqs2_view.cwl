cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mmseqs
  - view
label: mmseqs2_view
doc: 'Print database entries given in --id-list to the standard output.


  By Martin Steinegger <martin.steinegger@snu.ac.kr>


  Tool homepage: https://github.com/soedinglab/mmseqs2'
inputs:
  - id: input_db
    type: Directory
    doc: Input database
    inputBinding:
      position: 1
      valueFrom: $(self.path)/$(inputs.input_db_name)
  - id: input_db_name
    type: string
    doc: Name (prefix) of the database inside the directory, e.g. db for db, db.index, db.dbtype,
      db_h
  - id: id_list
    type:
      - 'null'
      - string
    doc: Entries to be printed separated by ','
    inputBinding:
      position: 104
      prefix: --id-list
  - id: id_mode
    type:
      - 'null'
      - int
    doc: 'Select DB entries based on 0: database keys, 1: FASTA identifiers (.lookup)'
    inputBinding:
      position: 104
      prefix: --id-mode
  - id: idx_entry_type
    type:
      - 'null'
      - int
    doc: '0: sequence, 1: src sequence, 2: header, 3: src header'
    inputBinding:
      position: 104
      prefix: --idx-entry-type
  - id: v
    type:
      - 'null'
      - int
    doc: 'Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info'
    inputBinding:
      position: 104
      prefix: -v
outputs:
  - id: output_entries
    type: stdout
    doc: The printed database entries
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
stdout: view_entries.txt
