cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - biscuit
  - vcf2bed
label: biscuit_vcf2bed
doc: "Extract methylation or SNP information from a VCF file into BED format.\n\n
  Tool homepage: https://github.com/huishenlab/biscuit"
inputs:
  - id: input_vcf
    type: File
    doc: Input VCF file
    inputBinding:
      position: 1
  - id: extract_type
    type:
      - 'null'
      - string
    doc: Extract type {c, cg, ch, hcg, gch, snp}
    default: CG
    inputBinding:
      position: 102
      prefix: -t
  - id: min_coverage
    type:
      - 'null'
      - int
    doc: Minimum coverage (see Note 1)
    default: 1
    inputBinding:
      position: 102
      prefix: -k
  - id: output_beta_m_u
    type:
      - 'null'
      - boolean
    doc: Output Beta-M-U instead of Beta-Cov.
    inputBinding:
      position: 102
      prefix: -c
  - id: sample
    type:
      - 'null'
      - string
    doc: Sample, (takes "FIRST", "LAST", "ALL", or specific sample names separated
      by ",")
    default: FIRST
    inputBinding:
      position: 102
      prefix: -s
  - id: show_context
    type:
      - 'null'
      - boolean
    doc: Show context (reference base, context group {CG,CHG,CHH}, 2-base {CA,CC,CG,CT}
      and 5-base context) before beta value and coverage column
    inputBinding:
      position: 102
      prefix: -e
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biscuit:1.7.1.20250908--hc4b60c0_0
stdout: biscuit_vcf2bed.out
