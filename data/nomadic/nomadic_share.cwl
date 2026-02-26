cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - nomadic
  - share
label: nomadic_share
doc: "Share summary nomadic workspace and associated minknow data to another folder
  e.g. a cloud synchronised folder for sharing.\n\nTool homepage: https://jasonahendry.github.io/nomadic/"
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
    doc: Exclude minknow data
    inputBinding:
      position: 101
      prefix: --exclude-minknow
  - id: include_minknow
    type:
      - 'null'
      - boolean
    doc: Include minknow data
    inputBinding:
      position: 101
      prefix: --include-minknow
  - id: minknow_dir
    type:
      - 'null'
      - Directory
    doc: Path to minknow output directory (default it usually sufficient)
    default: (/var/lib/minknow/data)
    inputBinding:
      position: 101
      prefix: --minknow_dir
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: Overwrite files that are newer.
    inputBinding:
      position: 101
      prefix: --overwrite
  - id: target_dir
    type: Directory
    doc: Path to target folder, local or an SSH target like user@host:/path. The
      shared files will go inside of that folder into a folder with the name of 
      the workspace.
    inputBinding:
      position: 101
      prefix: --target_dir
  - id: update
    type:
      - 'null'
      - boolean
    doc: Update will not overwrite files that are newer.
    inputBinding:
      position: 101
      prefix: --update
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
    default: (current directory)
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
stdout: nomadic_share.out
