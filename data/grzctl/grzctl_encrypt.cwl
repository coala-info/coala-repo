cwlVersion: v1.2
class: CommandLineTool
baseCommand: grzctl encrypt
label: grzctl_encrypt
doc: "Encrypt a submission.\n\nTool homepage: https://github.com/BfArM-MVH/grz-tools"
inputs:
  - id: check_validation_logs
    type:
      - 'null'
      - boolean
    doc: Check validation logs before encrypting.
    inputBinding:
      position: 101
      prefix: --check-validation-logs
  - id: config_file
    type:
      - 'null'
      - string
    doc: Path to config file
    inputBinding:
      position: 101
      prefix: --config-file
  - id: force
    type:
      - 'null'
      - boolean
    doc: Overwrite files and ignore cached results (dangerous!)
    inputBinding:
      position: 101
      prefix: --force
  - id: no_check_validation_logs
    type:
      - 'null'
      - boolean
    doc: Check validation logs before encrypting.
    inputBinding:
      position: 101
      prefix: --no-check-validation-logs
  - id: no_force
    type:
      - 'null'
      - boolean
    doc: Overwrite files and ignore cached results (dangerous!)
    inputBinding:
      position: 101
      prefix: --no-force
  - id: submission_dir
    type: Directory
    doc: Path to the submission directory containing 'metadata/', 'files/', 
      'encrypted_files/' and 'logs/' directories
    inputBinding:
      position: 101
      prefix: --submission-dir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/grzctl:1.4.0--pyhdfd78af_0
stdout: grzctl_encrypt.out
