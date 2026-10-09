cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - jannovar
  - statistics
label: jannovar-cli_jannovar_statistics
doc: "Compute statistics about variants in a VCF file\n\nTool homepage: https://github.com/charite/jannovar"
inputs:
  - id: input_vcf
    type: File
    doc: "Path to input VCF file"
    inputBinding:
      position: 101
      prefix: --input-vcf
  - id: output_report
    type: string
    doc: "Path to output report TXT file"
    inputBinding:
      position: 101
      prefix: --output-report
  - id: database
    type: File
    doc: "Path to database .ser file"
    inputBinding:
      position: 101
      prefix: --database
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
  - id: report
    type: File
    doc: Statistics report
    outputBinding:
      glob: $(inputs.output_report)
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jannovar-cli:0.36--hdfd78af_0
stdout: jannovar-cli_jannovar_statistics.out
