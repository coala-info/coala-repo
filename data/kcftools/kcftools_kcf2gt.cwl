cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - kcftools
  - kcf2gt
label: kcftools_kcf2gt
doc: "Convert KCF to Genotype Table\n\nTool homepage: https://github.com/sivasubramanics/kcftools"
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
    doc: maximum proportion of missing data to consider a window valid
    inputBinding:
      position: 101
      prefix: --max-missing
  - id: min_maf
    type:
      - 'null'
      - float
    doc: minimum allele frequency to consider a window valid
    inputBinding:
      position: 101
      prefix: --maf
  - id: score_a
    type:
      - 'null'
      - float
    doc: Lower score cut-off for reference allele
    default: 95.0
    inputBinding:
      position: 101
      prefix: --score_a
  - id: score_b
    type:
      - 'null'
      - float
    doc: Lower score cut-off for alternate allele
    default: 60.0
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
  - id: output_file
    type: File
    doc: Output file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kcftools:0.4.0--hdfd78af_0
