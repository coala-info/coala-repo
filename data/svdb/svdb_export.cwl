cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - svdb
  - --export
label: svdb_export
doc: "Export the variants of an SVDB sqlite database into a VCF file\n\nTool homepage:
  https://github.com/J35P312/SVDB"
inputs:
  - id: db
    type: File
    doc: The SQLite database.
    inputBinding:
      position: 101
      prefix: --db
  - id: no_merge
    type:
      - 'null'
      - boolean
    doc: Skip the merging of variants, print all variants in the db to a vcf
      file.
    inputBinding:
      position: 101
      prefix: --no_merge
  - id: bnd_distance
    type:
      - 'null'
      - int
    doc: The maximum distance between two similar precise breakpoints (default =
      2500).
    inputBinding:
      position: 101
      prefix: --bnd_distance
  - id: ins_distance
    type:
      - 'null'
      - int
    doc: The maximum distance to merge two insertions (default = 50).
    inputBinding:
      position: 101
      prefix: --ins_distance
  - id: overlap
    type:
      - 'null'
      - float
    doc: The overlap required to merge two events (0 means anything that
      touches will be merged, 1 means that two events must be identical to be
      merged), default = 0.8.
    inputBinding:
      position: 101
      prefix: --overlap
  - id: dbscan
    type:
      - 'null'
      - boolean
    doc: Use dbscan to cluster the variants.
    inputBinding:
      position: 101
      prefix: --DBSCAN
  - id: epsilon
    type:
      - 'null'
      - int
    doc: Used together with --DBSCAN; sets the epsilon parameter (default =
      500).
    inputBinding:
      position: 101
      prefix: --epsilon
  - id: min_pts
    type:
      - 'null'
      - int
    doc: Used together with --DBSCAN; sets the min_pts parameter (default = 2).
    inputBinding:
      position: 101
      prefix: --min_pts
  - id: prefix
    type:
      - 'null'
      - string
    doc: The prefix of the output file, default = same as input.
    inputBinding:
      position: 101
      prefix: --prefix
  - id: memory
    type:
      - 'null'
      - boolean
    doc: Load the database into memory, increases the memory requirements, but
      lowers the time consumption.
    inputBinding:
      position: 101
      prefix: --memory
outputs:
  - id: exported_vcf
    type:
      type: array
      items: File
    doc: The exported VCF file.
    outputBinding:
      glob: '*.vcf'
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/svdb:2.8.4--py311h7c5c6c8_0
stdout: svdb_export.out
