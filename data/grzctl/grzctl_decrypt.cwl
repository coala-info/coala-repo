cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - grzctl
  - decrypt
label: grzctl_decrypt
doc: "Decrypt a submission.\n\nDecrypting a submission requires the _private_ key of the original recipient.\n\nTool homepage: https://github.com/BfArM-MVH/grz-tools"
inputs:
  - id: config_file
    type:
      - 'null'
      - File
    doc: Path to config file
    inputBinding:
      position: 101
      prefix: --config-file
  - id: config_referenced_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Files that the config file names by relative path (for example the GRZ
      private key in keys.grz_private_key_path); they are staged in the working
      directory
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
    doc: Do not overwrite files; use cached results.
    inputBinding:
      position: 101
      prefix: --no-force
  - id: submission_dir
    type: Directory
    doc: Path to the submission directory containing 'metadata/', 'files/', 'encrypted_files/' and 'logs/' directories
    inputBinding:
      position: 101
      prefix: --submission-dir
      valueFrom: $(self.basename)
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: stderr
    type: stderr
    doc: Log messages of the command
  - id: submission_dir_out
    type: Directory
    doc: The submission directory with the files the command wrote (logs, encrypted files)
    outputBinding:
      glob: $(inputs.submission_dir.basename)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.submission_dir)
        writable: true
      - entry: $(inputs.config_referenced_files || [])
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/grzctl:1.4.0--pyhdfd78af_0
stdout: grzctl_decrypt.out
stderr: grzctl_decrypt.log
