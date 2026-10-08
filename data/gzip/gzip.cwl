cwlVersion: v1.2
class: CommandLineTool
baseCommand: gzip
label: gzip
doc: Compress or uncompress FILEs (by default, compress FILES in-place).
inputs:
  - id: files
    type:
      - 'null'
      - type: array
        items: File
    doc: Files to compress or uncompress
    inputBinding:
      position: 1
      valueFrom: "$(self ? self.map(function(f) { return f.basename; }) : [])"
  - id: stdout
    type:
      - 'null'
      - boolean
    doc: write on standard output, keep original files unchanged
    inputBinding:
      position: 102
      prefix: --stdout
  - id: decompress
    type:
      - 'null'
      - boolean
    doc: decompress
    inputBinding:
      position: 102
      prefix: --decompress
  - id: force
    type:
      - 'null'
      - boolean
    doc: force overwrite of output file and compress links
    inputBinding:
      position: 102
      prefix: --force
  - id: keep
    type:
      - 'null'
      - boolean
    doc: keep (don't delete) input files
    inputBinding:
      position: 102
      prefix: --keep
  - id: list
    type:
      - 'null'
      - boolean
    doc: list compressed file contents
    inputBinding:
      position: 102
      prefix: --list
  - id: license
    type:
      - 'null'
      - boolean
    doc: display software license
    inputBinding:
      position: 102
      prefix: --license
  - id: no_name
    type:
      - 'null'
      - boolean
    doc: do not save or restore the original name and timestamp
    inputBinding:
      position: 102
      prefix: --no-name
  - id: name
    type:
      - 'null'
      - boolean
    doc: save or restore the original name and timestamp
    inputBinding:
      position: 102
      prefix: --name
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: suppress all warnings
    inputBinding:
      position: 102
      prefix: --quiet
  - id: recursive
    type:
      - 'null'
      - boolean
    doc: operate recursively on directories
    inputBinding:
      position: 102
      prefix: --recursive
  - id: rsyncable
    type:
      - 'null'
      - boolean
    doc: make rsync-friendly archive
    inputBinding:
      position: 102
      prefix: --rsyncable
  - id: suffix
    type:
      - 'null'
      - string
    doc: use suffix SUF on compressed files
    inputBinding:
      position: 102
      prefix: --suffix
  - id: synchronous
    type:
      - 'null'
      - boolean
    doc: synchronous output (safer if system crashes, but slower)
    inputBinding:
      position: 102
      prefix: --synchronous
  - id: test
    type:
      - 'null'
      - boolean
    doc: test compressed file integrity
    inputBinding:
      position: 102
      prefix: --test
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: verbose mode
    inputBinding:
      position: 102
      prefix: --verbose
  - id: fast
    type:
      - 'null'
      - boolean
    doc: compress faster
    inputBinding:
      position: 102
      prefix: --fast
  - id: best
    type:
      - 'null'
      - boolean
    doc: compress better
    inputBinding:
      position: 102
      prefix: --best
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: compressed_files
    type:
      type: array
      items: File
    doc: Files compressed in place (name.gz)
    outputBinding:
      glob: '*.gz'
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.files)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gzip:1.11
stdout: gzip.out
s:url: https://github.com/travist/jsencrypt
$namespaces:
  s: https://schema.org/
