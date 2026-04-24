cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - nomadic
  - backup
label: nomadic_backup
doc: "Backup entire nomadic workspace and associated minknow data to a different folder
  e.g. on a local hard disk drive.\n\nTool homepage: https://jasonahendry.github.io/nomadic/"
inputs:
  - id: checksum
    type:
      - 'null'
      - boolean
    doc: Use checksum check instead of file size and modification time.
    inputBinding:
      position: 101
      prefix: --checksum
  - id: exclude_minknow
    type:
      - 'null'
      - boolean
    doc: Exclude minknow data in the backup.
    inputBinding:
      position: 101
      prefix: --exclude-minknow
  - id: include_minknow
    type:
      - 'null'
      - boolean
    doc: Include minknow data in the backup.
    inputBinding:
      position: 101
      prefix: --include-minknow
  - id: minknow_dir
    type:
      - 'null'
      - Directory
    doc: Path to the base minknow output directory. Only needed if the files 
      were moved.
    inputBinding:
      position: 101
      prefix: --minknow_dir
  - id: target_dir
    type: Directory
    doc: Path to root target backup folder, local or an SSH target like 
      user@host:/path. The backup will go into <target>/<workspace_name>.
    inputBinding:
      position: 101
      prefix: --target_dir
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Increase logging verbosity, will show files that are copied.
    inputBinding:
      position: 101
      prefix: --verbose
  - id: workspace
    type:
      - 'null'
      - Directory
    doc: Path of the workspace where all input/output files (beds, metadata, 
      results) are stored. The workspace directory simplifies the use of nomadic
      in that many arguments don't need to be listed as they are predefined in 
      the workspace config or can be loaded from the workspace
    inputBinding:
      position: 101
      prefix: --workspace
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nomadic:0.7.2--pyhdfd78af_0
stdout: nomadic_backup.out
