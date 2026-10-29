cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mmseqs
  - subtractdbs
label: mmseqs2_subtractdbs
doc: 'Remove all entries of the first result database that occur in the second one by key.


  By Martin Steinegger <martin.steinegger@snu.ac.kr>


  Tool homepage: https://github.com/soedinglab/mmseqs2'
inputs:
  - id: left_db
    type: Directory
    doc: Left result database
    inputBinding:
      position: 1
      valueFrom: $(self.path)/$(inputs.left_db_name)
  - id: left_db_name
    type: string
    doc: Name (prefix) of the database inside the directory, e.g. db for db, db.index, db.dbtype,
      db_h
  - id: right_db
    type: Directory
    doc: Right result database
    inputBinding:
      position: 2
      valueFrom: $(self.path)/$(inputs.right_db_name)
  - id: right_db_name
    type: string
    doc: Name (prefix) of the database inside the directory, e.g. db for db, db.index, db.dbtype,
      db_h
  - id: output_result_db_name
    type: string
    doc: Name (prefix) of the output result database, written inside the output directory
    inputBinding:
      position: 3
      valueFrom: out_db/$(self)
  - id: e
    type:
      - 'null'
      - float
    doc: List matches below this E-value (range 0.0-inf)
    inputBinding:
      position: 104
      prefix: -e
  - id: e_profile
    type:
      - 'null'
      - float
    doc: Include sequences matches with < E-value thr. into the profile (>=0.0)
    inputBinding:
      position: 104
      prefix: --e-profile
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
  - id: output_db
    type: Directory
    doc: Directory holding the output database files
    outputBinding:
      glob: out_db
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: out_db
        entry: '$({class: "Directory", listing: []})'
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
