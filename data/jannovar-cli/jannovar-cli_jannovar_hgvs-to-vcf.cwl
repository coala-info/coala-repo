cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - jannovar
  - hgvs-to-vcf
label: jannovar-cli_jannovar_hgvs-to-vcf
doc: "Project transcript-level changes (HGVS) to chromosome-level changes in a VCF file\n\nTool homepage: https://github.com/charite/jannovar"
inputs:
  - id: reference_fasta
    type: File
    doc: "Path to reference FASTA file (needs the .fai index and the .dict dictionary beside it)"
    secondaryFiles:
      - .fai
      - ^.dict
    inputBinding:
      position: 101
      prefix: --reference-fasta
  - id: database
    type: File
    doc: "Path to database .ser file"
    inputBinding:
      position: 101
      prefix: --database
  - id: input_txt
    type: File
    doc: "Input file with HGVS transcript-level changes, line-by-line"
    inputBinding:
      position: 101
      prefix: --input-txt
  - id: output_vcf
    type: string
    doc: "Output VCF file with chromosome-level changes"
    inputBinding:
      position: 101
      prefix: --output-vcf
  - id: show_all
    type: ['null', string]
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
  - id: vcf
    type: File
    doc: VCF file with chromosome-level changes
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
stdout: jannovar-cli_jannovar_hgvs-to-vcf.out
