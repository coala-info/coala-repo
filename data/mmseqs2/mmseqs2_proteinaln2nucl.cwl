cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mmseqs
  - proteinaln2nucl
label: mmseqs2_proteinaln2nucl
doc: 'Transform protein alignments into nucleotide alignments, using the nucleotide and protein
  databases of the same sequences.


  By Martin Steinegger <martin.steinegger@snu.ac.kr>


  Tool homepage: https://github.com/soedinglab/mmseqs2'
inputs:
  - id: nucl_query_db
    type: Directory
    doc: Nucleotide query database
    inputBinding:
      position: 1
      valueFrom: $(self.path)/$(inputs.nucl_query_db_name)
  - id: nucl_query_db_name
    type: string
    doc: Name (prefix) of the database inside the directory, e.g. db for db, db.index, db.dbtype,
      db_h
  - id: nucl_target_db
    type: Directory
    doc: Nucleotide target database
    inputBinding:
      position: 2
      valueFrom: $(self.path)/$(inputs.nucl_target_db_name)
  - id: nucl_target_db_name
    type: string
    doc: Name (prefix) of the database inside the directory, e.g. db for db, db.index, db.dbtype,
      db_h
  - id: aa_query_db
    type: Directory
    doc: Protein query database
    inputBinding:
      position: 3
      valueFrom: $(self.path)/$(inputs.aa_query_db_name)
  - id: aa_query_db_name
    type: string
    doc: Name (prefix) of the database inside the directory, e.g. db for db, db.index, db.dbtype,
      db_h
  - id: aa_target_db
    type: Directory
    doc: Protein target database
    inputBinding:
      position: 4
      valueFrom: $(self.path)/$(inputs.aa_target_db_name)
  - id: aa_target_db_name
    type: string
    doc: Name (prefix) of the database inside the directory, e.g. db for db, db.index, db.dbtype,
      db_h
  - id: aln_db
    type: Directory
    doc: Protein alignment database
    inputBinding:
      position: 5
      valueFrom: $(self.path)/$(inputs.aln_db_name)
  - id: aln_db_name
    type: string
    doc: Name (prefix) of the database inside the directory, e.g. db for db, db.index, db.dbtype,
      db_h
  - id: output_aln_db_name
    type: string
    doc: Name (prefix) of the output nucleotide alignment database, written inside the output
      directory
    inputBinding:
      position: 6
      valueFrom: out_db/$(self)
  - id: gap_open
    type:
      - 'null'
      - string
    doc: Gap open cost
    inputBinding:
      position: 104
      prefix: --gap-open
  - id: gap_extend
    type:
      - 'null'
      - string
    doc: Gap extension cost
    inputBinding:
      position: 104
      prefix: --gap-extend
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
