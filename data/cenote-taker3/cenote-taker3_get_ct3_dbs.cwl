cwlVersion: v1.2
class: CommandLineTool
baseCommand: get_ct3_dbs
label: cenote-taker3_get_ct3_dbs
doc: "Update and/or download databases associated with Cenote-Taker 3. HMM (hmmer)
  databases: updated January 10th, 2024. RefSeq Virus taxonomy DB compiled July 31,
  2023. hallmark taxonomy database added March 19th, 2024\n\nTool homepage: https://github.com/mtisza1/Cenote-Taker3"
inputs:
  - id: domain_list
    type:
      - 'null'
      - boolean
    doc: 'Default: False -- choose: True -or- False'
    inputBinding:
      position: 101
      prefix: --domain_list
  - id: hallmark_tax
    type:
      - 'null'
      - boolean
    doc: 'Default: False -- choose: True -or- False'
    inputBinding:
      position: 101
      prefix: --hallmark_tax
  - id: hhcdd
    type:
      - 'null'
      - boolean
    doc: 'Default: False -- choose: True -or- False'
    inputBinding:
      position: 101
      prefix: --hhCDD
  - id: hhpdb
    type:
      - 'null'
      - boolean
    doc: 'Default: False -- choose: True -or- False'
    inputBinding:
      position: 101
      prefix: --hhPDB
  - id: hhpfam
    type:
      - 'null'
      - boolean
    doc: 'Default: False -- choose: True -or- False'
    inputBinding:
      position: 101
      prefix: --hhPFAM
  - id: hmm_db
    type:
      - 'null'
      - boolean
    doc: 'Default: False -- choose: True -or- False'
    inputBinding:
      position: 101
      prefix: --hmm
  - id: mmseqs_cdd
    type:
      - 'null'
      - boolean
    doc: 'Default: False -- choose: True -or- False'
    inputBinding:
      position: 101
      prefix: --mmseqs_cdd
  - id: output_directory
    type: Directory
    doc: output directory when database will be downloaded
    inputBinding:
      position: 101
      prefix: -o
  - id: refseq_tax
    type:
      - 'null'
      - boolean
    doc: 'Default: False -- choose: True -or- False'
    inputBinding:
      position: 101
      prefix: --refseq_tax
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cenote-taker3:3.4.4--pyhdfd78af_0
stdout: cenote-taker3_get_ct3_dbs.out
