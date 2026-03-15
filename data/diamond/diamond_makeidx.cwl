cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - diamond
  - makeidx
label: diamond_makeidx
doc: Create an index for a DIAMOND database
inputs:
  - id: threads
    type:
      - 'null'
      - int
    doc: number of CPU threads
    inputBinding:
      position: 101
      prefix: --threads
  - id: log
    type:
      - 'null'
      - boolean
    doc: enable debug log
    inputBinding:
      position: 101
      prefix: --log
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: disable console output
    inputBinding:
      position: 101
      prefix: --quiet
  - id: tmpdir
    type:
      - 'null'
      - Directory
    doc: directory for temporary files
    inputBinding:
      position: 101
      prefix: --tmpdir
  - id: db
    type: File
    doc: database file
    inputBinding:
      position: 101
      prefix: --db
  - id: faster
    type:
      - 'null'
      - boolean
    doc: enable faster mode
    inputBinding:
      position: 101
      prefix: --faster
  - id: fast
    type:
      - 'null'
      - boolean
    doc: enable fast mode
    inputBinding:
      position: 101
      prefix: --fast
  - id: mid_sensitive
    type:
      - 'null'
      - boolean
    doc: enable mid-sensitive mode
    inputBinding:
      position: 101
      prefix: --mid-sensitive
  - id: linclust_20
    type:
      - 'null'
      - boolean
    doc: enable mode for linear search at 20% identity
    inputBinding:
      position: 101
      prefix: --linclust-20
  - id: shapes_6x10
    type:
      - 'null'
      - boolean
    doc: enable mode using 30 seed shapes of weight 10
    inputBinding:
      position: 101
      prefix: --shapes-6x10
  - id: shapes_30x10
    type:
      - 'null'
      - boolean
    doc: enable mode using 30 seed shapes of weight 10
    inputBinding:
      position: 101
      prefix: --shapes-30x10
  - id: sensitive
    type:
      - 'null'
      - boolean
    doc: enable sensitive mode
    inputBinding:
      position: 101
      prefix: --sensitive
  - id: more_sensitive
    type:
      - 'null'
      - boolean
    doc: enable more sensitive mode
    inputBinding:
      position: 101
      prefix: --more-sensitive
  - id: very_sensitive
    type:
      - 'null'
      - boolean
    doc: enable very sensitive mode
    inputBinding:
      position: 101
      prefix: --very-sensitive
  - id: ultra_sensitive
    type:
      - 'null'
      - boolean
    doc: enable ultra sensitive mode
    inputBinding:
      position: 101
      prefix: --ultra-sensitive
  - id: shapes
    type:
      - 'null'
      - int
    doc: number of seed shapes (default=all available)
    inputBinding:
      position: 101
      prefix: --shapes
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/diamond:2.1.24--hf93d47f_0
stdout: diamond_makeidx.out
s:url: https://github.com/bbuchfink/diamond
$namespaces:
  s: https://schema.org/
