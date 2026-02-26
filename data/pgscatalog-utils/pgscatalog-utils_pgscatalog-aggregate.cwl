cwlVersion: v1.2
class: CommandLineTool
baseCommand: pgscatalog-aggregate
label: pgscatalog-utils_pgscatalog-aggregate
doc: "Aggregate plink .sscore files into a combined TSV table.\n\nTool homepage: https://github.com/PGScatalog/pygscatalog"
inputs:
  - id: no_split
    type:
      - 'null'
      - boolean
    doc: Make one aggregated file per sampleset
    inputBinding:
      position: 101
      prefix: --no-split
  - id: outdir
    type: Directory
    doc: Output directory to store downloaded files
    inputBinding:
      position: 101
      prefix: --outdir
  - id: scores
    type:
      type: array
      items: File
    doc: List of scorefile paths. Use a wildcard (*) to select multiple files.
    inputBinding:
      position: 101
      prefix: --scores
  - id: split
    type:
      - 'null'
      - boolean
    doc: Make one aggregated file per sampleset
    inputBinding:
      position: 101
      prefix: --split
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Extra logging information
    inputBinding:
      position: 101
      prefix: --verbose
  - id: verify_variants
    type:
      - 'null'
      - boolean
    doc: "Verify variants from scoring file match scored variants perfectly. Note:
      requires .scorefile.gz files used by plink to create the calculated score, and
      a .sscore.vars file output by plink after scoring It's assumed that these files
      have a common file name prefix (this is default plink behaviour) e.g. cineca_22_additive_0.sscore.zst
      needs cineca_22_additive_0.scorefile.gz & cineca_22_additive_0.sscore.vars"
    inputBinding:
      position: 101
      prefix: --verify_variants
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pgscatalog-utils:2.0.2--pyhdfd78af_0
stdout: pgscatalog-utils_pgscatalog-aggregate.out
