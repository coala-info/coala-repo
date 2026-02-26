cwlVersion: v1.2
class: CommandLineTool
baseCommand: ivar_variants
label: ivar_variants
doc: "Call variants from a mpileup file\n\nTool homepage: https://andersen-lab.github.io/ivar/html/"
inputs:
  - id: count_gaps
    type:
      - 'null'
      - boolean
    doc: Count gaps towards depth. By default, gaps are not counted
    inputBinding:
      position: 101
      prefix: -G
  - id: gff_file
    type:
      - 'null'
      - File
    doc: A GFF file in the GFF3 format can be supplied to specify coordinates of
      open reading frames (ORFs). In absence of GFF file, amino acid translation
      will not be done.
    inputBinding:
      position: 101
      prefix: -g
  - id: min_frequency_threshold
    type:
      - 'null'
      - float
    doc: Minimum frequency threshold(0 - 1) to call variants
    default: 0.03
    inputBinding:
      position: 101
      prefix: -t
  - id: min_quality
    type:
      - 'null'
      - int
    doc: Minimum quality score threshold to count base
    default: 20
    inputBinding:
      position: 101
      prefix: -q
  - id: minimum_depth
    type:
      - 'null'
      - int
    doc: Minimum read depth to call variants
    default: 0
    inputBinding:
      position: 101
      prefix: -m
  - id: prefix
    type: string
    doc: Prefix for the output tsv variant file
    inputBinding:
      position: 101
      prefix: -p
  - id: reference_fasta
    type:
      - 'null'
      - File
    doc: Reference file used for alignment. This is used to translate the 
      nucleotide sequences and identify intra host single nucleotide variants
    inputBinding:
      position: 101
      prefix: -r
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ivar:1.4.4--h077b44d_0
stdout: ivar_variants.out
