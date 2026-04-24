cwlVersion: v1.2
class: CommandLineTool
baseCommand: vcf_validator
label: vcf-validator_vcf_validator
doc: "vcf_validator version 0.10.2\n\nTool homepage: https://github.com/EBIVariation/vcf-validator"
inputs:
  - id: input_file
    type:
      - 'null'
      - File
    doc: Path to the input VCF file, or stdin
    inputBinding:
      position: 101
      prefix: --input
  - id: level
    type:
      - 'null'
      - string
    doc: Validation level (error, warning, stop)
    inputBinding:
      position: 101
      prefix: --level
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Output directory
    inputBinding:
      position: 101
      prefix: --outdir
  - id: report
    type:
      - 'null'
      - string
    doc: Comma separated values for types of reports (summary, text)
    inputBinding:
      position: 101
      prefix: --report
  - id: require_evidence
    type:
      - 'null'
      - boolean
    doc: Flag to check genotypes or allele frequencies are present
    inputBinding:
      position: 101
      prefix: --require-evidence
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vcf-validator:0.10.2--h7a61d87_0
stdout: vcf-validator_vcf_validator.out
