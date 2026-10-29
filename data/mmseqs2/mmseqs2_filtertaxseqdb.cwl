cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mmseqs
  - filtertaxseqdb
label: mmseqs2_filtertaxseqdb
doc: 'Filter taxonomy sequence database.


  By Eli Levy Karin <eli.levy.karin@gmail.com> & Martin Steinegger <martin.steinegger@snu.ac.kr>


  Tool homepage: https://github.com/soedinglab/mmseqs2'
inputs:
  - id: tax_seq_db
    type: Directory
    doc: Sequence database with taxonomy
    inputBinding:
      position: 1
      valueFrom: $(self.path)/$(inputs.tax_seq_db_name)
  - id: tax_seq_db_name
    type: string
    doc: Name (prefix) of the database inside the directory, e.g. db for db, db.index, db.dbtype,
      db_h
  - id: output_db_name
    type: string
    doc: Name (prefix) of the output database, written inside the output directory
    inputBinding:
      position: 2
      valueFrom: out_db/$(self)
  - id: taxon_list
    type:
      - 'null'
      - string
    doc: Taxonomy ID, possibly multiple values separated by ','
    inputBinding:
      position: 104
      prefix: --taxon-list
  - id: subdb_mode
    type:
      - 'null'
      - int
    doc: 'Subdb mode 0: copy data 1: soft link data and write index'
    inputBinding:
      position: 104
      prefix: --subdb-mode
  - id: compressed
    type:
      - 'null'
      - int
    doc: Write compressed output
    inputBinding:
      position: 104
      prefix: --compressed
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
  - id: output_db
    type: Directory
    doc: Directory holding the filtered sequence database
    outputBinding:
      glob: out_db
requirements:
  - class: InlineJavascriptRequirement
  - class: ShellCommandRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: out_db
        entry: '$({class: "Directory", listing: []})'
        writable: true
arguments:
  - position: 200
    shellQuote: false
    valueFrom: '&& for l in out_db/*; do if [ -L "$l" ]; then t=`readlink -f "$l"`; rm "$l";
      cp -r "$t" "$l"; fi; done'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
