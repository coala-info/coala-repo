cwlVersion: v1.2
class: CommandLineTool
baseCommand: mumemto
label: mumemto
doc: "find maximal [unique | exact] matches using PFP.\n\nTool homepage: https://github.com/vikshiv/mumemto"
inputs:
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: List of input FASTA files
    inputBinding:
      position: 1
  - id: arrays_in_prefix
    type:
      - 'null'
      - string
    doc: Compute matches from precomputed LCP, BWT, SA (with shared 
      PREFIX.bwt/sa/lcp)
    inputBinding:
      position: 102
      prefix: --arrays-in
  - id: arrays_out
    type:
      - 'null'
      - boolean
    doc: Write LCP, BWT, and SA to file
    inputBinding:
      position: 102
      prefix: --arrays-out
  - id: binary_output
    type:
      - 'null'
      - boolean
    doc: Output binary format (multi-MUMs only)
    inputBinding:
      position: 102
      prefix: --binary
  - id: hash_modulus
    type:
      - 'null'
      - int
    doc: Hash modulus used for pfp
    inputBinding:
      position: 102
      prefix: --modulus
  - id: include_reverse_complement
    type:
      - 'null'
      - boolean
    doc: Include the reverse complement of the sequences
    inputBinding:
      position: 102
      prefix: --no-revcomp
  - id: input_file_list
    type:
      - 'null'
      - File
    doc: Path to a file-list of genomes to use (overrides positional args)
    inputBinding:
      position: 102
      prefix: --input
  - id: keep_temp_files
    type:
      - 'null'
      - boolean
    doc: Keep PFP files
    inputBinding:
      position: 102
      prefix: --keep-temp-files
  - id: max_total_freq
    type:
      - 'null'
      - int
    doc: Maximum number of total occurrences of match (if negative, then 
      relative to N)
    inputBinding:
      position: 102
      prefix: --max-total-freq
  - id: merge_metadata
    type:
      - 'null'
      - boolean
    doc: Output extra metadata to enable merging multi-MUMs
    inputBinding:
      position: 102
      prefix: --merge
  - id: min_match_len
    type:
      - 'null'
      - int
    doc: Minimum MUM or MEM length
    inputBinding:
      position: 102
      prefix: --min-match-len
  - id: minimum_genomes
    type:
      - 'null'
      - int
    doc: Find matches in at least k sequences (k < 0 sets the sequences relative
      to N, i.e. matches must occur in at least N - |k| sequences)
    inputBinding:
      position: 102
      prefix: --minimum-genomes
  - id: only_parse
    type:
      - 'null'
      - boolean
    doc: Only compute PFP over the input files and do not compute matches
    inputBinding:
      position: 102
      prefix: --only-parse
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: Output prefix path
    inputBinding:
      position: 102
      prefix: --output
  - id: per_seq_freq
    type:
      - 'null'
      - int
    doc: Maximum number of occurrences per sequence (set to 0 for no upper 
      limit)
    inputBinding:
      position: 102
      prefix: --per-seq-freq
  - id: use_anchor_merging
    type:
      - 'null'
      - boolean
    doc: Use anchor-based merging (requires -M, uses first sequence as anchor)
    inputBinding:
      position: 102
      prefix: --anchor
  - id: use_gsacak
    type:
      - 'null'
      - boolean
    doc: Skip PFP and use gsacak directly to compute LCP, BWT, SA
    inputBinding:
      position: 102
      prefix: --use-gsacak
  - id: use_precomputed_parse
    type:
      - 'null'
      - boolean
    doc: Use pre-computed pf-parse (with shared PREFIX.parse and PREFIX.dict)
    inputBinding:
      position: 102
      prefix: --from-parse
  - id: window_size
    type:
      - 'null'
      - int
    doc: Window size used for pfp
    inputBinding:
      position: 102
      prefix: --window
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mumemto:1.3.4--py310h275bdba_0
stdout: mumemto.out
