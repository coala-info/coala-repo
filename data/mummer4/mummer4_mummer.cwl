cwlVersion: v1.2
class: CommandLineTool
baseCommand: mummer
label: mummer4_mummer
doc: "Find and output (to stdout) the positions and length of all sufficiently long maximal matches of a substring in the query files and the reference file (MUMmer v3 options).\n\nTool homepage: https://mummer4.github.io/"
inputs:
  - id: mum
    type:
      - 'null'
      - boolean
    doc: Compute maximal matches that are unique in both sequences
    inputBinding:
      position: 10
      prefix: -mum
  - id: mumreference
    type:
      - 'null'
      - boolean
    doc: Compute maximal matches that are unique in the reference sequence but not necessarily in the query sequence (default)
    inputBinding:
      position: 10
      prefix: -mumreference
  - id: mumcand
    type:
      - 'null'
      - boolean
    doc: Same as -mumreference
    inputBinding:
      position: 10
      prefix: -mumcand
  - id: maxmatch
    type:
      - 'null'
      - boolean
    doc: Compute all maximal matches regardless of their uniqueness
    inputBinding:
      position: 10
      prefix: -maxmatch
  - id: min_match_length
    type:
      - 'null'
      - int
    doc: Minimum length of a match (default 20)
    inputBinding:
      position: 10
      prefix: -l
  - id: both_strands
    type:
      - 'null'
      - boolean
    doc: Compute forward and reverse complement matches
    inputBinding:
      position: 10
      prefix: -b
  - id: force_4_column
    type:
      - 'null'
      - boolean
    doc: Force 4 column output format regardless of the number of reference sequence inputs
    inputBinding:
      position: 10
      prefix: -F
  - id: match_acgt_only
    type:
      - 'null'
      - boolean
    doc: "Match only the characters a, c, g or t"
    inputBinding:
      position: 10
      prefix: -n
  - id: query_length_in_header
    type:
      - 'null'
      - boolean
    doc: Print the length of the query sequence in the header of matches
    inputBinding:
      position: 10
      prefix: -L
  - id: reverse_only
    type:
      - 'null'
      - boolean
    doc: Compute only reverse complement matches
    inputBinding:
      position: 10
      prefix: -r
  - id: show_substring
    type:
      - 'null'
      - boolean
    doc: Print the first 53 characters of the matching substring
    inputBinding:
      position: 10
      prefix: -s
  - id: forward_query_position
    type:
      - 'null'
      - boolean
    doc: Report the query position of a reverse complement match relative to the forward strand of the query sequence
    inputBinding:
      position: 10
      prefix: -c
  - id: sampled_suffix
    type:
      - 'null'
      - int
    doc: Sampled suffix positions (one by default)
    inputBinding:
      position: 10
      prefix: -k
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of threads to use for -maxmatch, only valid with k > 1"
    inputBinding:
      position: 10
      prefix: -threads
  - id: qthreads
    type:
      - 'null'
      - int
    doc: Number of threads to use for queries
    inputBinding:
      position: 10
      prefix: -qthreads
  - id: suflink
    type:
      - 'null'
      - int
    doc: "Use suffix links in the index and during search (1=yes, 0=no; default auto)"
    inputBinding:
      position: 10
      prefix: -suflink
  - id: child
    type:
      - 'null'
      - int
    doc: "Use the child table in the index and during search (1=yes, 0=no; default auto)"
    inputBinding:
      position: 10
      prefix: -child
  - id: skip
    type:
      - 'null'
      - int
    doc: "Sparsify the MEM-finding algorithm, performing jumps of skip*k (default auto)"
    inputBinding:
      position: 10
      prefix: -skip
  - id: kmer
    type:
      - 'null'
      - int
    doc: Use a kmer table of suffix array intervals in the index (speeds up searching the first k characters)
    inputBinding:
      position: 10
      prefix: -kmer
  - id: save
    type:
      - 'null'
      - string
    doc: Save the index to this file name to use it again later
    inputBinding:
      position: 10
      prefix: -save
  - id: load
    type:
      - 'null'
      - string
    doc: Load the index from this file
    inputBinding:
      position: 10
      prefix: -load
  - id: reference_file
    type: File
    doc: Reference file (FASTA)
    inputBinding:
      position: 201
  - id: query_files
    type:
      type: array
      items: File
    doc: "Query files (FASTA), up to 32"
    inputBinding:
      position: 202
outputs:
  - id: matches
    type: stdout
    doc: Maximal matches (standard output)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mummer4:4.0.1--pl5321h9948957_0
stdout: mummer4_mummer.out
