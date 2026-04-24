cwlVersion: v1.2
class: CommandLineTool
baseCommand: grzctl validate
label: grzctl_validate
doc: "Validate the submission.\n\n  This validates the submission by checking its
  checksums, as well\n  as performing basic sanity checks on the supplied metadata.
  Must be executed\n  before calling `encrypt` and `upload`.\n\nTool homepage: https://github.com/BfArM-MVH/grz-tools"
inputs:
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
    doc: "Overwrite files and ignore cached results\n                         (dangerous!)"
    inputBinding:
      position: 101
      prefix: --force
  - id: no_force
    type:
      - 'null'
      - boolean
    doc: "Overwrite files and ignore cached results\n                         (dangerous!)"
    inputBinding:
      position: 101
      prefix: --no-force
  - id: submission_dir
    type: Directory
    doc: "Path to the submission directory containing\n                         'metadata/',
      'files/', 'encrypted_files/' and 'logs/'\n                         directories"
    inputBinding:
      position: 101
      prefix: --submission-dir
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use for parallel operations
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/grzctl:1.4.0--pyhdfd78af_0
stdout: grzctl_validate.out
