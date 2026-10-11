cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - nomadic
  - share
label: nomadic_share
doc: "Share summary nomadic workspace and associated minknow data to another folder
  e.g. a cloud synchronised folder for sharing.\n\nThe workspace directory is staged (writable)
  as the working directory, because nomadic 0.7.2 crashes when --workspace is given
  explicitly (AttributeError: 'str' object has no attribute 'is_dir'); without it
  nomadic uses the current directory.\n\nTool homepage: https://jasonahendry.github.io/nomadic/"
requirements:
  - class: InlineJavascriptRequirement
  - class: LoadListingRequirement
    loadListing: deep_listing
  - class: InitialWorkDirRequirement
    listing:
      - '${ return inputs.workspace.listing.map(function(x){ return {"entry": x, "writable": true}; }); }'
      - entryname: $(inputs.target_dir)
        entry: '$({"class": "Directory", "basename": inputs.target_dir, "listing": []})'
        writable: true
inputs:
  - id: workspace
    type: Directory
    doc: Path of the workspace (a directory with results, beds and metadata
      folders). Its content is staged as the working directory.
  - id: target_dir
    type: string
    doc: Path to root target backup folder, local or an SSH target like 
      user@host:/path. The backup will go into <target>/<workspace_name>.
    inputBinding:
      position: 101
      prefix: --target_dir
  - id: minknow_dir
    type:
      - 'null'
      - Directory
    doc: Path to minknow output directory (default it usually sufficient)
    inputBinding:
      position: 101
      prefix: --minknow_dir
  - id: exclude_minknow
    type:
      - 'null'
      - boolean
    doc: Exclude minknow data.
    inputBinding:
      position: 101
      prefix: --exclude-minknow
  - id: include_minknow
    type:
      - 'null'
      - boolean
    doc: Include minknow data.
    inputBinding:
      position: 101
      prefix: --include-minknow
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Increase logging verbosity, will show files that are copied.
    inputBinding:
      position: 101
      prefix: --verbose
  - id: update
    type:
      - 'null'
      - boolean
    doc: Update will not overwrite files that are newer.
    inputBinding:
      position: 101
      prefix: --update
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: Overwrite files in the target folder.
    inputBinding:
      position: 101
      prefix: --overwrite
  - id: checksum
    type:
      - 'null'
      - boolean
    doc: Use checksum check instead of file size and modification time.
    inputBinding:
      position: 101
      prefix: --checksum
outputs:
  - id: share_dir
    type: Directory
    doc: Shared folder written by nomadic
    outputBinding:
      glob: $(inputs.target_dir)
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nomadic:0.7.2--pyhdfd78af_0
stdout: nomadic_share.out
