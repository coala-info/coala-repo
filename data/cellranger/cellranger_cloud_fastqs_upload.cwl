cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cellranger
  - cloud
  - fastqs
  - upload
label: cellranger_cloud_fastqs_upload
doc: "Upload FASTQ files to a 10x Genomics Cloud project\n\nTool homepage: https://github.com/10XGenomics/cellranger"
inputs:
  - id: paths
    type:
      type: array
      items:
        - File
        - Directory
    doc: FASTQ files or folders to upload
    inputBinding:
      position: 1
  - id: new_project
    type:
      - 'null'
      - string
    doc: Create a new project with the specified name and immediately upload the 
      files to it.
    inputBinding:
      position: 102
      prefix: --new-project
  - id: project_id
    type:
      - 'null'
      - string
    doc: Upload the files to the project with the specified ID.
    inputBinding:
      position: 102
      prefix: --project-id
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
stdout: cellranger_cloud_fastqs_upload.out
s:url: https://github.com/10XGenomics/cellranger
$namespaces:
  s: https://schema.org/
