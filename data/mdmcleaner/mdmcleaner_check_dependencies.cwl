cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mdmcleaner
  - check_dependencies
label: mdmcleaner_check_dependencies
doc: "Checks if all required dependencies for MDMcleaner are met.\n\nTool homepage:
  https://github.com/KIT-IBG-5/mdmcleaner"
inputs:
  - id: aragorn
    type:
      - 'null'
      - string
    doc: Path to the aragorn executable.
    default: aragorn
    inputBinding:
      position: 101
  - id: barrnap
    type:
      - 'null'
      - string
    doc: Path to the barrnap executable.
    default: barrnap
    inputBinding:
      position: 101
  - id: blacklistfile
    type:
      - 'null'
      - File
    doc: Path to the blacklist file.
    default: "['/usr/local/lib/python3.11/site-packages/mdmcleaner/blacklist.list']"
    inputBinding:
      position: 101
  - id: blastdbcmd
    type:
      - 'null'
      - string
    doc: Path to the blastdbcmd executable.
    default: blastdbcmd
    inputBinding:
      position: 101
  - id: blastn
    type:
      - 'null'
      - string
    doc: Path to the blastn executable.
    default: blastn
    inputBinding:
      position: 101
  - id: blastp
    type:
      - 'null'
      - string
    doc: Path to the blastp executable.
    default: blastp
    inputBinding:
      position: 101
  - id: db_type
    type:
      - 'null'
      - string
    doc: Type of database to use.
    default: "['gtdb']"
    inputBinding:
      position: 101
  - id: diamond
    type:
      - 'null'
      - string
    doc: Path to the diamond executable.
    default: diamond
    inputBinding:
      position: 101
  - id: hmmsearch
    type:
      - 'null'
      - string
    doc: Path to the hmmsearch executable.
    default: hmmsearch
    inputBinding:
      position: 101
  - id: makeblastdb
    type:
      - 'null'
      - string
    doc: Path to the makeblastdb executable.
    default: makeblastdb
    inputBinding:
      position: 101
  - id: prodigal
    type:
      - 'null'
      - string
    doc: Path to the prodigal executable.
    default: prodigal
    inputBinding:
      position: 101
  - id: threads
    type:
      - 'null'
      - string
    doc: Number of threads to use.
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
stdout: mdmcleaner_check_dependencies.out
