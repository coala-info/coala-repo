cwlVersion: v1.2
class: CommandLineTool
baseCommand: abricate-get_db
label: abricate_abricate-get_db
doc: "Download databases for abricate to use\n\nTool homepage: https://github.com/tseemann/abricate"
requirements:
  - class: NetworkAccess
    networkAccess: true
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: "$({class: 'Directory', basename: inputs.dbdir, listing: []})"
        writable: true
inputs:
  - id: database
    type: string
    doc: 'Choices: argannot bacmet2 card ecoh ecoli_vf megares ncbi plasmidfinder resfinder vfdb victors'
    inputBinding:
      position: 101
      prefix: --db
  - id: dbdir
    type: string
    doc: Parent folder for the downloaded database (created in the output directory).
    inputBinding:
      position: 101
      prefix: --dbdir
    default: abricate_db
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Verbose debug output
    inputBinding:
      position: 101
      prefix: --debug
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force download even if exists
    inputBinding:
      position: 101
      prefix: --force
outputs:
  - id: database_dir
    type: Directory
    doc: Downloaded and indexed database (<dbdir>/<db>).
    outputBinding:
      glob: $(inputs.dbdir)
  - id: log
    type: stdout
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/abricate:1.2.0--h05cac1d_0
stdout: abricate_abricate-get_db.out
