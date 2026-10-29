cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mmseqs
  - apply
label: mmseqs2_apply
doc: 'Run a program on each entry of a database; the standard output of each call becomes
  the new entry.


  By Milot Mirdita <milot@mirdita.de>


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
  - id: output_db_name
    type: string
    doc: Name (prefix) of the output database, written inside the output directory
    inputBinding:
      position: 2
      valueFrom: out_db/$(self)
  - id: program
    type: string
    doc: Program to run on each entry (must exist in the image); it reads the entry on standard
      input
    inputBinding:
      position: 4
      prefix: --
  - id: program_args
    type:
      - 'null'
      - type: array
        items: string
    doc: Arguments passed to the program
    inputBinding:
      position: 5
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of CPU-cores used (all by default)
    inputBinding:
      position: 3
      prefix: --threads
  - id: compressed
    type:
      - 'null'
      - int
    doc: Write compressed output
    inputBinding:
      position: 3
      prefix: --compressed
  - id: v
    type:
      - 'null'
      - int
    doc: 'Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info'
    inputBinding:
      position: 3
      prefix: -v
outputs:
  - id: output_db
    type: Directory
    doc: Directory holding the new database files
    outputBinding:
      glob: out_db
arguments:
  - position: 200
    shellQuote: false
    valueFrom: '&& for f in out_db/*; do if [ -L "$f" ]; then t=`readlink -f "$f"`; rm "$f";
      cp "$t" "$f"; fi; done'
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
