cwlVersion: v1.2
class: CommandLineTool
baseCommand: picopore-rename
label: picopore_picopore-rename
doc: "A tool for renaming groups and datasets within Oxford Nanopore Technologies
  FAST5 files\n\nTool homepage: https://github.com/scottgigante/picopore"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.input)
        writable: true
inputs:
  - id: input
    type:
      type: array
      items: File
    doc: list of directories or fast5 files to shrink
    inputBinding:
      position: 1
      valueFrom: $(self.map(function(f) { return f.basename; }))
  - id: pattern
    type: string
    doc: String or regex to replace
    inputBinding:
      position: 102
      prefix: --pattern
  - id: replacement
    type: string
    doc: String or regex replacement for PATTERN
    inputBinding:
      position: 102
      prefix: --replacement
  - id: skip_confirm
    type:
      - 'null'
      - boolean
    doc: skip confirm step
    inputBinding:
      position: 102
      prefix: -y
  - id: threads
    type:
      - 'null'
      - int
    doc: 'number of threads (Default: 1)'
    inputBinding:
      position: 102
      prefix: --threads
  - id: prefix
    type:
      - 'null'
      - string
    doc: add prefix to output files to prevent overwrite
    inputBinding:
      position: 102
      prefix: --prefix
  - id: skip_root
    type:
      - 'null'
      - boolean
    doc: ignore files in root input directories for albacore realtime compression
    inputBinding:
      position: 102
      prefix: --skip-root
  - id: no_skip_root
    type:
      - 'null'
      - boolean
    doc: 'do not ignore files in root input directories (Default: --no-skip-root)'
    inputBinding:
      position: 102
      prefix: --no-skip-root
  - id: print_every
    type:
      - 'null'
      - int
    doc: print a dot every approximately INT files, or -1 to silence (Default 100)
    inputBinding:
      position: 102
      prefix: --print-every
outputs:
  - id: fast5_files
    type:
      type: array
      items: File
    outputBinding:
      glob: '*.fast5'
  - id: stdout
    type: stdout
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/picopore:1.2.0--pyh8b68c5b_1
stdout: picopore_picopore-rename.out
