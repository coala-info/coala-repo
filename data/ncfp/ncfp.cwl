cwlVersion: v1.2
class: CommandLineTool
baseCommand: ncfp
label: ncfp
doc: "ncfp\n\nTool homepage: http://widdowquinn.github.io/ncfp/"
inputs:
  - id: infname
    type: File
    doc: input sequence file
    inputBinding:
      position: 1
  - id: outdirname
    type: string
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
    inputBinding:
      position: 104
      prefix: --batchsize
  - id: cachedir
    type:
      - 'null'
      - string
    doc: directory for cached data
    inputBinding:
      position: 104
      prefix: --cachedir
  - id: cachestem
    type:
      - 'null'
      - string
    doc: suffix for cache filestems
    inputBinding:
      position: 104
      prefix: --cachestem
  - id: debug
    type:
      - 'null'
      - boolean
    doc: report debug-level information
    inputBinding:
      position: 104
      prefix: --debug
  - id: disabletqdm
    type:
      - 'null'
      - boolean
    doc: disable progress bar (for testing)
    inputBinding:
      position: 104
      prefix: --disabletqdm
  - id: filestem
    type:
      - 'null'
      - string
    doc: stem for output sequence files
    inputBinding:
      position: 104
      prefix: --filestem
  - id: keepcache
    type:
      - 'null'
      - boolean
    doc: keep download cache (for testing)
    inputBinding:
      position: 104
      prefix: --keepcache
  - id: limit
    type:
      - 'null'
      - int
    doc: maximum number of sequences to process (for testing)
    inputBinding:
      position: 104
      prefix: --limit
  - id: logfile
    type:
      - 'null'
      - string
    doc: path to logfile
    inputBinding:
      position: 104
      prefix: --logfile
  - id: retries
    type:
      - 'null'
      - int
    doc: maximum number of Entrez retries
    inputBinding:
      position: 104
      prefix: --retries
  - id: skippedfile
    type:
      - 'null'
      - string
    doc: path to file with skipped sequences
    inputBinding:
      position: 104
      prefix: --skippedfile
  - id: stockholm
    type:
      - 'null'
      - boolean
    doc: parse Stockholm format sequence regions
    inputBinding:
      position: 104
      prefix: --stockholm
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: report verbosely
    inputBinding:
      position: 104
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: outdirname_dir
    type:
      - 'null'
      - Directory
    doc: output directory for sequence files
    outputBinding:
      glob: $(inputs.outdirname)
  - id: skipped_out
    type:
      - 'null'
      - File
    doc: file with skipped sequences
    outputBinding:
      glob: $(inputs.skippedfile || 'skipped.fasta')
  - id: log_out
    type:
      - 'null'
      - File
    doc: log file
    outputBinding:
      glob: '$(inputs.logfile ? [inputs.logfile] : [])'
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ncfp:0.2.0--py_0
stdout: ncfp.out
