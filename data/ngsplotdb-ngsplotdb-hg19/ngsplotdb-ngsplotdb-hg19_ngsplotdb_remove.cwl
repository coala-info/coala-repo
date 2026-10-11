cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ngsplotdb.py
  - remove
label: ngsplotdb-ngsplotdb-hg19_ngsplotdb_remove
doc: "Remove a genome from the ngs.plot database.\n\nTool homepage: https://github.com/shenlab-sinai/ngsplot"
inputs:
  - id: yes
    type:
      - 'null'
      - boolean
    doc: Say yes to all prompted questions
    inputBinding:
      position: 1
      prefix: --yes
  - id: ftr
    type:
      - 'null'
      - string
    doc: Remove cellline specific features (enhancer, dhs, etc)
    inputBinding:
      position: 3
      prefix: --ftr
  - id: gn
    type: string
    doc: Name of genome to be removed (e.g. hg18)
    inputBinding:
      position: 4
outputs:
  - id: remove_log
    type: stdout
    doc: Removal messages
stdout: ngsplotdb_remove.txt
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngsplotdb-ngsplotdb-hg19:3.00--r3.4.1_0
