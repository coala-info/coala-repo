cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - jannovar
  - annotate-pos
label: jannovar-cli_jannovar_annotate-pos
doc: "Perform annotation of genomic changes given on the command line\n\nTool homepage: https://github.com/charite/jannovar"
inputs:
  - id: database
    type: File
    doc: "Path to database .ser file"
    inputBinding:
      position: 101
      prefix: --database
  - id: genomic_change
    type:
      type: array
      items: string
      inputBinding:
        prefix: -c
    doc: "Genomic change to annotate, you can give multiple ones"
    inputBinding:
      position: 101
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
stdout: jannovar-cli_jannovar_annotate-pos.out
