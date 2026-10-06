cwlVersion: v1.2
class: CommandLineTool
baseCommand: atlas_validation.py
label: atlas-metadata-validator_atlas_validation.py
doc: "Validates Atlas MAGE-TAB metadata files (IDF and SDRF).\n\nTool homepage: https://github.com/ebi-gene-expression-group/atlas-metadata-validator"
inputs:
  - id: idf
    type: File
    doc: Path to the MAGE-TAB IDF file
    inputBinding:
      position: 1
  - id: data_dir
    type:
      - 'null'
      - Directory
    doc: Path to the directory with SDRF and data files
    inputBinding:
      position: 0
      prefix: --data_dir
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Option to output detailed logging (debug level).
    inputBinding:
      position: 0
      prefix: --verbose
  - id: hca
    type:
      - 'null'
      - boolean
    doc: Mark experiment as HCA import
    inputBinding:
      position: 0
      prefix: -hca
  - id: singlecell
    type:
      - 'null'
      - boolean
    doc: Force submission type to be 'singlecell'
    inputBinding:
      position: 0
      prefix: --singlecell
  - id: sequencing
    type:
      - 'null'
      - boolean
    doc: Force submission type to be 'sequencing'
    inputBinding:
      position: 0
      prefix: --sequencing
  - id: microarray
    type:
      - 'null'
      - boolean
    doc: Force submission type to be 'microarray'
    inputBinding:
      position: 0
      prefix: --microarray
  - id: skip_file_checks
    type:
      - 'null'
      - boolean
    doc: Skip file and URI checks
    inputBinding:
      position: 0
      prefix: --skip-file-checks
outputs:
  - id: stdout
    type: stdout
    doc: Validation report
  - id: stderr
    type: stderr
    doc: Validation log
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/atlas-metadata-validator:1.6.1--pyhdfd78af_0
stdout: atlas_validation.out
stderr: atlas_validation.err
