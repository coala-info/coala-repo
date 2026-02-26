cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mdmcleaner
  - show_configs
label: mdmcleaner_show_configs
doc: "Show MDMcleaner configurations\n\nTool homepage: https://github.com/KIT-IBG-5/mdmcleaner"
inputs:
  - id: aragorn
    type:
      - 'null'
      - string
    doc: path to aragorn executable
    default: aragorn
    inputBinding:
      position: 101
  - id: aragornpath
    type:
      - 'null'
      - string
    doc: path to aragorn executable
    default: '[]'
    inputBinding:
      position: 101
  - id: barrnap
    type:
      - 'null'
      - string
    doc: path to barrnap executable
    default: barrnap
    inputBinding:
      position: 101
  - id: barrnappath
    type:
      - 'null'
      - string
    doc: path to barrnap executable
    default: '[]'
    inputBinding:
      position: 101
  - id: blacklistfile
    type:
      - 'null'
      - string
    doc: path to the blacklist file
    default: "['/usr/local/lib/python3.11/site-packages/mdmcleaner/blacklist.list']"
    inputBinding:
      position: 101
  - id: blastdbcmd
    type:
      - 'null'
      - string
    doc: path to blastdbcmd executable
    default: blastdbcmd
    inputBinding:
      position: 101
  - id: blastn
    type:
      - 'null'
      - string
    doc: path to blastn executable
    default: blastn
    inputBinding:
      position: 101
  - id: blastp
    type:
      - 'null'
      - string
    doc: path to blastp executable
    default: blastp
    inputBinding:
      position: 101
  - id: blastpath
    type:
      - 'null'
      - string
    doc: path to blast executables
    default: '[]'
    inputBinding:
      position: 101
  - id: db_basedir
    type:
      - 'null'
      - string
    doc: base directory for databases
    default: '[]'
    inputBinding:
      position: 101
  - id: db_type
    type:
      - 'null'
      - string
    doc: type of database to use
    default: "['gtdb']"
    inputBinding:
      position: 101
  - id: diamond
    type:
      - 'null'
      - string
    doc: path to diamond executable
    default: diamond
    inputBinding:
      position: 101
  - id: diamondpath
    type:
      - 'null'
      - string
    doc: path to diamond executable
    default: '[]'
    inputBinding:
      position: 101
  - id: hmmerpath
    type:
      - 'null'
      - string
    doc: path to HMMER executables
    default: '[]'
    inputBinding:
      position: 101
  - id: hmmsearch
    type:
      - 'null'
      - string
    doc: path to hmmsearch executable
    default: hmmsearch
    inputBinding:
      position: 101
  - id: makeblastdb
    type:
      - 'null'
      - string
    doc: path to makeblastdb executable
    default: makeblastdb
    inputBinding:
      position: 101
  - id: prodigal
    type:
      - 'null'
      - string
    doc: path to prodigal executable
    default: prodigal
    inputBinding:
      position: 101
  - id: prodigalpath
    type:
      - 'null'
      - string
    doc: path to prodigal executable
    default: '[]'
    inputBinding:
      position: 101
  - id: threads
    type:
      - 'null'
      - string
    doc: number of threads
    default: '1'
    inputBinding:
      position: 101
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mdmcleaner:0.8.7--pyh7cba7a3_0
stdout: mdmcleaner_show_configs.out
