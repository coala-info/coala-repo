cwlVersion: v1.2
class: CommandLineTool
baseCommand: ir
label: ir
doc: "calculate the index of repetitiveness, I_r\n\nTool homepage: http://guanine.evolbio.mpg.de/cgi-bin/ir/ir.cgi.pl"
inputs:
  - id: compare_identical_headers
    type:
      - 'null'
      - boolean
    doc: compare sequences with identical headers when using -s (slow)
    inputBinding:
      position: 101
      prefix: -I
  - id: filter_private_regions_length
    type:
      - 'null'
      - int
    doc: filter private regions of minimum length NUM
    inputBinding:
      position: 101
      prefix: -f
  - id: header_chars
    type:
      - 'null'
      - int
    doc: print NUM characters of header; all if NUM<0
    inputBinding:
      position: 101
      prefix: -n
  - id: max_suffix_tree_depth
    type:
      - 'null'
      - int
    doc: maximum depth of suffix tree
    inputBinding:
      position: 101
      prefix: -D
  - id: print_debug_messages
    type:
      - 'null'
      - boolean
    doc: print debugging messages (use in conjunction with grep)
    inputBinding:
      position: 101
      prefix: -d
  - id: print_program_info
    type:
      - 'null'
      - boolean
    doc: print information about program
    inputBinding:
      position: 101
      prefix: -p
  - id: proportion_random_shustrings
    type:
      - 'null'
      - float
    doc: proportion of random shustrings considered
    default: 1
    inputBinding:
      position: 101
      prefix: -P
  - id: query_file
    type:
      - 'null'
      - File
    doc: read query sequence(s) from FILE
    inputBinding:
      position: 101
      prefix: -i
  - id: random_seed
    type:
      - 'null'
      - int
    doc: NUM is seed of random number generator
    inputBinding:
      position: 101
      prefix: -S
  - id: randomize_sbjct_times
    type:
      - 'null'
      - int
    doc: compute Ae by randomizing sbjct NUM times; NUM=0 for analytical 
      computation (fast)
    inputBinding:
      position: 101
      prefix: -r
  - id: sbjct_file
    type:
      - 'null'
      - File
    doc: 'read sbjct sequence(s) from FILE; default: analyse only query'
    inputBinding:
      position: 101
      prefix: -j
  - id: treat_sequences_separately
    type:
      - 'null'
      - boolean
    doc: treat each sequence (query & sbjct) separately
    inputBinding:
      position: 101
      prefix: -s
  - id: unnormalize_ir
    type:
      - 'null'
      - boolean
    doc: unnormalize Ir
    inputBinding:
      position: 101
      prefix: -u
  - id: window_increment
    type:
      - 'null'
      - int
    doc: increment sliding window by NUM positions
    inputBinding:
      position: 101
      prefix: -c
  - id: window_width
    type:
      - 'null'
      - int
    doc: sliding window of width NUM
    inputBinding:
      position: 101
      prefix: -w
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: write output to FILE
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ir:2.8.0--h7b50bb2_8
