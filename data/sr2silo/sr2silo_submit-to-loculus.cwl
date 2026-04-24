cwlVersion: v1.2
class: CommandLineTool
baseCommand: sr2silo_submit-to-loculus
label: sr2silo_submit-to-loculus
doc: "Upload processed file to S3 and submit to SILO/Loculus.\n\nTool homepage: https://github.com/cbg-ethz/sr2silo"
inputs:
  - id: auto_release
    type:
      - 'null'
      - boolean
    doc: Automatically release/approve sequences after submission. Falls back to
      AUTO_RELEASE environment variable.
    inputBinding:
      position: 101
      prefix: --auto-release
  - id: backend_url
    type:
      - 'null'
      - string
    doc: Loculus backend URL. Falls back to BACKEND_URL environment variable.
    inputBinding:
      position: 101
      prefix: --backend-url
  - id: group_id
    type:
      - 'null'
      - int
    doc: Group ID for submission. Falls back to GROUP_ID environment variable.
    inputBinding:
      position: 101
      prefix: --group-id
  - id: keycloak_token_url
    type:
      - 'null'
      - string
    doc: Keycloak authentication URL. Falls back to KEYCLOAK_TOKEN_URL 
      environment variable.
    inputBinding:
      position: 101
      prefix: --keycloak-token-url
  - id: nucleotide_alignment
    type: File
    doc: Path to nucleotide alignment file (e.g., .bam) used to create the 
      processed .ndjson.zst file.
    inputBinding:
      position: 101
      prefix: --nucleotide-alignment
  - id: organism
    type:
      - 'null'
      - string
    doc: Organism identifier for submission. Falls back to ORGANISM environment 
      variable.
    inputBinding:
      position: 101
      prefix: --organism
  - id: password
    type:
      - 'null'
      - string
    doc: Password for authentication. Falls back to PASSWORD environment 
      variable.
    inputBinding:
      position: 101
      prefix: --password
  - id: processed_file
    type: File
    doc: Path to the processed .ndjson.zst file to upload and submit.
    inputBinding:
      position: 101
      prefix: --processed-file
  - id: release_delay
    type:
      - 'null'
      - int
    doc: Seconds to wait before releasing sequences (to allow backend 
      processing). Only used when --auto-release is enabled.
    inputBinding:
      position: 101
      prefix: --release-delay
  - id: username
    type:
      - 'null'
      - string
    doc: Username for authentication. Falls back to USERNAME environment 
      variable.
    inputBinding:
      position: 101
      prefix: --username
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sr2silo:1.8.0--pyhdfd78af_0
stdout: sr2silo_submit-to-loculus.out
