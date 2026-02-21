cwlVersion: v1.2
class: CommandLineTool
baseCommand: ValidateVcf
label: biopet-validatevcf
doc: "A tool to validate a VCF file against a reference fasta file.\n\nTool homepage:
  https://github.com/biopet/validatevcf"
inputs:
  - id: disable_fail
    type:
      - 'null'
      - boolean
    doc: Do not fail on error. The tool will still exit when encountering an error,
      but will do so with exit code 0
    inputBinding:
      position: 101
      prefix: --disableFail
  - id: input_vcf
    type: File
    doc: Vcf file to check
    inputBinding:
      position: 101
      prefix: --inputVcf
  - id: log_level
    type:
      - 'null'
      - string
    doc: "Level of log information printed. Possible levels: 'debug', 'info', 'warn',
      'error'"
    inputBinding:
      position: 101
      prefix: --log_level
  - id: reference
    type: File
    doc: Reference fasta to check vcf file against
    inputBinding:
      position: 101
      prefix: --reference
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biopet-validatevcf:0.1--0
stdout: biopet-validatevcf.out
