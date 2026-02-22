cwlVersion: v1.2
class: CommandLineTool
baseCommand: abricate-get_db
label: abricate_abricate-get_db
doc: "Download databases for abricate to use\n\nTool homepage: https://github.com/tseemann/abricate"
inputs:
  - id: database
    type: string
    doc: 'Choices: argannot bacmet2 card ecoh ecoli_vf megares ncbi plasmidfinder
      resfinder vfdb victors'
    inputBinding:
      position: 101
      prefix: --db
  - id: dbdir
    type:
      - 'null'
      - Directory
    doc: Parent folder
    default: /usr/local/db
    inputBinding:
      position: 101
      prefix: --dbdir
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Verbose debug output
    default: '0'
    inputBinding:
      position: 101
      prefix: --debug
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force download even if exists
    default: '0'
    inputBinding:
      position: 101
      prefix: --force
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/abricate:1.2.0--h05cac1d_0
stdout: abricate_abricate-get_db.out
