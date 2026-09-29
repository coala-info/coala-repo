cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cellranger
  - cloud
label: cellranger_cloud
doc: The official command-line client for 10x Genomics Cloud Analysis.
inputs:
  - id: command
    type:
      - 'null'
      - string
    doc: Subcommand to execute (e.g., analyses, annotation, auth, fastqs, files,
      projects, references)
    inputBinding:
      position: 1
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
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: cumulusprod/cellranger:10.1.0
stdout: cellranger_cloud.out
s:url: https://github.com/10XGenomics/cellranger
$namespaces:
  s: https://schema.org/
