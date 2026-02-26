cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hostile
  - index
label: hostile_index
doc: "Manage and download indexes for use with hostile clean\n\nTool homepage: https://github.com/bede/hostile"
inputs:
  - id: action
    type: string
    doc: 'Action to perform: delete (Delete cached indexes), list (List available
      remote and local cached indexes), or fetch (Download and cache indexes from
      object storage)'
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hostile:2.0.2--pyhdfd78af_0
stdout: hostile_index.out
