cwlVersion: v1.2
class: CommandLineTool
baseCommand: obiclean
label: obitools_obiclean
doc: "The obiclean program is used to clean a set of sequences by looking for PCR
  errors. It identifies 'head' sequences (sequences that are not variants of any other
  sequence) and 'internal' sequences (sequences that are likely variants of a head
  sequence).\n\nTool homepage: http://metabarcoding.org/obitools"
inputs:
  - id: input_file
    type:
      - 'null'
      - File
    doc: Input sequence file (e.g., in fasta or fastq format).
    inputBinding:
      position: 1
  - id: distance
    type:
      - 'null'
      - int
    doc: Maximum number of errors (distance) allowed between two sequences to consider
      one as a variant of the other.
    inputBinding:
      position: 102
      prefix: --distance
  - id: head
    type:
      - 'null'
      - boolean
    doc: Only sequences identified as 'head' (not variants) are kept in the output.
    inputBinding:
      position: 102
      prefix: --head
  - id: internal
    type:
      - 'null'
      - boolean
    doc: Only sequences identified as 'internal' (variants) are kept in the output.
    inputBinding:
      position: 102
      prefix: --internal
  - id: ratio
    type:
      - 'null'
      - float
    doc: Threshold ratio between the count of a sequence and the count of its potential
      variant. If the ratio is higher than this threshold, the sequence is not considered
      a variant.
    inputBinding:
      position: 102
      prefix: --ratio
  - id: sample
    type:
      - 'null'
      - string
    doc: Attribute name containing the sample information. If provided, the cleaning
      is performed sample by sample.
    inputBinding:
      position: 102
      prefix: --sample
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/obitools:1.2.13--py27h516909a_0
stdout: obitools_obiclean.out
