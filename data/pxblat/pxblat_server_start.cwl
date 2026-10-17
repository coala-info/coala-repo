cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pxblat
  - server
  - start
label: pxblat_server_start
doc: "To set up a server (runs in the foreground until stopped).\n\nTool homepage: https://pypi.org/project/pxblat/"
inputs:
  - id: host
    type: string
    doc: Host name or address of the server
    inputBinding:
      position: 1
  - id: port
    type: int
    doc: Port of the server
    inputBinding:
      position: 2
  - id: two_bit
    type: File
    doc: Two bit file
    inputBinding:
      position: 3
  - id: tile_size
    type:
      - 'null'
      - int
    doc: Size of n-mers to index. Default is 11 for nucleotides, 4 for proteins (or translated nucleotides).
    inputBinding:
      position: 4
      prefix: --tile-size
  - id: step_size
    type:
      - 'null'
      - int
    doc: Spacing between tiles. Default is tileSize.
    inputBinding:
      position: 4
      prefix: --stepSize
  - id: min_match
    type:
      - 'null'
      - int
    doc: Number of n-mer matches that trigger detailed alignment. Default is 2 for nucleotides, 3 for proteins.
    inputBinding:
      position: 4
      prefix: --min-match
  - id: trans
    type:
      - 'null'
      - boolean
    doc: Translate database to protein in 6 frames.
    inputBinding:
      position: 4
      prefix: --trans
  - id: log
    type:
      - 'null'
      - string
    doc: Keep a log file that records server requests.
    inputBinding:
      position: 4
      prefix: --log
  - id: mask
    type:
      - 'null'
      - boolean
    doc: Use masking from .2bit file.
    inputBinding:
      position: 4
      prefix: --mask
  - id: rep_match
    type:
      - 'null'
      - int
    doc: Number of occurrences of a tile (n-mer) that triggers repeat masking the tile. Default is 1024.
    inputBinding:
      position: 4
      prefix: --repMatch
  - id: no_simp_rep_mask
    type:
      - 'null'
      - boolean
    doc: Suppresses simple repeat masking.
    inputBinding:
      position: 4
      prefix: --noSimpRepMask
  - id: max_dna_hits
    type:
      - 'null'
      - int
    doc: Maximum number of hits for a DNA query that are sent from the server.
    inputBinding:
      position: 4
      prefix: --maxDnaHits
  - id: max_trans_hits
    type:
      - 'null'
      - int
    doc: Maximum number of hits for a translated query that are sent from the server.
    inputBinding:
      position: 4
      prefix: --maxTransHits
  - id: max_nt_size
    type:
      - 'null'
      - int
    doc: Maximum size of untranslated DNA query sequence.
    inputBinding:
      position: 4
      prefix: --maxNtSize
  - id: per_seq_max
    type:
      - 'null'
      - File
    doc: File contains one seq filename (possibly with ':seq' suffix) per line.
    inputBinding:
      position: 4
      prefix: --perSeqMax
  - id: can_stop
    type:
      - 'null'
      - boolean
    doc: If set, a quit message will actually take down the server.
    inputBinding:
      position: 4
      prefix: --canStop
  - id: index_file
    type:
      - 'null'
      - File
    doc: Index file create by `gfServer index'.
    inputBinding:
      position: 4
      prefix: --indexFile
  - id: timeout
    type:
      - 'null'
      - int
    doc: Timeout in seconds.
    inputBinding:
      position: 4
      prefix: --timeout
outputs:
  - id: log_file
    type:
      - 'null'
      - File
    doc: Server request log (written when log is set)
    outputBinding:
      glob: $(inputs.log)
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pxblat:1.2.8--py311h93bbee8_1
