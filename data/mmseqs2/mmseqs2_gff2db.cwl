cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mmseqs
  - gff2db
label: mmseqs2_gff2db
doc: 'Extract regions from a sequence database based on a GFF3 file.


  By Milot Mirdita <milot@mirdita.de>


  Tool homepage: https://github.com/soedinglab/mmseqs2'
inputs:
  - id: gff_files
    type:
      type: array
      items: File
    doc: GFF3 files
    inputBinding:
      position: 1
  - id: sequence_db
    type: Directory
    doc: Input sequence database
    inputBinding:
      position: 2
      valueFrom: $(self.path)/$(inputs.sequence_db_name)
  - id: sequence_db_name
    type: string
    doc: Name (prefix) of the database inside the directory, e.g. db for db, db.index, db.dbtype,
      db_h
  - id: output_db_name
    type: string
    doc: Name (prefix) of the output database, written inside the output directory
    inputBinding:
      position: 3
      valueFrom: out_db/$(self)
  - id: gff_type
    type:
      - 'null'
      - string
    doc: Comma separated list of feature types in the GFF file to select
    inputBinding:
      position: 104
      prefix: --gff-type
  - id: id_offset
    type:
      - 'null'
      - int
    doc: Numeric ids in index file are offset by this value
    inputBinding:
      position: 104
      prefix: --id-offset
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
    doc: Directory holding the new sequence database
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
