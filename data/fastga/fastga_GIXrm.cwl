cwlVersion: v1.2
class: CommandLineTool
baseCommand: GIXrm
label: fastga_GIXrm
doc: "Deletes GIX index files and optionally associated GDB files.\n\nTool homepage:
  https://github.com/thegenemyers/FASTGA"
inputs:
  - id: source_paths
    type:
      type: array
      items: File
    doc: Source GIX index files (e.g., .1gdb or .gix)
    inputBinding:
      position: 1
  - id: delete_gdb
    type:
      - 'null'
      - boolean
    doc: Also delete the associated GDB.
    inputBinding:
      position: 102
      prefix: -g
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force operation quietly
    inputBinding:
      position: 102
      prefix: -f
  - id: prompt
    type:
      - 'null'
      - boolean
    doc: Prompt for each (stub) deletion
    inputBinding:
      position: 102
      prefix: -i
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose mode, list what is being deleted.
    inputBinding:
      position: 102
      prefix: -v
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastga:1.3.1--h577a1d6_0
stdout: fastga_GIXrm.out
