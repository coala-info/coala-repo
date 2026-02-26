cwlVersion: v1.2
class: CommandLineTool
baseCommand: psosp
label: psosp_test
doc: "A tool for host-virus sequence analysis (psosp)\n\nTool homepage: https://github.com/mujiezhang/PSOSP"
inputs:
  - id: subcommand
    type: string
    doc: 'The action to perform: test or predict'
    inputBinding:
      position: 1
  - id: checkv_db
    type:
      - 'null'
      - Directory
    doc: CheckV database directory
    inputBinding:
      position: 102
      prefix: --checkv_db
  - id: host_faa
    type:
      - 'null'
      - File
    doc: Host protein FASTA file (FAA)
    inputBinding:
      position: 102
      prefix: --host_faa
  - id: host_fasta
    type:
      - 'null'
      - File
    doc: Host FASTA file
    inputBinding:
      position: 102
      prefix: --host_fasta
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose output
    inputBinding:
      position: 102
      prefix: -v
  - id: virus_fasta
    type:
      - 'null'
      - File
    doc: Virus FASTA file
    inputBinding:
      position: 102
      prefix: --virus_fasta
  - id: working_dir
    type:
      - 'null'
      - Directory
    doc: Working directory
    inputBinding:
      position: 102
      prefix: --working_dir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/psosp:1.1.2--pyhdfd78af_2
stdout: psosp_test.out
