cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cellranger
  - cloud
  - analyses
  - download
label: cellranger_cloud_analyses_download
doc: "Download analysis files in a single analysis on 10x Genomics Cloud\n\nTool homepage: https://github.com/10XGenomics/cellranger"
inputs:
  - id: analysis_id
    type: string
    doc: Analysis ID on 10x Genomics Cloud
    inputBinding:
      position: 1
  - id: file_id
    type:
      - 'null'
      - type: array
        items: string
    doc: IDs of the files to download.
    inputBinding:
      position: 102
      prefix: --file-id
      itemSeparator: ','
  - id: target_dir
    type: string
    doc: Destination directory to download to (created before the run).
    default: downloads
    inputBinding:
      position: 102
      prefix: --target-dir
  - id: access_token
    type:
      - 'null'
      - string
    doc: "Specify an access token to use. Default: the saved token from 'txg auth
      setup'."
    inputBinding:
      position: 102
      prefix: --access-token
  - id: assumeyes
    type:
      - 'null'
      - boolean
    doc: "Assume yes (don't interactively prompt for confirmation, etc). Default:
      off."
    inputBinding:
      position: 102
      prefix: --assumeyes
  - id: header
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --header
          separate: true
    doc: "Extra header to include in the request when sending HTTP requests to a server.
      May be given multiple times to add multiple headers. Each header must be of
      the form 'Header: value'. Default: no extra headers."
    inputBinding:
      position: 102
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: "Don't show progress or messages. Default: off."
    inputBinding:
      position: 102
      prefix: --quiet
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Display extra debugging information. Default: off."
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: downloaded
    type: Directory
    doc: Folder with the downloaded files
    outputBinding:
      glob: $(inputs.target_dir)
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
  - class: InitialWorkDirRequirement
    listing:
      - entryname: $(inputs.target_dir)
        entry: "$({class: 'Directory', listing: []})"
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: cumulusprod/cellranger:10.1.0
stdout: cellranger_cloud_analyses_download.out
s:url: https://github.com/10XGenomics/cellranger
$namespaces:
  s: https://schema.org/
