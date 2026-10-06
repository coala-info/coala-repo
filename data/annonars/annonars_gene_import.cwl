cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- annonars
- gene
- import
label: annonars_gene_import
doc: '"import" sub command: Import gene information data (HGNC, ClinGen, OMIM, gnomAD constraints and
  more) into a RocksDB database.


  Tool homepage: https://github.com/bihealth/annona-rs'
inputs:
- id: path_in_acmg
  type: File
  doc: Path to the TSV file with ACMG secondary findings list
  inputBinding:
    position: 1
    prefix: --path-in-acmg
- id: path_in_clingen_37
  type: File
  doc: Path to the CSV file with ClinGen curations for GRCh37
  inputBinding:
    position: 1
    prefix: --path-in-clingen-37
- id: path_in_clingen_38
  type: File
  doc: Path to the CSV file with ClinGen curations for GRCh38
  inputBinding:
    position: 1
    prefix: --path-in-clingen-38
- id: path_in_gnomad_constraints
  type: File
  doc: Path to the TSV file with gnomAD gene constraints
  inputBinding:
    position: 1
    prefix: --path-in-gnomad-constraints
- id: path_in_dbnsfp
  type: File
  doc: Path to the TSV file with dbNSFP gene information
  inputBinding:
    position: 1
    prefix: --path-in-dbnsfp
- id: path_in_hgnc
  type: File
  doc: Path to the JSONL file with HGNC information
  inputBinding:
    position: 1
    prefix: --path-in-hgnc
- id: path_in_ncbi
  type: File
  doc: Path to the JSONL file with NCBI information
  inputBinding:
    position: 1
    prefix: --path-in-ncbi
- id: path_in_omim
  type: File
  doc: Path to the TSV file with OMIM disease information
  inputBinding:
    position: 1
    prefix: --path-in-omim
- id: path_in_orpha
  type: File
  doc: Path to the TSV file with ORPHA disease information
  inputBinding:
    position: 1
    prefix: --path-in-orpha
- id: path_in_panelapp
  type: File
  doc: Path to the JSONL file with PanelApp disease information
  inputBinding:
    position: 1
    prefix: --path-in-panelapp
- id: path_in_rcnv
  type: File
  doc: Path to the TSV file with rCNV information
  inputBinding:
    position: 1
    prefix: --path-in-rcnv
- id: path_in_shet
  type: File
  doc: Path to the TSV file with sHet information
  inputBinding:
    position: 1
    prefix: --path-in-shet
- id: path_in_gtex
  type: File
  doc: Path to the JSONL file with the GTEx information
  inputBinding:
    position: 1
    prefix: --path-in-gtex
- id: path_in_domino
  type: File
  doc: Path to the DOMINO TSV file
  inputBinding:
    position: 1
    prefix: --path-in-domino
- id: path_in_decipher_hi
  type: File
  doc: Path to the DECIPHER HI file
  inputBinding:
    position: 1
    prefix: --path-in-decipher-hi
- id: path_in_conditions
  type: File
  doc: Path to the conditions HGNC file
  inputBinding:
    position: 1
    prefix: --path-in-conditions
- id: path_out_rocksdb
  type: string
  doc: Path to output RocksDB
  inputBinding:
    position: 1
    prefix: --path-out-rocksdb
- id: verbose
  type:
  - 'null'
  - boolean
  doc: Increase logging verbosity
  inputBinding:
    position: 1
    prefix: --verbose
- id: quiet
  type:
  - 'null'
  - boolean
  doc: Decrease logging verbosity
  inputBinding:
    position: 1
    prefix: --quiet
outputs:
- id: rocksdb
  type: Directory
  doc: Output RocksDB directory
  outputBinding:
    glob: $(inputs.path_out_rocksdb)
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/annonars:0.44.1--h13c227e_0
