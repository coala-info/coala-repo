cwlVersion: v1.2
class: CommandLineTool
baseCommand: pfsearchV3
label: pftools_pfsearchV3
doc: "Scan a protein sequence library for profile matches\n\nTool homepage: https://web.expasy.org/pftools/"
inputs:
  - id: profile_regex_pattern
    type: string
    doc: profile|regex{...}|pattern{...}
    inputBinding:
      position: 1
  - id: database
    type: File
    doc: database
    inputBinding:
      position: 2
  - id: both
    type:
      - 'null'
      - boolean
    doc: compute both forward and reverse complemented
    inputBinding:
      position: 103
      prefix: --both
  - id: complement
    type:
      - 'null'
      - boolean
    doc: does a complementary sequence alignment. note that --reverse is NOT 
      automatic
    inputBinding:
      position: 103
      prefix: --complement
  - id: database_index
    type:
      - 'null'
      - File
    doc: use indices stored in given file (optional)
    inputBinding:
      position: 103
      prefix: --database-index
  - id: dump_alignment_sequences
    type:
      - 'null'
      - boolean
    doc: dump passed heuristic and filter sequences
    inputBinding:
      position: 103
      prefix: --dump-alignment-sequences
  - id: dump_filter_scores
    type:
      - 'null'
      - boolean
    doc: only print filter scores to stdout
    inputBinding:
      position: 103
      prefix: --dump-filter-scores
  - id: dump_filter_sequences
    type:
      - 'null'
      - boolean
    doc: dump passed heuristic sequences
    inputBinding:
      position: 103
      prefix: --dump-filter-sequences
  - id: dump_heuristic_scores
    type:
      - 'null'
      - boolean
    doc: only print heuristic scores to stdout
    inputBinding:
      position: 103
      prefix: --dump-heuristic-scores
  - id: fasta
    type:
      - 'null'
      - boolean
    doc: FASTA file database as input
    inputBinding:
      position: 103
      prefix: --fasta
  - id: fastq
    type:
      - 'null'
      - boolean
    doc: FASTQ file database as input
    inputBinding:
      position: 103
      prefix: --fastq
  - id: filter_cutoff
    type:
      - 'null'
      - int
    doc: filter raw cutoff value
    inputBinding:
      position: 103
      prefix: --filter-cutoff
  - id: filter_normalized_cutoff
    type:
      - 'null'
      - float
    doc: filter normalized cutoff value
    inputBinding:
      position: 103
      prefix: --filter-normalized-cutoff
  - id: header_only
    type:
      - 'null'
      - boolean
    doc: search in headers only
    inputBinding:
      position: 103
      prefix: --header-only
  - id: heuristic_cutoff
    type:
      - 'null'
      - string
    doc: heuristic cutoff value
    inputBinding:
      position: 103
      prefix: --heuristic-cutoff
  - id: level
    type:
      - 'null'
      - int
    doc: level to use for cutoff
    default: 0
    inputBinding:
      position: 103
      prefix: --level
  - id: max_heuristic_nthreads
    type:
      - 'null'
      - string
    doc: max number of threads to use for heuristic phase only. (IO bounds), 
      default to all available cores
    inputBinding:
      position: 103
      prefix: --max-heuristic-nthreads
  - id: max_regex_match
    type:
      - 'null'
      - string
    doc: maximum number of returned matches per sequence
    inputBinding:
      position: 103
      prefix: --max-regex-match
  - id: mode
    type:
      - 'null'
      - int
    doc: mode to use for normalization
    default: 1
    inputBinding:
      position: 103
      prefix: --mode
  - id: no_heuristic
    type:
      - 'null'
      - boolean
    doc: bypass heuristic
    inputBinding:
      position: 103
      prefix: --no-heuristic
  - id: nthreads
    type:
      - 'null'
      - string
    doc: max number of threads to use, default to all available cores
    inputBinding:
      position: 103
      prefix: --nthreads
  - id: optimal
    type:
      - 'null'
      - boolean
    doc: report optimal alignment for all sequences
    inputBinding:
      position: 103
      prefix: --optimal
  - id: output_length
    type:
      - 'null'
      - string
    doc: maximum number of column for sequence output printing
    default: 60
    inputBinding:
      position: 103
      prefix: --output-length
  - id: output_method
    type:
      - 'null'
      - string
    doc: printing output method
    default: 0
    inputBinding:
      position: 103
      prefix: --output-method
  - id: reverse_profile
    type:
      - 'null'
      - boolean
    doc: reverse the profile
    inputBinding:
      position: 103
      prefix: --reverse-profile
  - id: reverse_sequence
    type:
      - 'null'
      - boolean
    doc: read sequence backward
    inputBinding:
      position: 103
      prefix: --reverse-sequence
  - id: satisfy_cutoff
    type:
      - 'null'
      - boolean
    doc: but satisfying cutoff
    inputBinding:
      position: 103
      prefix: --satisfy-cutoff
  - id: sse2
    type:
      - 'null'
      - boolean
    doc: enforces SSE 2 only instruction set, default to using SSE 4.1
    inputBinding:
      position: 103
      prefix: --sse2
  - id: unknown_symbol
    type:
      - 'null'
      - string
    doc: change unknown symbol to given character
    inputBinding:
      position: 103
      prefix: --unknown-symbol
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: verbose on stderr
    inputBinding:
      position: 103
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pftools:3.2.13--pl5321r44hcf78210_0
stdout: pftools_pfsearchV3.out
