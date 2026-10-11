cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ngsplotdb.py
  - list
label: ngsplotdb-ngsplotdb-hg19_ngsplotdb_list
doc: "List genomes installed in the ngs.plot database.\n\nTool homepage: https://github.com/shenlab-sinai/ngsplot"
inputs:
  - id: yes
    type:
      - 'null'
      - boolean
    doc: Say yes to all prompted questions
    inputBinding:
      position: 1
      prefix: --yes
outputs:
  - id: genome_table
    type: stdout
    doc: Table of installed genomes (ID, assembly, species, versions, features)
stdout: ngsplotdb_list.txt
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngsplotdb-ngsplotdb-hg19:3.00--r3.4.1_0
