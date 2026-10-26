cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - varfish-server-worker
  - strucvars
  - aggregate
label: varfish-server-worker_strucvars_aggregate
doc: 'Build inhouse database.


  Tool homepage: https://github.com/varfish-org/varfish-server-worker'
inputs:
  - id: path_input
    type:
      type: array
      items: File
    doc: Input files to cluster, prefix with `@` to file with line-wise paths
    inputBinding:
      position: 200
  - id: genome_release
    type:
      - 'null'
      - string
    doc: 'Genome build to use in the build [default: grch37]'
    inputBinding:
      position: 102
      prefix: --genome-release
  - id: path_output
    type: string
    doc: Path to output TSV file
    inputBinding:
      position: 102
      prefix: --path-output
  - id: min_overlap
    type:
      - 'null'
      - float
    doc: 'Minimal reciprocal overlap to use (slightly more strict that the normal
      query value of 0.75) [default: 0.8]'
    inputBinding:
      position: 102
      prefix: --min-overlap
  - id: slack_bnd
    type:
      - 'null'
      - int
    doc: 'Padding to use for BNDs [default: 50]'
    inputBinding:
      position: 102
      prefix: --slack-bnd
  - id: slack_ins
    type:
      - 'null'
      - int
    doc: 'Padding to use for INS [default: 50]'
    inputBinding:
      position: 102
      prefix: --slack-ins
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Increase logging verbosity
    inputBinding:
      position: 102
      prefix: --verbose
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Decrease logging verbosity
    inputBinding:
      position: 102
      prefix: --quiet
outputs:
  - id: output_tsv
    type:
      - 'null'
      - File
    doc: Inhouse database TSV file
    outputBinding:
      glob: $(inputs.path_output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/varfish-server-worker:0.17.3--h13c227e_0
