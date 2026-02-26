cwlVersion: v1.2
class: CommandLineTool
baseCommand: ncfp
label: ncfp
doc: "ncfp\n\nTool homepage: http://widdowquinn.github.io/ncfp/"
inputs:
  - id: infname
    type: string
    doc: input sequence file
    inputBinding:
      position: 1
  - id: outdirname
    type: Directory
    doc: output directory for sequence files
    inputBinding:
      position: 2
  - id: email
    type: string
    doc: email address for NCBI/Entrez
    inputBinding:
      position: 3
  - id: batchsize
    type:
      - 'null'
      - int
    doc: batch size for EPost submissions
    default: 100
    inputBinding:
      position: 104
      prefix: --batchsize
  - id: cachedir
    type:
      - 'null'
      - Directory
    doc: directory for cached data
    default: .ncfp_cache
    inputBinding:
      position: 104
      prefix: --cachedir
  - id: cachestem
    type:
      - 'null'
      - string
    doc: suffix for cache filestems
    default: 2026-02-26-17-02-43
    inputBinding:
      position: 104
      prefix: --cachestem
  - id: debug
    type:
      - 'null'
      - boolean
    doc: report debug-level information
    default: false
    inputBinding:
      position: 104
      prefix: --debug
  - id: disabletqdm
    type:
      - 'null'
      - boolean
    doc: disable progress bar (for testing)
    default: false
    inputBinding:
      position: 104
      prefix: --disabletqdm
  - id: filestem
    type:
      - 'null'
      - string
    doc: stem for output sequence files
    default: ncfp
    inputBinding:
      position: 104
      prefix: --filestem
  - id: keepcache
    type:
      - 'null'
      - boolean
    doc: keep download cache (for testing)
    default: false
    inputBinding:
      position: 104
      prefix: --keepcache
  - id: limit
    type:
      - 'null'
      - int
    doc: maximum number of sequences to process (for testing)
    default: None
    inputBinding:
      position: 104
      prefix: --limit
  - id: logfile
    type:
      - 'null'
      - File
    doc: path to logfile
    default: None
    inputBinding:
      position: 104
      prefix: --logfile
  - id: retries
    type:
      - 'null'
      - int
    doc: maximum number of Entrez retries
    default: 10
    inputBinding:
      position: 104
      prefix: --retries
  - id: skippedfile
    type:
      - 'null'
      - File
    doc: path to file with skipped sequences
    default: skipped.fasta
    inputBinding:
      position: 104
      prefix: --skippedfile
  - id: stockholm
    type:
      - 'null'
      - boolean
    doc: parse Stockholm format sequence regions
    default: false
    inputBinding:
      position: 104
      prefix: --stockholm
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: report verbosely
    default: false
    inputBinding:
      position: 104
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ncfp:0.2.0--py_0
stdout: ncfp.out
