cwlVersion: v1.2
class: CommandLineTool
baseCommand: ngsplotdb-ngsplotdb-hg19_ngsplotdb.py
label: ngsplotdb-ngsplotdb-hg19_ngsplotdb.py
doc: "A tool for managing or accessing the ngsplot database for the hg19 genome. Note:
  The provided text contains system error logs rather than help documentation.\n\n
  Tool homepage: https://github.com/shenlab-sinai/ngsplot"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngsplotdb-ngsplotdb-hg19:3.00--r3.4.1_0
stdout: ngsplotdb-ngsplotdb-hg19_ngsplotdb.py.out
