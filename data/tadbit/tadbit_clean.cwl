cwlVersion: v1.2
class: CommandLineTool
baseCommand: tadbit_clean
label: tadbit_clean
doc: "Delete jobs and results of a given list of jobids in a given directories\n\n\
  Tool homepage: http://sgt.cnag.cat/3dg/tadbit/"
inputs:
  - id: change_workdir
    type:
      - 'null'
      - Directory
    doc: In case folder was moved, input the new path
    inputBinding:
      position: 101
      prefix: --change_workdir
  - id: compress
    type:
      - 'null'
      - boolean
    doc: compress files and update paths accordingly
    inputBinding:
      position: 101
      prefix: --compress
  - id: delete
    type:
      - 'null'
      - boolean
    doc: delete files, otherwise only DB entries.
    inputBinding:
      position: 101
      prefix: --delete
  - id: jobids
    type:
      type: array
      items: int
    doc: jobids of the files and entries to be removed
    inputBinding:
      position: 101
      prefix: --jobids
  - id: noX
    type:
      - 'null'
      - boolean
    doc: no display server (X screen)
    inputBinding:
      position: 101
      prefix: --noX
  - id: tmpdb
    type:
      - 'null'
      - Directory
    doc: if provided uses this directory to manipulate the database
    inputBinding:
      position: 101
      prefix: --tmpdb
  - id: workdir
    type: Directory
    doc: path to working directory (generated with the tool tadbit mapper)
    inputBinding:
      position: 101
      prefix: --workdir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tadbit:1.0.1--py310h2a84d7f_1
stdout: tadbit_clean.out
