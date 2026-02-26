cwlVersion: v1.2
class: CommandLineTool
baseCommand: samestr_db
label: samestr_db
doc: "Database check arguments:\n\nTool homepage: https://github.com/danielpodlesny/samestr/"
inputs:
  - id: clade
    type:
      - 'null'
      - type: array
        items: string
    doc: Clade to process from input files. Processing all if not specified. 
      Names must correspond to the taxonomy of the respective database [e.g. 
      t__SGB10068 for MetaPhlAn or ref_mOTU_v3_00095 for mOTUs]
    default: None
    inputBinding:
      position: 101
      prefix: --clade
  - id: db_check
    type:
      - 'null'
      - boolean
    doc: Performs just a database integrity check, if an existing SameStr 
      database is provided. All other options will be ignored.
    default: false
    inputBinding:
      position: 101
      prefix: --db-check
  - id: db_version
    type:
      - 'null'
      - string
    doc: Path to version file of database (`mpa_latest` for MetaPhlAn, or 
      `db_mOTU_versions` for mOTUs.)
    default: PATH
    inputBinding:
      position: 101
      prefix: --db-version
  - id: marker_dir
    type:
      - 'null'
      - Directory
    doc: Path to existing MetaPhlAn or mOTUs clade marker database.
    default: None
    inputBinding:
      position: 101
      prefix: --marker-dir
  - id: markers_fasta
    type:
      - 'null'
      - File
    doc: Markers fasta file (MetaPhlAn [mpa_vJan21_CHOCOPhlAnSGB_202103.fna or 
      higher], or mOTUs [db_mOTU_DB_CEN.fasta]
    default: None
    inputBinding:
      position: 101
      prefix: --markers-fasta
  - id: markers_info
    type:
      - 'null'
      - type: array
        items: File
    doc: Path(s) to marker info files. For MetaPhlAn should be MetaPhlAn pickle 
      file (mpa_vJan21_CHOCOPhlAnSGB_202103.pkl or higher). For mOTUs, should be
      both `db_mOTU_taxonomy_meta-mOTUs.tsv` and 
      `db_mOTU_taxonomy_ref-mOTUs.tsv`.
    default: None
    inputBinding:
      position: 101
      prefix: --markers-info
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Path to output directory.
    default: out_db/
    inputBinding:
      position: 101
      prefix: --output-dir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/samestr:1.2025.111--pyhdfd78af_0
stdout: samestr_db.out
