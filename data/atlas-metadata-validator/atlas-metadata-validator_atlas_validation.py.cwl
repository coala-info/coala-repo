cwlVersion: v1.2
class: CommandLineTool
baseCommand: atlas_validation.py
label: atlas-metadata-validator_atlas_validation.py
doc: "Validates Atlas metadata files.\n\nTool homepage: https://github.com/ebi-gene-expression-group/atlas-metadata-validator"
inputs:
  - id: sdrf_path
    type: File
    doc: Path to the SDRF file.
    inputBinding:
      position: 1
  - id: git_refresh
    type:
      - 'null'
      - string
    doc: 'Controls gitpython refresh behavior. Options: quiet, warn, error.'
    inputBinding:
      position: 102
      prefix: --git-refresh
  - id: ignore_warnings
    type:
      - 'null'
      - boolean
    doc: Do not report warnings, only errors.
    inputBinding:
      position: 102
      prefix: --ignore-warnings
  - id: skip_fetch
    type:
      - 'null'
      - boolean
    doc: Skip fetching external resources like controlled vocabulary.
    inputBinding:
      position: 102
      prefix: --skip-fetch
  - id: skip_git_check
    type:
      - 'null'
      - boolean
    doc: Skip the git repository check.
    inputBinding:
      position: 102
      prefix: --skip-git-check
  - id: skip_idf_validation
    type:
      - 'null'
      - boolean
    doc: Skip validation of the IDF file.
    inputBinding:
      position: 102
      prefix: --skip-idf-validation
  - id: skip_ontology_check
    type:
      - 'null'
      - boolean
    doc: Skip checking against ontologies.
    inputBinding:
      position: 102
      prefix: --skip-ontology-check
  - id: skip_protocol_fetch
    type:
      - 'null'
      - boolean
    doc: Skip fetching protocol files.
    inputBinding:
      position: 102
      prefix: --skip-protocol-fetch
  - id: skip_protocol_file_fetch
    type:
      - 'null'
      - boolean
    doc: Skip fetching protocol files.
    inputBinding:
      position: 102
      prefix: --skip-protocol-file-fetch
  - id: skip_protocol_file_idf_validation
    type:
      - 'null'
      - boolean
    doc: Skip validation of protocol IDF files.
    inputBinding:
      position: 102
      prefix: --skip-protocol-file-idf-validation
  - id: skip_protocol_file_ontology_check
    type:
      - 'null'
      - boolean
    doc: Skip checking protocol files against ontologies.
    inputBinding:
      position: 102
      prefix: --skip-protocol-file-ontology-check
  - id: skip_protocol_file_sdrf_validation
    type:
      - 'null'
      - boolean
    doc: Skip validation of protocol SDRF files.
    inputBinding:
      position: 102
      prefix: --skip-protocol-file-sdrf-validation
  - id: skip_protocol_file_submission_type_guessing
    type:
      - 'null'
      - boolean
    doc: Skip guessing the submission type from protocol files.
    inputBinding:
      position: 102
      prefix: --skip-protocol-file-submission-type-guessing
  - id: skip_protocol_file_validation
    type:
      - 'null'
      - boolean
    doc: Skip validation of protocol files.
    inputBinding:
      position: 102
      prefix: --skip-protocol-file-validation
  - id: skip_protocol_idf_validation
    type:
      - 'null'
      - boolean
    doc: Skip validation of protocol IDF files.
    inputBinding:
      position: 102
      prefix: --skip-protocol-idf-validation
  - id: skip_protocol_ontology_check
    type:
      - 'null'
      - boolean
    doc: Skip checking protocol files against ontologies.
    inputBinding:
      position: 102
      prefix: --skip-protocol-ontology-check
  - id: skip_protocol_sdrf_validation
    type:
      - 'null'
      - boolean
    doc: Skip validation of protocol SDRF files.
    inputBinding:
      position: 102
      prefix: --skip-protocol-sdrf-validation
  - id: skip_protocol_submission_type_guessing
    type:
      - 'null'
      - boolean
    doc: Skip guessing the submission type from protocol files.
    inputBinding:
      position: 102
      prefix: --skip-protocol-submission-type-guessing
  - id: skip_protocol_validation
    type:
      - 'null'
      - boolean
    doc: Skip validation of protocol files.
    inputBinding:
      position: 102
      prefix: --skip-protocol-validation
  - id: skip_sdrf_validation
    type:
      - 'null'
      - boolean
    doc: Skip validation of the SDRF file.
    inputBinding:
      position: 102
      prefix: --skip-sdrf-validation
  - id: skip_submission_type_guessing
    type:
      - 'null'
      - boolean
    doc: Skip guessing the submission type from the SDRF.
    inputBinding:
      position: 102
      prefix: --skip-submission-type-guessing
  - id: submission_type
    type:
      - 'null'
      - string
    doc: The type of submission (e.g., 'RNA-Seq', 'ATLAS'). If not provided, it 
      will be guessed from the SDRF.
    inputBinding:
      position: 102
      prefix: --submission-type
outputs:
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: Directory to write validation reports and other outputs.
    outputBinding:
      glob: $(inputs.output_directory)
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/atlas-metadata-validator:1.6.1--pyhdfd78af_0
