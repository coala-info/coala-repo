cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - jannovar
  - vardb-import
label: jannovar-cli_jannovar_vardb-import
doc: "Import variants from VCF files into a Jannovar H2 vardb file\n\nTool homepage: https://github.com/charite/jannovar"
inputs:
  - id: genome_build
    type: string
    doc: "String to use for genome build"
    inputBinding:
      position: 101
      prefix: --genome-build
  - id: database_file
    type: string
    doc: "Path to database file (created if it does not exist)"
    inputBinding:
      position: 101
      prefix: --database-file
  - id: vcf_files
    type:
      type: array
      items: File
    doc: "Path to VCF file(s), each with its .tbi tabix index (bgzipped VCF) or .idx index"
    secondaryFiles:
      - pattern: .tbi
        required: false
      - pattern: .idx
        required: false
    inputBinding:
      position: 101
      prefix: --vcf-files
  - id: table_name
    type: string
    doc: "Name of table after import"
    inputBinding:
      position: 101
      prefix: --table-name
  - id: db_name
    type: string
    doc: "Datbase name"
    inputBinding:
      position: 101
      prefix: --db-name
  - id: db_version
    type: string
    doc: "Database version"
    inputBinding:
      position: 101
      prefix: --db-version
  - id: default_prefix
    type: string
    doc: "Default prefix for annotating"
    inputBinding:
      position: 101
      prefix: --default-prefix
  - id: vcf_info_fields
    type:
      type: array
      items: string
    doc: "INFO fields to import"
    inputBinding:
      position: 101
      prefix: --vcf-info-fields
  - id: truncate_table
    type: ['null', boolean]
    doc: "Truncate table before first import"
    inputBinding:
      position: 101
      prefix: --truncate-table
  - id: report_no_progress
    type: ['null', boolean]
    doc: "Disable progress report, more quiet mode"
    inputBinding:
      position: 101
      prefix: --report-no-progress
  - id: verbose
    type: ['null', boolean]
    doc: "Enable verbose mode"
    inputBinding:
      position: 101
      prefix: --verbose
  - id: very_verbose
    type: ['null', boolean]
    doc: "Enable very verbose mode"
    inputBinding:
      position: 101
      prefix: --very-verbose
  - id: http_proxy
    type: ['null', string]
    doc: "Set HTTP proxy to use, if any"
    inputBinding:
      position: 101
      prefix: --http-proxy
  - id: https_proxy
    type: ['null', string]
    doc: "Set HTTPS proxy to use, if any"
    inputBinding:
      position: 101
      prefix: --https-proxy
  - id: ftp_proxy
    type: ['null', string]
    doc: "Set FTP proxy to use, if any"
    inputBinding:
      position: 101
      prefix: --ftp-proxy
outputs:
  - id: vardb
    type: File
    doc: H2 database file written for the given database file name
    outputBinding:
      glob: $(inputs.database_file)*
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jannovar-cli:0.36--hdfd78af_0
stdout: jannovar-cli_jannovar_vardb-import.out
