cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phykit
  - bipartition_support_stats
label: phykit_bipartition_support_stats
doc: Calculate summary statistics for bipartition support. High bipartition 
  support values are thought to be desirable because they are indicative of 
  greater certainty in tree topology.
inputs:
  - id: tree
    type: File
    doc: first argument after function name should be a tree file
    inputBinding:
      position: 1
  - id: thresholds
    type:
      - 'null'
      - string
    doc: optional comma-separated support cutoffs; reports count and fraction of
      bipartitions below each cutoff
    inputBinding:
      position: 102
      prefix: --thresholds
  - id: json
    type:
      - 'null'
      - boolean
    doc: optional argument to output results as JSON
    inputBinding:
      position: 102
      prefix: --json
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phykit:2.1.92--pyhdfd78af_0
stdout: phykit_bipartition_support_stats.out
s:url: https://github.com/jlsteenwyk/phykit
$namespaces:
  s: https://schema.org/
