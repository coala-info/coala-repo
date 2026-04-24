cwlVersion: v1.2
class: CommandLineTool
baseCommand: ipcr
label: ipcr
doc: "in-silico PCR toolkit\n\nTool homepage: https://github.com/KPU-AGC/ipcr"
inputs:
  - id: chunk_size
    type:
      - 'null'
      - int
    doc: Split sequences into N-bp windows (0=no chunking)
    inputBinding:
      position: 101
      prefix: --chunk-size
  - id: circular
    type:
      - 'null'
      - boolean
    doc: Treat each FASTA record as circular
    inputBinding:
      position: 101
      prefix: --circular
  - id: emit_products
    type:
      - 'null'
      - boolean
    doc: Emit product sequences
    inputBinding:
      position: 101
      prefix: --products
  - id: examples
    type:
      - 'null'
      - boolean
    doc: Show quickstart examples and exit
    inputBinding:
      position: 101
      prefix: --examples
  - id: forward_primer
    type: string
    doc: Forward primer sequence (5'→3')
    inputBinding:
      position: 101
      prefix: --forward
  - id: hit_cap
    type:
      - 'null'
      - int
    doc: Max matches stored per primer/window (0=unlimited)
    inputBinding:
      position: 101
      prefix: --hit-cap
  - id: max_length
    type:
      - 'null'
      - int
    doc: Maximum product length
    inputBinding:
      position: 101
      prefix: --max-length
  - id: min_length
    type:
      - 'null'
      - int
    doc: Minimum product length
    inputBinding:
      position: 101
      prefix: --min-length
  - id: mismatches
    type:
      - 'null'
      - int
    doc: Max mismatches allowed per primer
    inputBinding:
      position: 101
      prefix: --mismatches
  - id: no_header
    type:
      - 'null'
      - boolean
    doc: Suppress header line
    inputBinding:
      position: 101
      prefix: --no-header
  - id: no_match_exit_code
    type:
      - 'null'
      - int
    doc: Exit code when no amplicons found
    inputBinding:
      position: 101
      prefix: --no-match-exit-code
  - id: output_format
    type:
      - 'null'
      - string
    doc: 'Output: text | json | jsonl | fasta'
    inputBinding:
      position: 101
      prefix: --output
  - id: pretty_alignment
    type:
      - 'null'
      - boolean
    doc: Pretty ASCII alignment block (text)
    inputBinding:
      position: 101
      prefix: --pretty
  - id: primers_file
    type:
      - 'null'
      - string
    doc: Primer TSV (id fwd rev [min] [max])
    inputBinding:
      position: 101
      prefix: --primers
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Suppress non-essential warnings
    inputBinding:
      position: 101
      prefix: --quiet
  - id: reverse_primer
    type: string
    doc: Reverse primer sequence (5'→3')
    inputBinding:
      position: 101
      prefix: --reverse
  - id: seed_length
    type:
      - 'null'
      - int
    doc: Seed length for multi-pattern scan (0=auto)
    inputBinding:
      position: 101
      prefix: --seed-length
  - id: self
    type:
      - 'null'
      - boolean
    doc: Allow single-oligo amplification (A×rc(A), B×rc(B))
    inputBinding:
      position: 101
      prefix: --self
  - id: sequences
    type:
      - 'null'
      - type: array
        items: File
    doc: FASTA file(s) (repeatable) or '-' for STDIN
    inputBinding:
      position: 101
      prefix: --sequences
  - id: sort_output
    type:
      - 'null'
      - boolean
    doc: Sort outputs deterministically
    inputBinding:
      position: 101
      prefix: --sort
  - id: terminal_window
    type:
      - 'null'
      - int
    doc: 3' terminal window (N<1 disables)
    inputBinding:
      position: 101
      prefix: --terminal-window
  - id: threads
    type:
      - 'null'
      - int
    doc: Worker threads (0=all CPUs)
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ipcr:4.1.1--he881be0_1
stdout: ipcr.out
