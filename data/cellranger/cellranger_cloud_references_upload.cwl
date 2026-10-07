cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cellranger
  - cloud
  - references
  - upload
label: cellranger_cloud_references_upload
doc: "Upload a custom reference to 10x Genomics Cloud\n\nTool homepage: https://github.com/10XGenomics/cellranger"
inputs:
  - id: reference
    type: File
    doc: Custom reference file to upload
    inputBinding:
      position: 1
  - id: name
    type:
      - 'null'
      - string
    doc: Reference name
    inputBinding:
      position: 102
      prefix: --name
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
requirements:
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: cumulusprod/cellranger:10.1.0
stdout: cellranger_cloud_references_upload.out
s:url: https://github.com/10XGenomics/cellranger
$namespaces:
  s: https://schema.org/
