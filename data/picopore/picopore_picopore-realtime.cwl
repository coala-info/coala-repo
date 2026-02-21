cwlVersion: v1.2
class: CommandLineTool
baseCommand: picopore-realtime
label: picopore_picopore-realtime
doc: "A tool for monitoring a directory for new Oxford Nanopore Technologies reads
  and compressing them in real time without losing data.\n\nTool homepage: https://github.com/scottgigante/picopore"
inputs:
  - id: input
    type:
      - 'null'
      - type: array
        items: File
    doc: list of directories or fast5 files to shrink
    inputBinding:
      position: 1
  - id: fastq
    type:
      - 'null'
      - boolean
    doc: retain FASTQ data (raw mode only)
    default: true
    inputBinding:
      position: 102
      prefix: --no-fastq
  - id: manual
    type:
      - 'null'
      - string
    doc: manually remove only groups whose paths contain STR (raw mode only, regular
      expressions permitted, overrides defaults)
    inputBinding:
      position: 102
      prefix: --manual
  - id: mode
    type: string
    doc: choose compression mode (lossless, deep-lossless, raw)
    inputBinding:
      position: 102
      prefix: --mode
  - id: prefix
    type:
      - 'null'
      - string
    doc: add prefix to output files to prevent overwrite
    inputBinding:
      position: 102
      prefix: --prefix
  - id: print_every
    type:
      - 'null'
      - int
    doc: print a dot every approximately INT files, or -1 to silence
    default: 100
    inputBinding:
      position: 102
      prefix: --print-every
  - id: revert
    type:
      - 'null'
      - boolean
    doc: reverts files to original size (lossless modes only)
    inputBinding:
      position: 102
      prefix: --revert
  - id: skip_confirm
    type:
      - 'null'
      - boolean
    doc: skip confirm step
    inputBinding:
      position: 102
      prefix: -y
  - id: skip_root
    type:
      - 'null'
      - boolean
    doc: ignore files in root input directories for albacore realtime compression
    default: false
    inputBinding:
      position: 102
      prefix: --no-skip-root
  - id: summary
    type:
      - 'null'
      - boolean
    doc: retain summary data (raw mode only)
    default: false
    inputBinding:
      position: 102
      prefix: --no-summary
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads
    default: 1
    inputBinding:
      position: 102
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/picopore:1.2.0--pyh8b68c5b_1
stdout: picopore_picopore-realtime.out
