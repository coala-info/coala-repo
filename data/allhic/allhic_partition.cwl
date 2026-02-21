cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - allhic
  - partition
label: allhic_partition
doc: "Separate all the contigs into separate clusters using a hierarchical clustering
  algorithm based on average links. Requires counts_RE.txt and pairs.txt generated
  by the extract sub-command.\n\nTool homepage: https://github.com/tanghaibao/allhic"
inputs:
  - id: counts_re
    type: File
    doc: Input counts_RE.txt file
    inputBinding:
      position: 1
  - id: pairs
    type: File
    doc: Input pairs.txt file
    inputBinding:
      position: 2
  - id: k
    type: int
    doc: Target number of partitions (clusters)
    inputBinding:
      position: 3
  - id: max_link_density
    type:
      - 'null'
      - int
    doc: Density threshold before marking contig as repetitive (CLUSTER_MAX_LINK_DENSITY
      in LACHESIS)
    default: 2
    inputBinding:
      position: 104
      prefix: --maxLinkDensity
  - id: min_res
    type:
      - 'null'
      - int
    doc: Minimum number of RE sites in a contig to be clustered (CLUSTER_MIN_RE_SITES
      in LACHESIS)
    default: 10
    inputBinding:
      position: 104
      prefix: --minREs
  - id: non_informative_ratio
    type:
      - 'null'
      - int
    doc: cutoff for recovering skipped contigs back into the clusters (CLUSTER_NON-INFORMATIVE_RATIO
      in LACHESIS)
    default: 3
    inputBinding:
      position: 104
      prefix: --nonInformativeRatio
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/allhic:0.9.14--he881be0_0
stdout: allhic_partition.out
