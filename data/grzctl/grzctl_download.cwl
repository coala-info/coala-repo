cwlVersion: v1.2
class: CommandLineTool
baseCommand: grzctl download
label: grzctl_download
doc: "Download a submission from a GRZ.\n\nTool homepage: https://github.com/BfArM-MVH/grz-tools"
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
    doc: Overwrite files and ignore cached results (dangerous!)
    inputBinding:
      position: 101
      prefix: --force
  - id: no_force
    type:
      - 'null'
      - boolean
    doc: Overwrite files and ignore cached results (dangerous!)
    inputBinding:
      position: 101
      prefix: --no-force
  - id: output_dir
    type: Directory
    doc: Path to the target submission output directory
    inputBinding:
      position: 101
      prefix: --output-dir
  - id: submission_id
    type: string
    doc: S3 submission ID
    inputBinding:
      position: 101
      prefix: --submission-id
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
stdout: grzctl_download.out
