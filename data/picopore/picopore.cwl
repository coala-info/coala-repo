cwlVersion: v1.2
class: CommandLineTool
baseCommand: picopore
label: picopore
doc: "A tool for reducing the size of an Oxford Nanopore Technologies dataset without
  losing any data\n\nTool homepage: https://github.com/scottgigante/picopore"
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
    inputBinding:
      position: 102
      prefix: --fastq
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
    inputBinding:
      position: 102
      prefix: --skip-root
  - id: summary
    type:
      - 'null'
      - boolean
    doc: retain summary data (raw mode only)
    inputBinding:
      position: 102
      prefix: --summary
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads
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
stdout: picopore.out
