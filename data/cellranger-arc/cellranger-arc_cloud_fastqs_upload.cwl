cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cellranger-arc
  - cloud
  - fastqs
  - upload
label: cellranger-arc_cloud_fastqs_upload
doc: 'Upload FASTQ files. Runs the 10x Genomics Cloud Analysis client (txg) bundled
  with cellranger-arc; needs a Cloud Analysis access token and network access.


  Tool homepage: https://github.com/mattgalbraith/cellrangerARC-docker-singularity'
inputs:
  - id: paths
    type:
      type: array
      items:
        - File
        - Directory
    doc: FASTQ files, or folders whose top-level FASTQ files are uploaded.
    inputBinding:
      position: 200
  - id: new_project
    type:
      - 'null'
      - string
    doc: Create a new project with the specified name and immediately upload to it.
    inputBinding:
      position: 101
      prefix: --new-project
  - id: project_id
    type:
      - 'null'
      - string
    doc: Upload to the project with the specified ID.
    inputBinding:
      position: 101
      prefix: --project-id
  - id: access_token
    type:
      - 'null'
      - string
    doc: 'Access token to use. Default: the saved token from ''txg auth setup''.'
    inputBinding:
      position: 101
      prefix: --access-token
  - id: assumeyes
    type:
      - 'null'
      - boolean
    doc: Assume yes (don't interactively prompt for confirmation).
    inputBinding:
      position: 101
      prefix: --assumeyes
  - id: header
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --header
    doc: 'Extra HTTP header of the form ''Header: value''. May be given multiple times.'
    inputBinding:
      position: 101
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Don't show progress or messages.
    inputBinding:
      position: 101
      prefix: --quiet
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Display extra debugging information.
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: cumulusprod/cellranger-arc:2.2.0
stdout: cellranger-arc_cloud_fastqs_upload.out
s:url: https://github.com/mattgalbraith/cellrangerARC-docker-singularity
$namespaces:
  s: https://schema.org/
