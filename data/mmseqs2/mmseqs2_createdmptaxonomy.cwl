cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mmseqs
  - createdmptaxonomy
label: mmseqs2_createdmptaxonomy
doc: 'Write NCBI-style names.dmp and nodes.dmp files from the binary taxonomy that belongs
  to a database.


  By Milot Mirdita <milot@mirdita.de>


  Tool homepage: https://github.com/soedinglab/mmseqs2'
inputs:
  - id: taxonomy_db
    type: Directory
    doc: Sequence database that carries a binary taxonomy (<db>_taxonomy, made with createtaxdb)
    inputBinding:
      position: 1
      valueFrom: $(self.path)/$(inputs.taxonomy_db_name)
  - id: taxonomy_db_name
    type: string
    doc: Name (prefix) of the database inside the directory, e.g. db for db, db.index, db.dbtype,
      db_h
  - id: dmp_base
    type: string
    doc: Prefix of the output files; the tool writes <prefix>_names.dmp and <prefix>_nodes.dmp
    inputBinding:
      position: 2
  - id: v
    type:
      - 'null'
      - int
    doc: 'Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info'
    inputBinding:
      position: 104
      prefix: -v
outputs:
  - id: output_dmp_files
    type:
      type: array
      items: File
    doc: The names and nodes dmp files
    outputBinding:
      glob: $(inputs.dmp_base)_*.dmp
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
