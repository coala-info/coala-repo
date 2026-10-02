cwlVersion: v1.2
class: CommandLineTool
baseCommand: cmpress
label: infernal_cmpress
doc: prepare an CM database for faster cmscan searches
inputs:
  - id: cmfile
    type: File
    doc: CM database file to press
    inputBinding:
      position: 1
  - id: force
    type:
      - 'null'
      - boolean
    doc: 'force: overwrite any previous pressed files'
    inputBinding:
      position: 102
      prefix: -F
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/infernal:1.1.5--pl5321h7b50bb2_4
stdout: cmpress.out
s:url: http://eddylab.org/infernal
$namespaces:
  s: https://schema.org/
