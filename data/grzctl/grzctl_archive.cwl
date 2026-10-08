cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - grzctl
  - archive
label: grzctl_archive
doc: "Archive a submission within a GRZ/GDC.\n\nTool homepage: https://github.com/BfArM-MVH/grz-tools"
inputs:
  - id: config_file
    type:
      - 'null'
      - File
    doc: Path to config file
    inputBinding:
      position: 101
      prefix: --config-file
  - id: submission_dir
    type: Directory
    doc: Path to the submission directory containing 'metadata/', 'files/', 'encrypted_files/' and 'logs/' directories
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
  - id: stderr
    type: stderr
    doc: Log messages of the command
requirements:
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/grzctl:1.4.0--pyhdfd78af_0
stdout: grzctl_archive.out
stderr: grzctl_archive.log
