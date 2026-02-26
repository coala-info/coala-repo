cwlVersion: v1.2
class: CommandLineTool
baseCommand: bio
label: bio_align
doc: "Perform sequence alignment\n\nTool homepage: https://github.com/ialbert/bio"
inputs:
  - id: sequences
    type:
      - 'null'
      - type: array
        items: string
    doc: Input sequences
    inputBinding:
      position: 1
  - id: extend_penalty
    type:
      - 'null'
      - int
    doc: gap extend penalty
    default: 1
    inputBinding:
      position: 102
      prefix: --extend
  - id: global_alignment
    type:
      - 'null'
      - boolean
    doc: local alignment
    inputBinding:
      position: 102
      prefix: --global
  - id: local_alignment
    type:
      - 'null'
      - boolean
    doc: local alignment
    inputBinding:
      position: 102
      prefix: --local
  - id: match_score
    type:
      - 'null'
      - int
    doc: alignment match (DNA only)
    default: 1
    inputBinding:
      position: 102
      prefix: --match
  - id: matrix
    type:
      - 'null'
      - string
    doc: 'matrix default: NUC4.4. or BLOSUM62)'
    default: ''
    inputBinding:
      position: 102
      prefix: --matrix
  - id: mismatch_penalty
    type:
      - 'null'
      - int
    doc: alignment mismatch (DNA only)
    default: 2
    inputBinding:
      position: 102
      prefix: --mismatch
  - id: open_penalty
    type:
      - 'null'
      - int
    doc: gap open penalty
    default: 11
    inputBinding:
      position: 102
      prefix: --open
  - id: output_mutations
    type:
      - 'null'
      - boolean
    doc: output mutations
    inputBinding:
      position: 102
      prefix: --diff
  - id: output_pileup
    type:
      - 'null'
      - boolean
    doc: output pileup
    inputBinding:
      position: 102
      prefix: --pile
  - id: output_tabular
    type:
      - 'null'
      - boolean
    doc: output in tabular format
    inputBinding:
      position: 102
      prefix: --table
  - id: output_variant_columns
    type:
      - 'null'
      - boolean
    doc: output variant columns
    inputBinding:
      position: 102
      prefix: --fasta
  - id: semiglobal_alignment
    type:
      - 'null'
      - boolean
    doc: local alignment
    inputBinding:
      position: 102
      prefix: --semiglobal
  - id: show_all_alignments
    type:
      - 'null'
      - boolean
    doc: show all alignments
    inputBinding:
      position: 102
      prefix: --all
outputs:
  - id: output_vcf
    type:
      - 'null'
      - File
    doc: output vcf file
    outputBinding:
      glob: $(inputs.output_vcf)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bio:1.8.1--pyhdfd78af_0
