cwlVersion: v1.2
class: CommandLineTool
baseCommand: microhapdb
label: microhapdb_cmd
doc: "microhapdb: error: argument cmd: invalid choice: 'cmd' (choose from 'lookup',
  'marker', 'population', 'frequency', 'summarize')\n\nTool homepage: https://github.com/bioforensics/MicroHapDB/"
inputs:
  - id: cmd
    type: string
    doc: Command to run (choose from 'lookup', 'marker', 'population', 
      'frequency', 'summarize')
    inputBinding:
      position: 1
  - id: download
    type:
      - 'null'
      - boolean
    doc: Download data
    inputBinding:
      position: 102
      prefix: --download
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/microhapdb:0.12--pyhdfd78af_0
stdout: microhapdb_cmd.out
