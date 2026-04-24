cwlVersion: v1.2
class: CommandLineTool
baseCommand: mrs_query
label: mrs_query
doc: "Query the MRS databank\n\nTool homepage: https://github.com/ctu-mrs/mrs_uav_system"
inputs:
  - id: config
    type:
      - 'null'
      - string
    doc: Configuration file
    inputBinding:
      position: 101
      prefix: --config
  - id: count
    type:
      - 'null'
      - int
    doc: Result count
    inputBinding:
      position: 101
      prefix: --count
  - id: databank
    type:
      - 'null'
      - string
    doc: Databank
    inputBinding:
      position: 101
      prefix: --databank
  - id: offset
    type:
      - 'null'
      - int
    doc: Result offset
    inputBinding:
      position: 101
      prefix: --offset
  - id: query
    type:
      - 'null'
      - string
    doc: Query term
    inputBinding:
      position: 101
      prefix: --query
  - id: threads
    type:
      - 'null'
      - int
    doc: Nr of threads/pipelines
    inputBinding:
      position: 101
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Be verbose
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/mrs:v6.0.5dfsg-2b2-deb_cv1
stdout: mrs_query.out
