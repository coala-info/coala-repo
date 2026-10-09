cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - jannovar
  - annotate-csv
label: jannovar-cli_jannovar_annotate-csv
doc: "Perform annotation of genomic changes given in a CSV file\n\nTool homepage: https://github.com/charite/jannovar"
inputs:
  - id: database
    type: File
    doc: "Path to database .ser file"
    inputBinding:
      position: 101
      prefix: --database
  - id: input
    type: File
    doc: "CSV file"
    inputBinding:
      position: 101
      prefix: --input
  - id: chr
    type: int
    doc: "Column of chr (1 based)"
    inputBinding:
      position: 101
      prefix: --chr
  - id: pos
    type: int
    doc: "Column of pos (1 based)"
    inputBinding:
      position: 101
      prefix: --pos
  - id: ref
    type: int
    doc: "Column of ref (1 based)"
    inputBinding:
      position: 101
      prefix: --ref
  - id: alt
    type: int
    doc: "Column of alt (1 based)"
    inputBinding:
      position: 101
      prefix: --alt
  - id: type
    type:
      - 'null'
      - type: enum
        symbols:
          - Default
          - TDF
          - RFC4180
          - Excel
          - MySQL
    doc: Type of csv file.
    inputBinding:
      position: 101
      prefix: --type
  - id: header
    type: ['null', boolean]
    doc: "Set if the file contains a header."
    inputBinding:
      position: 101
      prefix: --header
  - id: show_all
    type: ['null', boolean]
    doc: "Show all effects"
    inputBinding:
      position: 101
      prefix: --show-all
  - id: no_3_prime_shifting
    type: ['null', boolean]
    doc: "Disable shifting towards 3' of transcript"
    inputBinding:
      position: 101
      prefix: --no-3-prime-shifting
  - id: three_letter_amino_acids
    type: ['null', boolean]
    doc: "Enable usage of 3 letter amino acid codes"
    inputBinding:
      position: 101
      prefix: --3-letter-amino-acids
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
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jannovar-cli:0.36--hdfd78af_0
stdout: jannovar-cli_jannovar_annotate-csv.out
