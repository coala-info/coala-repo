cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - kcftools
  - kcf2plink
label: kcftools_kcf2plink
doc: "Convert KCF windows to PED format\n\nTool homepage: https://github.com/sivasubramanics/kcftools"
inputs:
  - id: chrs_file
    type:
      - 'null'
      - File
    doc: List file with chromosomes to include
    inputBinding:
      position: 101
      prefix: --chrs
  - id: input_file
    type: File
    doc: Input KCF file
    inputBinding:
      position: 101
      prefix: --input
  - id: max_missing
    type:
      - 'null'
      - float
    doc: Maximum proportion of missing data to consider a window valid
    inputBinding:
      position: 101
      prefix: --max-missing
  - id: min_maf
    type:
      - 'null'
      - float
    doc: Minimum allele frequency to consider a window valid
    inputBinding:
      position: 101
      prefix: --maf
  - id: output_prefix
    type: string
    doc: Output PED file prefix
    inputBinding:
      position: 101
      prefix: --output
  - id: score_a
    type:
      - 'null'
      - float
    doc: Lower score cut-off for reference allele
    inputBinding:
      position: 101
      prefix: --score_a
  - id: score_b
    type:
      - 'null'
      - float
    doc: Lower score cut-off for alternate allele
    inputBinding:
      position: 101
      prefix: --score_b
  - id: score_n
    type:
      - 'null'
      - float
    doc: Score value for missing data
    default: 30.0
    inputBinding:
      position: 101
      prefix: --score_n
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kcftools:0.4.0--hdfd78af_0
stdout: kcftools_kcf2plink.out
