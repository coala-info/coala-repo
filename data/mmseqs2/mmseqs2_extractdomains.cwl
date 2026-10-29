cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mmseqs
  - extractdomains
label: mmseqs2_extractdomains
doc: 'Extract the highest scoring aligned region of each sequence from an alignment database
  and an MSA database.


  By Milot Mirdita <milot@mirdita.de> & Martin Steinegger <martin.steinegger@snu.ac.kr>


  Tool homepage: https://github.com/soedinglab/mmseqs2'
inputs:
  - id: alignment_db
    type: Directory
    doc: Alignment database
    inputBinding:
      position: 1
      valueFrom: $(self.path)/$(inputs.alignment_db_name)
  - id: alignment_db_name
    type: string
    doc: Name (prefix) of the database inside the directory, e.g. db for db, db.index, db.dbtype,
      db_h
  - id: msa_db
    type: Directory
    doc: MSA database
    inputBinding:
      position: 2
      valueFrom: $(self.path)/$(inputs.msa_db_name)
  - id: msa_db_name
    type: string
    doc: Name (prefix) of the database inside the directory, e.g. db for db, db.index, db.dbtype,
      db_h
  - id: output_domain_db_name
    type: string
    doc: Name (prefix) of the output domain database, written inside the output directory
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
  - id: c
    type:
      - 'null'
      - float
    doc: List matches above this fraction of aligned (covered) residues (see --cov-mode)
    inputBinding:
      position: 104
      prefix: -c
  - id: msa_type
    type:
      - 'null'
      - int
    doc: 'MSA Type: 0: cA3M, 1: A3M, 2: FASTA'
    inputBinding:
      position: 104
      prefix: --msa-type
  - id: sub_mat
    type:
      - 'null'
      - string
    doc: Substitution matrix file
    inputBinding:
      position: 104
      prefix: --sub-mat
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
