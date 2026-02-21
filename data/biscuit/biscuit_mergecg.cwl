cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - biscuit
  - mergecg
label: biscuit_mergecg
doc: "Merge CpG sites from a position-sorted BED file with beta values and coverages.
  Typically used with output from biscuit vcf2bed.\n\nTool homepage: https://github.com/huishenlab/biscuit"
inputs:
  - id: reference_fasta
    type: File
    doc: Reference FASTA file
    inputBinding:
      position: 1
  - id: input_bed
    type: File
    doc: Position sorted BED file with beta values and coverages found in columns
      4 and 5
    inputBinding:
      position: 2
  - id: min_depth
    type:
      - 'null'
      - int
    doc: Minimum depth after merging - applies to the maximum depth across samples
    default: 0
    inputBinding:
      position: 103
      prefix: -k
  - id: nome_seq_mode
    type:
      - 'null'
      - boolean
    doc: NOMe-seq mode, only merge C,G both in HCGD context
    inputBinding:
      position: 103
      prefix: -N
  - id: output_beta_m_u
    type:
      - 'null'
      - boolean
    doc: Output Beta-M-U instead of Beta-Cov (input is still Beta-Cov)
    inputBinding:
      position: 103
      prefix: -c
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biscuit:1.7.1.20250908--hc4b60c0_0
stdout: biscuit_mergecg.out
