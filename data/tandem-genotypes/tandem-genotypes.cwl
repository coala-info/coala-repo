cwlVersion: v1.2
class: CommandLineTool
baseCommand: tandem-genotypes
label: tandem-genotypes
doc: "Try to indicate genotypes of tandem repeats.\n\nTool homepage: https://github.com/mcfrith/tandem-genotypes"
inputs:
  - id: microsat_file
    type: File
    doc: microsat.txt
    inputBinding:
      position: 1
  - id: alignments_file
    type: File
    doc: alignments.maf
    inputBinding:
      position: 2
  - id: alignment_beyond_repeat
    type:
      - 'null'
      - int
    doc: require alignment >= BP beyond both sides of a repeat
    inputBinding:
      position: 103
      prefix: --far
  - id: genes_file
    type:
      - 'null'
      - File
    doc: read genes from a genePred or BED file
    inputBinding:
      position: 103
      prefix: --genes
  - id: insertion_length
    type:
      - 'null'
      - int
    doc: count insertions <= BP beyond a repeat
    inputBinding:
      position: 103
      prefix: --near
  - id: min_unit_length
    type:
      - 'null'
      - int
    doc: ignore repeats with unit shorter than BP
    inputBinding:
      position: 103
      prefix: --min-unit
  - id: mismap_probability
    type:
      - 'null'
      - float
    doc: ignore any alignment with mismap probability > PROB
    inputBinding:
      position: 103
      prefix: --mismap
  - id: mode
    type:
      - 'null'
      - string
    doc: L=lenient, S=strict
    inputBinding:
      position: 103
      prefix: --mode
  - id: output_format
    type:
      - 'null'
      - int
    doc: 'output format: 1=original, 2=alleles'
    inputBinding:
      position: 103
      prefix: --output
  - id: postmask
    type:
      - 'null'
      - int
    doc: ignore mostly-lowercase alignments
    inputBinding:
      position: 103
      prefix: --postmask
  - id: promoter_length
    type:
      - 'null'
      - int
    doc: promoter length
    inputBinding:
      position: 103
      prefix: --promoter
  - id: scores_file
    type:
      - 'null'
      - File
    doc: importance scores for gene parts
    inputBinding:
      position: 103
      prefix: --scores
  - id: select
    type:
      - 'null'
      - int
    doc: 'select: all repeats (0), non-intergenic repeats (1), non-intergenic non-intronic
      repeats (2)'
    inputBinding:
      position: 103
      prefix: --select
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: show more details
    inputBinding:
      position: 103
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tandem-genotypes:1.9.2--pyh7e72e81_0
stdout: tandem-genotypes.out
