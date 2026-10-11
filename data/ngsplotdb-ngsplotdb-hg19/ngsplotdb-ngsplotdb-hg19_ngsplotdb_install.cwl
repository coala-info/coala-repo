cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ngsplotdb.py
  - install
label: ngsplotdb-ngsplotdb-hg19_ngsplotdb_install
doc: "Install a genome from a package file (ngsplotdb_<genome>_<version>.tar.gz) into the ngs.plot database.\n\nTool homepage: https://github.com/shenlab-sinai/ngsplot"
inputs:
  - id: yes
    type:
      - 'null'
      - boolean
    doc: Say yes to all prompted questions
    inputBinding:
      position: 1
      prefix: --yes
  - id: pkg
    type: File
    doc: Package file (.tar.gz) to install
    inputBinding:
      position: 2
outputs:
  - id: install_log
    type: stdout
    doc: Installation messages
stdout: ngsplotdb_install.txt
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngsplotdb-ngsplotdb-hg19:3.00--r3.4.1_0
