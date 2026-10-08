cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - grzctl
  - clean
label: grzctl_clean
doc: "Remove all files of a submission from the S3 inbox.\n\nTool homepage: https://github.com/BfArM-MVH/grz-tools"
inputs:
  - id: config_file
    type:
      - 'null'
      - File
    doc: Path to config file
    inputBinding:
      position: 101
      prefix: --config-file
  - id: submission_id
    type: string
    doc: S3 submission ID
    inputBinding:
      position: 101
      prefix: --submission-id
  - id: yes_i_really_mean_it
    type:
      - 'null'
      - boolean
    doc: Confirm that the files are removed
    inputBinding:
      position: 101
      prefix: --yes-i-really-mean-it
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: stderr
    type: stderr
    doc: Log messages of the command
requirements:
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/grzctl:1.4.0--pyhdfd78af_0
stdout: grzctl_clean.out
stderr: grzctl_clean.log
