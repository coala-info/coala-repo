cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ngsplotdb.py
  - chrnames
label: ngsplotdb-ngsplotdb-hg19_ngsplotdb_chrnames
doc: "List chromosome names of an installed genome.\n\nTool homepage: https://github.com/shenlab-sinai/ngsplot"
inputs:
  - id: yes
    type:
      - 'null'
      - boolean
    doc: Say yes to all prompted questions
    inputBinding:
      position: 1
      prefix: --yes
  - id: gn
    type: string
    doc: Genome name (e.g. mm9)
    inputBinding:
      position: 2
  - id: db
    type: string
    doc: Database (ensembl or refseq)
    inputBinding:
      position: 3
outputs:
  - id: chromosome_names
    type: stdout
    doc: Chromosome names of the genome
stdout: ngsplotdb_chrnames.txt
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngsplotdb-ngsplotdb-hg19:3.00--r3.4.1_0
