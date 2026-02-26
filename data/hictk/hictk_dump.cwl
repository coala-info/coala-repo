cwlVersion: v1.2
class: CommandLineTool
baseCommand: hictk dump
label: hictk_dump
doc: "Read interactions and other kinds of data from .hic and Cooler files and write
  them to stdout.\n\nTool homepage: https://github.com/paulsengroup/hictk"
inputs:
  - id: uri
    type: File
    doc: Path to a .hic, .cool or .mcool file (Cooler URI syntax supported).
    inputBinding:
      position: 1
  - id: balance
    type:
      - 'null'
      - string
    doc: Balance interactions using the given method.
    default: NONE
    inputBinding:
      position: 102
      prefix: --balance
  - id: cis_only
    type:
      - 'null'
      - boolean
    doc: Dump intra-chromosomal interactions only.
    inputBinding:
      position: 102
      prefix: --cis-only
  - id: join
    type:
      - 'null'
      - boolean
    doc: Output pixels in BG2 format.
    default: false
    inputBinding:
      position: 102
      prefix: --join
  - id: matrix_type
    type:
      - 'null'
      - string
    doc: Matrix type (ignored when file is not in .hic format).
    default: observed
    inputBinding:
      position: 102
      prefix: --matrix-type
  - id: matrix_unit
    type:
      - 'null'
      - string
    doc: Matrix unit (ignored when file is not in .hic format).
    default: BP
    inputBinding:
      position: 102
      prefix: --matrix-unit
  - id: no_join
    type:
      - 'null'
      - boolean
    doc: Output pixels in BG2 format.
    default: false
    inputBinding:
      position: 102
      prefix: --no-join
  - id: query_file
    type:
      - 'null'
      - File
    doc: Path to a BEDPE file with the list of coordinates to be fetched (pass -
      to read queries from stdin).
    inputBinding:
      position: 102
      prefix: --query-file
  - id: range
    type:
      - 'null'
      - string
    doc: Coordinates of the genomic regions to be dumped following UCSC style 
      notation (chr1:0-1000).
    default: all
    inputBinding:
      position: 102
      prefix: --range
  - id: range2
    type:
      - 'null'
      - string
    doc: Coordinates of the genomic regions to be dumped following UCSC style 
      notation (chr1:0-1000).
    default: all
    inputBinding:
      position: 102
      prefix: --range2
  - id: resolution
    type:
      - 'null'
      - int
    doc: HiC matrix resolution (ignored when file is in .cool format).
    inputBinding:
      position: 102
      prefix: --resolution
  - id: sorted
    type:
      - 'null'
      - boolean
    doc: Return interactions in ascending order.
    default: false
    inputBinding:
      position: 102
      prefix: --sorted
  - id: table
    type:
      - 'null'
      - string
    doc: Name of the table to dump.
    default: pixels
    inputBinding:
      position: 102
      prefix: --table
  - id: trans_only
    type:
      - 'null'
      - boolean
    doc: Dump inter-chromosomal interactions only.
    inputBinding:
      position: 102
      prefix: --trans-only
  - id: unsorted
    type:
      - 'null'
      - boolean
    doc: Return interactions in ascending order.
    default: false
    inputBinding:
      position: 102
      prefix: --unsorted
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hictk:2.2.0--h75fee6f_0
stdout: hictk_dump.out
