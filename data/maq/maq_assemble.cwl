cwlVersion: v1.2
class: CommandLineTool
baseCommand: maq_assemble
label: maq_assemble
doc: "Assemble genome sequences\n\nTool homepage: https://github.com/maqetta/maqetta"
inputs:
  - id: output_cns
    type: File
    doc: Output consensus sequence file
    inputBinding:
      position: 1
  - id: chr_bfa
    type: File
    doc: Chromosome BFA file
    inputBinding:
      position: 2
  - id: input_map
    type: File
    doc: Input mapping file
    inputBinding:
      position: 3
  - id: dependency_coefficient
    type:
      - 'null'
      - float
    doc: dependency coefficient (theta)
    inputBinding:
      position: 104
      prefix: -t
  - id: discard_abnormal_pairs
    type:
      - 'null'
      - boolean
    doc: discard abnormal pairs
    inputBinding:
      position: 104
      prefix: -p
  - id: expected_heterozygotes
    type:
      - 'null'
      - float
    doc: expected rate of heterozygotes
    inputBinding:
      position: 104
      prefix: -r
  - id: max_mismatches
    type:
      - 'null'
      - int
    doc: maximum number of mismatches
    inputBinding:
      position: 104
      prefix: -m
  - id: max_sum_errors
    type:
      - 'null'
      - int
    doc: maximum sum of errors
    inputBinding:
      position: 104
      prefix: -Q
  - id: min_mapping_quality
    type:
      - 'null'
      - int
    doc: minimum mapping quality
    inputBinding:
      position: 104
      prefix: -q
  - id: num_haplotypes
    type:
      - 'null'
      - int
    doc: number of haplotypes (>=2)
    inputBinding:
      position: 104
      prefix: -N
  - id: use_single_end_mapping_quality
    type:
      - 'null'
      - boolean
    doc: use single-end mapping quality
    inputBinding:
      position: 104
      prefix: -s
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/maq:v0.7.1-8-deb_cv1
stdout: maq_assemble.out
