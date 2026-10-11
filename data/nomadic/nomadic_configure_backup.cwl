cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - nomadic
  - configure
  - backup
label: nomadic_configure_backup
doc: "Configure the nomadic backup command.\n\nThe workspace directory is staged (writable) as the working directory,
  because nomadic 0.7.2 crashes when --workspace is given explicitly; the
  settings are written to .config.yaml in the workspace.\n\nTool homepage:
  https://jasonahendry.github.io/nomadic/"
requirements:
  - class: InlineJavascriptRequirement
  - class: LoadListingRequirement
    loadListing: deep_listing
  - class: InitialWorkDirRequirement
    listing:
      - '${ return inputs.workspace.listing.map(function(x){ return {"entry": x, "writable": true}; }); }'
inputs:
  - id: workspace
    type: Directory
    doc: Path of the workspace (a directory with results, beds and metadata
      folders). Its content is staged as the working directory.
  - id: target_dir
    type:
      - 'null'
      - string
    doc: Path to root target backup folder, local or an SSH target like 
      user@host:/path. The backup will go into <target>/<workspace_name>.
    inputBinding:
      position: 101
      prefix: --target_dir
outputs:
  - id: workspace_out
    type: Directory
    doc: Workspace folder with the updated .config.yaml
    outputBinding:
      glob: .
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nomadic:0.7.2--pyhdfd78af_0
stdout: nomadic_configure_backup.out
