cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - galah
  - cluster-validate
label: galah_cluster-validate
doc: "Verify clustering results\n\nTool homepage: https://github.com/wwood/galah"
inputs:
  - id: ani
    type:
      - 'null'
      - float
    doc: ANI to validate against
    inputBinding:
      position: 101
      prefix: --ani
  - id: cluster_file
    type: File
    doc: Output of 'cluster' subcommand
    inputBinding:
      position: 101
      prefix: --cluster-file
  - id: min_aligned_fraction
    type:
      - 'null'
      - float
    doc: Min aligned fraction of two genomes for clustering
    inputBinding:
      position: 101
      prefix: --min-aligned-fraction
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Unless there is an error, do not print logging information
    inputBinding:
      position: 101
      prefix: --quiet
  - id: threads
    type:
      - 'null'
      - int
    inputBinding:
      position: 101
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print extra debug logging information
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/galah:0.4.2--hc1c3326_2
stdout: galah_cluster-validate.out
