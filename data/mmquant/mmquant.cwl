cwlVersion: v1.2
class: CommandLineTool
baseCommand: mmquant
label: mmquant
doc: "Quantify reads against an annotation file.\n\nTool homepage: https://bitbucket.org/mzytnicki/multi-mapping-counter/"
inputs:
  - id: annotation_file
    type: File
    doc: annotation file in GTF format
    inputBinding:
      position: 101
      prefix: -a
  - id: count_threshold
    type:
      - 'null'
      - int
    doc: count threshold
    default: 0
    inputBinding:
      position: 101
      prefix: -c
  - id: featurecounts_output_style
    type:
      - 'null'
      - boolean
    doc: use featureCounts output style
    inputBinding:
      position: 101
      prefix: -F
  - id: first_column_name
    type:
      - 'null'
      - string
    doc: provide the first column name in the output file
    default: Gene
    inputBinding:
      position: 101
      prefix: -G
  - id: format
    type:
      - 'null'
      - string
    doc: 'format of the read files (default: guess from file extension)'
    inputBinding:
      position: 101
      prefix: -f
  - id: merge_threshold
    type:
      - 'null'
      - float
    doc: merge threshold
    default: 0.0
    inputBinding:
      position: 101
      prefix: -m
  - id: output_file
    type:
      - 'null'
      - string
    doc: output file
    default: stdout
    inputBinding:
      position: 101
      prefix: -o
  - id: overlap_type
    type:
      - 'null'
      - int
    doc: 'overlap type (<0: read is included, <1: % overlap, otherwise: # nt, default:
      -1)'
    default: -1
    inputBinding:
      position: 101
      prefix: -l
  - id: overlapping_bp_between_best_and_other_matches
    type:
      - 'null'
      - int
    doc: number of overlapping bp between the best matches and the other matches
    default: 30
    inputBinding:
      position: 101
      prefix: -d
  - id: print_gene_name
    type:
      - 'null'
      - boolean
    doc: print gene name instead of gene ID in the output file
    inputBinding:
      position: 101
      prefix: -g
  - id: print_progress
    type:
      - 'null'
      - boolean
    doc: print progress
    inputBinding:
      position: 101
      prefix: -p
  - id: ratio_overlapping_bp_between_best_and_other_matches
    type:
      - 'null'
      - float
    doc: ratio of overlapping bp between the best matches and the other matches
    default: 2.0
    inputBinding:
      position: 101
      prefix: -D
  - id: read_names
    type:
      - 'null'
      - type: array
        items: string
    doc: short name for each of the reads files
    inputBinding:
      position: 101
      prefix: -n
  - id: reads_files
    type:
      type: array
      items: File
    doc: reads in BAM/SAM format
    inputBinding:
      position: 101
      prefix: -r
  - id: sorted
    type:
      - 'null'
      - string
    doc: 'string (Y if reads are position-sorted, N otherwise, defaut: Y) (use several
      times if reads are not consistently (un)sorted)'
    default: Y
    inputBinding:
      position: 101
      prefix: -e
  - id: statistics_file
    type:
      - 'null'
      - File
    doc: print statistics to a file instead of stderr
    inputBinding:
      position: 101
      prefix: -O
  - id: strand
    type:
      - 'null'
      - string
    doc: 'string (U, F, R, FR, RF, FF, defaut: U) (use several strand types if the
      library strategies differ)'
    default: U
    inputBinding:
      position: 101
      prefix: -s
  - id: threads
    type:
      - 'null'
      - int
    doc: '# threads'
    default: 1
    inputBinding:
      position: 101
      prefix: -t
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mmquant:1.0.9--hdcf5f25_0
stdout: mmquant.out
