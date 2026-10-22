cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - svdb
  - --query
label: svdb_query
doc: "Query structural variant databases with a VCF file and annotate the variants
  with database frequencies (stdout is the annotated VCF unless --prefix is given)\n\nTool
  homepage: https://github.com/J35P312/SVDB"
inputs:
  - id: query_vcf
    type: File
    doc: A vcf used to query the db.
    inputBinding:
      position: 101
      prefix: --query_vcf
  - id: db
    type:
      - 'null'
      - File
    doc: Path to a SVDB db vcf (or a comma separated list of vcfs).
    inputBinding:
      position: 101
      prefix: --db
  - id: sqdb
    type:
      - 'null'
      - File
    doc: Path to a SVDB sqlite db (or a comma separated list of dbs).
    inputBinding:
      position: 101
      prefix: --sqdb
  - id: bedpedb
    type:
      - 'null'
      - File
    doc: Path to a SV database of the following format
      chrA-posA-chrB-posB-type-count-frequency (or a comma separated list of
      dbs).
    inputBinding:
      position: 101
      prefix: --bedpedb
  - id: in_occ
    type:
      - 'null'
      - string
    doc: The allele count tag, if used, this tag must be present in the INFO
      column of the input DB (usually set to AC or OCC), required if multiple
      databases are queried.
    inputBinding:
      position: 101
      prefix: --in_occ
  - id: in_frq
    type:
      - 'null'
      - string
    doc: The frequency count tag, if used, this tag must be present in the INFO
      column of the input DB (usually set to AF or FRQ), required if multiple
      databases are queried.
    inputBinding:
      position: 101
      prefix: --in_frq
  - id: out_occ
    type:
      - 'null'
      - string
    doc: The allele count tag, as annotated by SVDBvariant (default=OCC),
      required if multiple databases are queried.
    inputBinding:
      position: 101
      prefix: --out_occ
  - id: out_frq
    type:
      - 'null'
      - string
    doc: The tag used to describe the frequency of the variant (default=FRQ),
      required if multiple databases are queried.
    inputBinding:
      position: 101
      prefix: --out_frq
  - id: max_frq
    type:
      - 'null'
      - float
    doc: Only include variants with a higher frequency than given here between 0
      and 1. All new variants are always included (default 1).
    inputBinding:
      position: 101
      prefix: --max_frq
  - id: prefix
    type:
      - 'null'
      - string
    doc: The prefix of the output file, default = print to stdout. Required, if
      multiple databases are queried.
    inputBinding:
      position: 101
      prefix: --prefix
  - id: bnd_distance
    type:
      - 'null'
      - int
    doc: The maximum distance between two similar breakpoints (default =
      10000).
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
      merged), default = 0.6.
    inputBinding:
      position: 101
      prefix: --overlap
  - id: memory
    type:
      - 'null'
      - boolean
    doc: Load the database into memory, increases the memory requirements, but
      lowers the time consumption (may only be used with sqdb).
    inputBinding:
      position: 101
      prefix: --memory
  - id: no_var
    type:
      - 'null'
      - boolean
    doc: Count overlaping variants of different type as hits in the db.
    inputBinding:
      position: 101
      prefix: --no_var
outputs:
  - id: annotated_vcf
    type: stdout
    doc: Annotated VCF written to standard output (empty when --prefix is used).
  - id: prefixed_output
    type:
      - 'null'
      - type: array
        items: File
    doc: Output files written when --prefix is given.
    outputBinding:
      glob: '$(inputs.prefix ? inputs.prefix + "*" : "__none__")'
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/svdb:2.8.4--py311h7c5c6c8_0
stdout: svdb_query.vcf
