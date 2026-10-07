cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cellranger-arc
  - cloud
  - analyses
  - list
label: cellranger-arc_cloud_analyses_list
doc: 'List all analyses in a project. Runs the 10x Genomics Cloud Analysis client
  (txg) bundled with cellranger-arc; needs a Cloud Analysis access token and network
  access.


  Tool homepage: https://github.com/mattgalbraith/cellrangerARC-docker-singularity'
inputs:
  - id: project_id
    type: string
    doc: ID of the project.
    inputBinding:
      position: 1
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
stdout: cellranger-arc_cloud_analyses_list.out
s:url: https://github.com/mattgalbraith/cellrangerARC-docker-singularity
$namespaces:
  s: https://schema.org/
