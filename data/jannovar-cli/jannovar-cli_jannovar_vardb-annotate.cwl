cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - jannovar
  - vardb-annotate
label: jannovar-cli_jannovar_vardb-annotate
doc: "Annotate a VCF file using a Jannovar H2 vardb file\n\nTool homepage: https://github.com/charite/jannovar"
inputs:
  - id: genome_build
    type: string
    doc: "String to use for genome build"
    inputBinding:
      position: 101
      prefix: --genome-build
  - id: database_file
    type: File
    doc: "Path to database file"
    inputBinding:
      position: 101
      prefix: --database-file
  - id: input_vcf
    type: File
    doc: "Path to input VCF file"
    inputBinding:
      position: 101
      prefix: --input-vcf
  - id: output_vcf
    type: string
    doc: "Name to output VCf file"
    inputBinding:
      position: 101
      prefix: --output-vcf
  - id: table_names
    type:
      type: array
      items: string
    doc: "Names of tables to use for annotating"
    inputBinding:
      position: 101
      prefix: --table-names
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
  - id: annotated_vcf
    type: File
    doc: Annotated VCF file
    outputBinding:
      glob: $(inputs.output_vcf)
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jannovar-cli:0.36--hdfd78af_0
stdout: jannovar-cli_jannovar_vardb-annotate.out
