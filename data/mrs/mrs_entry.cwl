cwlVersion: v1.2
class: CommandLineTool
baseCommand: mrs_entry
label: mrs_entry
doc: "Display entry information\n\nTool homepage: https://github.com/ctu-mrs/mrs_uav_system"
inputs:
  - id: config_file
    type:
      - 'null'
      - File
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
  - id: entry_id
    type:
      - 'null'
      - string
    doc: Entry ID to display
    inputBinding:
      position: 101
      prefix: --entry
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
stdout: mrs_entry.out
