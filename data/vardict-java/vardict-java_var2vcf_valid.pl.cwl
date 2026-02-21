cwlVersion: v1.2
class: CommandLineTool
baseCommand: var2vcf_valid.pl
label: vardict-java_var2vcf_valid.pl
doc: "Post-processing script for VarDict to filter variants and convert the tabular
  output to VCF format.\n\nTool homepage: https://github.com/AstraZeneca-NGS/VarDictJava"
inputs:
  - id: input_file
    type:
      - 'null'
      - File
    doc: Input tabular file from VarDict. If omitted, reads from stdin.
    inputBinding:
      position: 1
  - id: buffer_size
    type:
      - 'null'
      - int
    doc: The buffer size for sorting
    default: 0
    inputBinding:
      position: 102
      prefix: -b
  - id: chromosome_column
    type:
      - 'null'
      - int
    doc: The column for chromosome
    default: 1
    inputBinding:
      position: 102
      prefix: -c
  - id: filter_germline
    type:
      - 'null'
      - boolean
    doc: Filter for germline mutations
    inputBinding:
      position: 102
      prefix: -E
  - id: filter_somatic
    type:
      - 'null'
      - boolean
    doc: Filter for somatic mutations
    inputBinding:
      position: 102
      prefix: -S
  - id: keep_all
    type:
      - 'null'
      - boolean
    doc: Keep all variants, do not filter
    inputBinding:
      position: 102
      prefix: -A
  - id: min_allele_freq
    type:
      - 'null'
      - float
    doc: The minimum allele frequency
    default: 0.02
    inputBinding:
      position: 102
      prefix: -f
  - id: min_depth
    type:
      - 'null'
      - int
    doc: The minimum total depth
    default: 5
    inputBinding:
      position: 102
      prefix: -d
  - id: min_mean_quality
    type:
      - 'null'
      - int
    doc: The minimum mean quality
    default: 20
    inputBinding:
      position: 102
      prefix: -m
  - id: min_variant_allele_count
    type:
      - 'null'
      - int
    doc: The minimum variant allele count
    default: 2
    inputBinding:
      position: 102
      prefix: -v
  - id: position_column
    type:
      - 'null'
      - int
    doc: The column for position
    default: 2
    inputBinding:
      position: 102
      prefix: -p
  - id: ref_allele_column
    type:
      - 'null'
      - int
    doc: The column for reference allele
    default: 4
    inputBinding:
      position: 102
      prefix: -r
  - id: sample_name
    type:
      - 'null'
      - string
    doc: The sample name
    inputBinding:
      position: 102
      prefix: -N
  - id: var_allele_column
    type:
      - 'null'
      - int
    doc: The column for variant allele
    default: 5
    inputBinding:
      position: 102
      prefix: -a
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vardict-java:1.8.3--hdfd78af_0
stdout: vardict-java_var2vcf_valid.pl.out
