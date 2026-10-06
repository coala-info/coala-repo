cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - biopet
  - tool
  - ValidateVcf
label: biopet_tool_ValidateVcf
doc: "Check a VCF file against a reference FASTA.\n\nTool homepage: https://github.com/biopet/biopet"
inputs:
  - id: input_vcf
    type: File
    doc: Vcf file to check
    inputBinding:
      position: 101
      prefix: --inputVcf
  - id: reference
    type: File
    doc: Reference fasta to check vcf file against
    secondaryFiles:
      - pattern: .fai
        required: false
      - pattern: ^.dict
        required: false
    inputBinding:
      position: 101
      prefix: --reference
  - id: disable_fail
    type:
      - 'null'
      - boolean
    doc: Do not fail on error. The tool will still exit when encountering an error, but will
      do so with exit code 0
    inputBinding:
      position: 101
      prefix: --disableFail
  - id: log_level
    type:
      - 'null'
      - string
    doc: 'Level of log information printed. Possible levels: ''debug'', ''info'', ''warn'',
      ''error'''
    inputBinding:
      position: 101
      prefix: --log_level
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: stderr
    type: stderr
    doc: Standard error (log)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biopet:0.9.0--py36r3.3.2_0
stdout: biopet_tool_ValidateVcf.out
stderr: biopet_tool_ValidateVcf.log
