cwlVersion: v1.2
class: CommandLineTool
baseCommand: fxtract
label: fxtract
doc: "Extracts reads from FASTQ files based on patterns.\n\nTool homepage: https://github.com/ctSkennerton/fxtract"
inputs:
  - id: pattern
    type: string
    doc: Pattern to search for
    inputBinding:
      position: 1
  - id: input_files
    type:
      type: array
      items: File
    doc: Input FASTQ files (read1.fx, read2.fx for paired-end, or read12.fx for 
      interleaved)
    inputBinding:
      position: 2
  - id: count_only
    type:
      - 'null'
      - boolean
    doc: Print only the count of reads (or pairs) that were found
    inputBinding:
      position: 103
      prefix: -c
  - id: evaluate_comment_strings
    type:
      - 'null'
      - boolean
    doc: 'Evaluate patters in the context of comment strings - everything after the
      first space on the header line of the record (default: sequences)'
    inputBinding:
      position: 103
      prefix: -C
  - id: evaluate_headers
    type:
      - 'null'
      - boolean
    doc: 'Evaluate patterns in the context of headers (default: sequences)'
    inputBinding:
      position: 103
      prefix: -H
  - id: evaluate_quality_scores
    type:
      - 'null'
      - boolean
    doc: 'Evaluate patterns in the context of quality scores (default: sequences)'
    inputBinding:
      position: 103
      prefix: -Q
  - id: exact_match
    type:
      - 'null'
      - boolean
    doc: 'pattern exactly matches the whole string (default: literal substring)'
    inputBinding:
      position: 103
      prefix: -X
  - id: interleaved_input
    type:
      - 'null'
      - boolean
    doc: The read file is interleaved (both pairs in a single file)
    inputBinding:
      position: 103
      prefix: -I
  - id: invert_match
    type:
      - 'null'
      - boolean
    doc: Inverse the match criteria. Print pairs that do not contain matches
    inputBinding:
      position: 103
      prefix: -v
  - id: match_reverse_complement
    type:
      - 'null'
      - boolean
    doc: Match the reverse complement of a literal pattern. Not compatible with 
      regular expressions
    inputBinding:
      position: 103
      prefix: -r
  - id: non_paired_files
    type:
      - 'null'
      - boolean
    doc: The files do not contain pairs. Allows for multiple files to be given 
      on the command line
    inputBinding:
      position: 103
      prefix: -S
  - id: pattern_file
    type:
      - 'null'
      - File
    doc: File containing patterns, one per line
    inputBinding:
      position: 103
      prefix: -f
  - id: perl_compatible_regexp
    type:
      - 'null'
      - boolean
    doc: 'pattern is a perl compatable regular expression (default: literal substring)'
    inputBinding:
      position: 103
      prefix: -P
  - id: posix_basic_regexp
    type:
      - 'null'
      - boolean
    doc: 'pattern is a posix basic regular expression (default: literal substring)'
    inputBinding:
      position: 103
      prefix: -G
  - id: posix_extended_regexp
    type:
      - 'null'
      - boolean
    doc: 'pattern is a posix extended regular expression (default: literal substring)'
    inputBinding:
      position: 103
      prefix: -E
  - id: print_filenames
    type:
      - 'null'
      - boolean
    doc: Print file names that contain matches
    inputBinding:
      position: 103
      prefix: -l
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fxtract:2.4--hc29b5fc_3
stdout: fxtract.out
