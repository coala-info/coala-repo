cwlVersion: v1.2
class: CommandLineTool
baseCommand: GIXrm
label: fastga_GIXrm
doc: "Deletes genome databases (.1gdb) and genome indexes (.gix) together with their hidden files.\n\nTool homepage: https://github.com/thegenemyers/FASTGA"
inputs:
  - id: source_files
    type: File[]
    doc: 'All files of the databases or indexes to delete (.1gdb, hidden .bps, .gix, hidden .ktab.N).'
  - id: sources
    type: string[]
    doc: Names of the .1gdb or .gix files to delete (as in source_files).
    inputBinding:
      position: 100
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: 'Verbose mode, list what is being deleted.'
    inputBinding:
      position: 101
      prefix: '-v'
  - id: prompt
    type:
      - 'null'
      - boolean
    doc: Prompt for each (stub) deletion.
    inputBinding:
      position: 101
      prefix: '-i'
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force operation quietly.
    inputBinding:
      position: 101
      prefix: '-f'
  - id: delete_gdb
    type:
      - 'null'
      - boolean
    doc: Also delete the associated GDB.
    inputBinding:
      position: 101
      prefix: '-g'
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: remaining_files
    type:
      type: array
      items: File
    doc: Files left in the working directory after the deletion.
    outputBinding:
      glob:
        - '*'
        - '.*.*'
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.source_files)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastga:1.3.1--h577a1d6_0
stdout: fastga_GIXrm.out
