cwlVersion: v1.2
class: CommandLineTool
baseCommand: dirseq
label: dirseq
doc: "Reports the coverage of a mapping in against each gene given in a GFF file\n\
  \nTool homepage: https://github.com/wwood/dirseq"
inputs:
  - id: accepted_feature_types
    type:
      - 'null'
      - string
    doc: Print only features of these type(s)
    inputBinding:
      position: 101
      prefix: --accepted-feature-types
  - id: bam_file
    type: File
    doc: path to mapping file
    inputBinding:
      position: 101
      prefix: --bam
  - id: comment_fields
    type:
      - 'null'
      - string
    doc: Print elements from the comments in the GFF file
    inputBinding:
      position: 101
      prefix: --comment-fields
  - id: forward_read_only
    type:
      - 'null'
      - boolean
    doc: consider only forward reads (i.e. read1) and ignore reverse reads.
    inputBinding:
      position: 101
      prefix: --forward-read-only
  - id: gff_file
    type: File
    doc: path to GFF3 file
    inputBinding:
      position: 101
      prefix: --gff
  - id: ignore_directions
    type:
      - 'null'
      - boolean
    doc: ignore directionality, give overall coverage
    inputBinding:
      position: 101
      prefix: --ignore-directions
  - id: logger
    type:
      - 'null'
      - string
    doc: Log to file
    inputBinding:
      position: 101
      prefix: --logger
  - id: measure_type
    type:
      - 'null'
      - string
    doc: what to count for each gene
    inputBinding:
      position: 101
      prefix: --measure-type
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Run quietly, set logging to ERROR level
    inputBinding:
      position: 101
      prefix: --quiet
  - id: sam_filter_flags
    type:
      - 'null'
      - string
    doc: Apply these samtools filters
    inputBinding:
      position: 101
      prefix: --sam-filter-flags
  - id: trace
    type:
      - 'null'
      - string
    doc: Set log level
    inputBinding:
      position: 101
      prefix: --trace
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dirseq:0.4.3--hdfd78af_0
stdout: dirseq.out
