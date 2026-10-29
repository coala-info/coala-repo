cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mmseqs
  - createtaxdb
label: mmseqs2_createtaxdb
doc: 'Add taxonomic labels to a sequence database (writes <db>_taxonomy, <db>_mapping and
  related files beside it).


  By Martin Steinegger <martin.steinegger@snu.ac.kr>


  Tool homepage: https://github.com/soedinglab/mmseqs2'
inputs:
  - id: sequence_db
    type: Directory
    doc: Input sequence database (labels are added in a writable copy; the input is not changed)
    inputBinding:
      position: 1
      valueFrom: db_dir/$(inputs.sequence_db_name)
  - id: sequence_db_name
    type: string
    doc: Name (prefix) of the database inside the directory, e.g. db for db, db.index, db.dbtype,
      db_h
  - id: tmp_dir
    type: string
    doc: Temporary directory (created by the tool)
    inputBinding:
      position: 2
  - id: ncbi_tax_dump
    type:
      - 'null'
      - Directory
    doc: NCBI tax dump directory. The tax dump can be downloaded here "ftp://ftp.ncbi.nlm.nih.gov/pub/taxonomy/taxdump.tar.gz"
    inputBinding:
      position: 104
      prefix: --ncbi-tax-dump
  - id: tax_mapping_file
    type:
      - 'null'
      - File
    doc: File to map sequence identifier to taxonomical identifier
    inputBinding:
      position: 104
      prefix: --tax-mapping-file
  - id: tax_mapping_mode
    type:
      - 'null'
      - int
    doc: 'Map taxonomy based on sequence database 0: .lookup file 1: .source file'
    inputBinding:
      position: 104
      prefix: --tax-mapping-mode
  - id: tax_db_mode
    type:
      - 'null'
      - int
    doc: 'Create taxonomy database as: 0: .dmp flat files (human readable) 1: binary dump
      (faster readin)'
    inputBinding:
      position: 104
      prefix: --tax-db-mode
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
    doc: Database directory holding the sequence database plus the taxonomy files
    outputBinding:
      glob: db_dir
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: db_dir
        entry: $(inputs.sequence_db)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
