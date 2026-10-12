cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - paraclu-cut
label: paraclu_paraclu-cut
doc: "Extract a subset of clusters from the output of paraclu. It omits clusters
  that are too long or are singletons, removes clusters whose fold-increase in
  density is too small, and removes clusters contained in larger clusters. The
  input must be sorted by start position (ascending) then end position
  (descending).\n\nTool homepage: http://cbrc3.cbrc.jp/~martin/paraclu/"
inputs:
  - id: max_length
    type:
      - 'null'
      - int
    doc: Maximum cluster length (default 200)
    inputBinding:
      position: 1
      prefix: -l
  - id: min_density_increase
    type:
      - 'null'
      - float
    doc: Minimum density increase (default 2)
    inputBinding:
      position: 1
      prefix: -d
  - id: single_cluster_increase
    type:
      - 'null'
      - boolean
    doc: Density increase applies to single clusters, not cumulatively
    inputBinding:
      position: 1
      prefix: -s
  - id: paraclu_output
    type:
      type: array
      items: File
    doc: Paraclu output file(s)
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/paraclu:10--h077b44d_6
stdout: paraclu_paraclu-cut.out
