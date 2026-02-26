cwlVersion: v1.2
class: CommandLineTool
baseCommand: bioconda-backup
label: bioconda-backup
doc: Backup and restore conda environments.
inputs:
  - id: action
    type: string
    doc: The action to perform (backup or restore).
    inputBinding:
      position: 1
  - id: environment
    type: string
    doc: The name of the conda environment to backup or restore.
    inputBinding:
      position: 2
  - id: force
    type:
      - 'null'
      - boolean
    doc: Overwrite the backup file if it already exists.
    inputBinding:
      position: 103
      prefix: --force
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output.
    inputBinding:
      position: 103
      prefix: --verbose
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: The path to the backup file.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bioconda-backup:latest
