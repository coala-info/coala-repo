cwlVersion: v1.2
class: CommandLineTool
baseCommand: mrs dump
label: mrs_dump
doc: "Dump mrs data\n\nTool homepage: https://github.com/ctu-mrs/mrs_uav_system"
inputs:
  - id: config
    type:
      - 'null'
      - string
    doc: Configuration file
    inputBinding:
      position: 101
      prefix: --config
  - id: databank
    type:
      - 'null'
      - string
    doc: Databank
    inputBinding:
      position: 101
      prefix: --databank
  - id: index
    type:
      - 'null'
      - string
    doc: Index to dump
    inputBinding:
      position: 101
      prefix: --index
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
stdout: mrs_dump.out
