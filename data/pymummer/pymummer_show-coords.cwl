cwlVersion: v1.2
class: CommandLineTool
baseCommand: show-coords
label: pymummer_show-coords
doc: "Output is to stdout, and consists of a list of coordinates, percent identity,
  and other useful information regarding the alignment data contained in the .delta
  file used as input.\n\nTool homepage: https://github.com/sanger-pathogens/pymummer"
inputs:
  - id: deltafile
    type: File
    doc: Input is the .delta output of either the "nucmer" or the "promer" 
      program passed on the command line.
    inputBinding:
      position: 1
  - id: annotate_maximal_alignments
    type:
      - 'null'
      - boolean
    doc: Annotate maximal alignments between two sequences, i.e. overlaps 
      between reference and query sequences
    inputBinding:
      position: 102
      prefix: -o
  - id: btab_format
    type:
      - 'null'
      - boolean
    doc: Switch output to btab format
    inputBinding:
      position: 102
      prefix: -B
  - id: deprecated_option
    type:
      - 'null'
      - boolean
    doc: Deprecated option. Please use 'delta-filter' instead
    inputBinding:
      position: 102
      prefix: -g
  - id: display_direction
    type:
      - 'null'
      - boolean
    doc: Display the alignment direction in the additional FRM columns (default 
      for promer)
    inputBinding:
      position: 102
      prefix: -d
  - id: include_coverage
    type:
      - 'null'
      - boolean
    doc: Include percent coverage information in the output
    inputBinding:
      position: 102
      prefix: -c
  - id: include_percent_identity
    type:
      - 'null'
      - float
    doc: Set minimum percent identity to display
    inputBinding:
      position: 102
      prefix: -I
  - id: include_sequence_length
    type:
      - 'null'
      - boolean
    doc: Include the sequence length information in the output
    inputBinding:
      position: 102
      prefix: -l
  - id: knockout_overlapping
    type:
      - 'null'
      - boolean
    doc: Knockout (do not display) alignments that overlap another alignment in 
      a different frame by more than 50% of their length, AND have a smaller 
      percent similarity or are less than 75% of the size of the other alignment
      (promer only)
    inputBinding:
      position: 102
      prefix: -k
  - id: merge_overlapping
    type:
      - 'null'
      - boolean
    doc: Merges overlapping alignments regardless of match dir or frame and does
      not display any idenitity information.
    inputBinding:
      position: 102
      prefix: -b
  - id: min_alignment_length
    type:
      - 'null'
      - long
    doc: Set minimum alignment length to display
    inputBinding:
      position: 102
      prefix: -L
  - id: sort_by_query
    type:
      - 'null'
      - boolean
    doc: Sort output lines by query IDs and coordinates
    inputBinding:
      position: 102
      prefix: -q
  - id: sort_by_reference
    type:
      - 'null'
      - boolean
    doc: Sort output lines by reference IDs and coordinates
    inputBinding:
      position: 102
      prefix: -r
  - id: tab_delimited
    type:
      - 'null'
      - boolean
    doc: Switch output to tab-delimited format
    inputBinding:
      position: 102
      prefix: -T
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pymummer:0.12.0--pyhdfd78af_0
stdout: pymummer_show-coords.out
