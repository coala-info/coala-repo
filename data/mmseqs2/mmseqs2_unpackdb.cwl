cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mmseqs
  - unpackdb
label: mmseqs2_unpackdb
doc: 'Unpack a database into separate files, one per entry.


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
  - id: unpack_dir
    type: string
    doc: Name of the output directory for the unpacked files
    inputBinding:
      position: 2
  - id: unpack_name_mode
    type:
      - 'null'
      - int
    doc: 'Name unpacked files by 0: DB key, 1: accession (through .lookup)'
    inputBinding:
      position: 104
      prefix: --unpack-name-mode
  - id: unpack_suffix
    type:
      - 'null'
      - string
    doc: File suffix for unpacked files. Add .gz suffix to write compressed files.
    inputBinding:
      position: 104
      prefix: --unpack-suffix
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of CPU-cores used (all by default)
    inputBinding:
      position: 104
      prefix: --threads
  - id: v
    type:
      - 'null'
      - int
    doc: 'Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info'
    inputBinding:
      position: 104
      prefix: -v
outputs:
  - id: output_dir
    type: Directory
    doc: Directory with one file per database entry
    outputBinding:
      glob: $(inputs.unpack_dir)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
