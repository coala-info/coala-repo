cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mmseqs
  - splitdb
label: mmseqs2_splitdb
doc: 'Split a database into subsets of equal size.


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
  - id: output_prefix
    type: string
    doc: Prefix of the output databases; the parts are named <prefix>_<i>_<N>
    inputBinding:
      position: 2
      valueFrom: out_db/$(self)
  - id: split
    type:
      - 'null'
      - int
    doc: Split input into N equally distributed chunks
    inputBinding:
      position: 104
      prefix: --split
  - id: split_aa
    type:
      - 'null'
      - int
    doc: Try to find the best split boundaries by entry lengths (0 or 1)
    inputBinding:
      position: 104
      prefix: --split-aa
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
    doc: Directory holding the split databases
    outputBinding:
      glob: out_db
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: out_db
        entry: '$({class: "Directory", listing: []})'
        writable: true
  - class: ShellCommandRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
arguments:
  - shellQuote: false
    position: 1000
    valueFrom: '&& cp -rL out_db out_db_tmp && rm -rf out_db && mv out_db_tmp out_db'
