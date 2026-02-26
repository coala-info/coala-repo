cwlVersion: v1.2
class: CommandLineTool
baseCommand: maq_glfgen
label: maq_glfgen
doc: "Generate GLF file from maq assembly\n\nTool homepage: https://github.com/maqetta/maqetta"
inputs:
  - id: output_cns
    type: File
    doc: Output consensus file
    inputBinding:
      position: 1
  - id: chr_bfa
    type: File
    doc: BFA file for chromosome
    inputBinding:
      position: 2
  - id: input_map
    type: File
    doc: Input map file
    inputBinding:
      position: 3
  - id: dependency_coefficient
    type:
      - 'null'
      - float
    doc: dependency coefficient (theta)
    default: 0.85
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
  - id: expected_rate_heterozygotes
    type:
      - 'null'
      - float
    doc: expected rate of heterozygotes
    default: 0.001
    inputBinding:
      position: 104
      prefix: -r
  - id: max_mismatches
    type:
      - 'null'
      - int
    doc: maximum number of mismatches
    default: 7
    inputBinding:
      position: 104
      prefix: -m
  - id: max_sum_errors
    type:
      - 'null'
      - int
    doc: maximum sum of errors
    default: 60
    inputBinding:
      position: 104
      prefix: -Q
  - id: min_mapping_quality
    type:
      - 'null'
      - int
    doc: minimum mapping quality
    default: 0
    inputBinding:
      position: 104
      prefix: -q
  - id: num_haplotypes
    type:
      - 'null'
      - int
    doc: number of haplotypes (>=2)
    default: 2
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
stdout: maq_glfgen.out
