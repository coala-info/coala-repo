cwlVersion: v1.2
class: CommandLineTool
baseCommand: raremetalworker
label: raremetalworker
doc: A Forerunner of RareMetal
inputs:
  - id: datafile
    type: File
    doc: The datafile to be opened
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/raremetalworker:v4.13.7_cv3
stdout: raremetalworker.out
