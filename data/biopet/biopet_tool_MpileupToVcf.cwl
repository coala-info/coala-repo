cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - biopet
  - tool
  - MpileupToVcf
label: biopet_tool_MpileupToVcf
doc: "Call variants from samtools mpileup output and write VCF.\n\nTool homepage: https://github.com/biopet/biopet"
inputs:
  - id: input
    type:
      - 'null'
      - File
    doc: input mpileup file, default is stdin
    inputBinding:
      position: 101
      prefix: --input
  - id: output
    type: string
    doc: output VCF file
    inputBinding:
      position: 101
      prefix: --output
  - id: sample
    type: string
    doc: Sample name
    inputBinding:
      position: 101
      prefix: --sample
  - id: min_dp
    type:
      - 'null'
      - int
    doc: Minimal depth
    inputBinding:
      position: 101
      prefix: --minDP
  - id: min_ap
    type:
      - 'null'
      - int
    doc: Minimal alternative allele count
    inputBinding:
      position: 101
      prefix: --minAP
  - id: homo_fraction
    type:
      - 'null'
      - double
    doc: Fraction for a homozygous call
    inputBinding:
      position: 101
      prefix: --homoFraction
  - id: ploidy
    type:
      - 'null'
      - int
    doc: Ploidy
    inputBinding:
      position: 101
      prefix: --ploidy
  - id: seq_error
    type:
      - 'null'
      - double
    doc: Sequencing error rate
    inputBinding:
      position: 101
      prefix: --seqError
  - id: ref_calls
    type:
      - 'null'
      - boolean
    doc: Also output reference calls
    inputBinding:
      position: 101
      prefix: --refCalls
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
  - id: output_vcf
    type: File
    doc: Output VCF file
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biopet:0.9.0--py36r3.3.2_0
