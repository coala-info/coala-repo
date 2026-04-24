cwlVersion: v1.2
class: CommandLineTool
baseCommand: pairix
label: pairix
doc: "PAIRs file IndeXer\n\nTool homepage: https://github.com/4dn-dcic/pairix"
inputs:
  - id: input_pairs_file
    type: File
    doc: Input pairs file (must be bgzf compressed)
    inputBinding:
      position: 1
  - id: regions
    type:
      - 'null'
      - type: array
        items: string
    doc: Query region(s)
    inputBinding:
      position: 2
  - id: autoflip_query
    type:
      - 'null'
      - boolean
    doc: autoflip query when the matching chromosome pair doesn't exist
    inputBinding:
      position: 103
      prefix: -a
  - id: check_triangle
    type:
      - 'null'
      - boolean
    doc: Only check if the file is a triangle (i.e. a chromosome pair occurs 
      only in one direction (e.g. if chr1|chr2 exists, chr2|chr1 doesn't))
    inputBinding:
      position: 103
      prefix: -Y
  - id: comment_char
    type:
      - 'null'
      - string
    doc: symbol for comment/meta lines
    inputBinding:
      position: 103
      prefix: -c
  - id: end1_col
    type:
      - 'null'
      - int
    doc: end1 column; can be identical to '-b'
    inputBinding:
      position: 103
      prefix: -e
  - id: end2_col
    type:
      - 'null'
      - int
    doc: end2 column; can be identical to '-u'
    inputBinding:
      position: 103
      prefix: -v
  - id: force_overwrite_index
    type:
      - 'null'
      - boolean
    doc: force to overwrite the index
    inputBinding:
      position: 103
      prefix: -f
  - id: header_only
    type:
      - 'null'
      - boolean
    doc: print only the header lines
    inputBinding:
      position: 103
      prefix: -H
  - id: include_header
    type:
      - 'null'
      - boolean
    doc: print also the header lines
    inputBinding:
      position: 103
      prefix: -h
  - id: list_chromosomes
    type:
      - 'null'
      - boolean
    doc: list chromosome names
    inputBinding:
      position: 103
      prefix: -l
  - id: preset
    type:
      - 'null'
      - string
    doc: 'preset: pairs, merged_nodups, old_merged_nodups, gff, bed, sam, vcf, psltbl'
    inputBinding:
      position: 103
      prefix: -p
  - id: print_bgzf_blocks
    type:
      - 'null'
      - boolean
    doc: print only the number of bgzf blocks for existing chromosome (pairs)
    inputBinding:
      position: 103
      prefix: -B
  - id: print_region_split_char
    type:
      - 'null'
      - boolean
    doc: print only the region split character
    inputBinding:
      position: 103
      prefix: -W
  - id: print_total_line_count
    type:
      - 'null'
      - boolean
    doc: print only the total line count (same as gunzip -c | wc -l but much 
      faster)
    inputBinding:
      position: 103
      prefix: -n
  - id: query_regions_file
    type:
      - 'null'
      - boolean
    doc: query region is not a string but a file listing query regions
    inputBinding:
      position: 103
      prefix: -L
  - id: region_separator
    type:
      - 'null'
      - string
    doc: symbol for query region separator
    inputBinding:
      position: 103
      prefix: -w
  - id: replace_header_file
    type:
      - 'null'
      - File
    doc: replace the header with the content of FILE
    inputBinding:
      position: 103
      prefix: -r
  - id: seq2_name_col
    type:
      - 'null'
      - int
    doc: second sequence name column
    inputBinding:
      position: 103
      prefix: -d
  - id: seq_name_col
    type:
      - 'null'
      - int
    doc: sequence name column
    inputBinding:
      position: 103
      prefix: -s
  - id: skip_lines
    type:
      - 'null'
      - int
    doc: skip first INT lines
    inputBinding:
      position: 103
      prefix: -S
  - id: space_delimiter
    type:
      - 'null'
      - boolean
    doc: delimiter is space instead of tab.
    inputBinding:
      position: 103
      prefix: -T
  - id: start1_col
    type:
      - 'null'
      - int
    doc: start1 column
    inputBinding:
      position: 103
      prefix: -b
  - id: start2_col
    type:
      - 'null'
      - int
    doc: start2 column
    inputBinding:
      position: 103
      prefix: -u
  - id: zero_based_coords
    type:
      - 'null'
      - boolean
    doc: zero-based coordinate
    inputBinding:
      position: 103
      prefix: '-0'
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pairix:0.3.9--py312h4711d71_0
stdout: pairix.out
