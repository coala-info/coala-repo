cwlVersion: v1.2
class: CommandLineTool
baseCommand: squire
label: squire_clean
doc: "squire: error: invalid choice: 'clean' (choose from 'Build', 'Fetch', 'Clean',
  'Map', 'Count', 'Call', 'Draw', 'Seek')\n\nTool homepage: https://github.com/wyang17/SQuIRE"
inputs:
  - id: subcommand
    type: string
    doc: Subcommand to run (Build, Fetch, Clean, Map, Count, Call, Draw, Seek)
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/squire:0.9.9.92--pyhdfd78af_1
stdout: squire_clean.out
