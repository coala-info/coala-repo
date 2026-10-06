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
    inputBinding:
      position: 104
      prefix: --maxLinkDensity
  - id: min_res
    type:
      - 'null'
      - int
    doc: Minimum number of RE sites in a contig to be clustered (CLUSTER_MIN_RE_SITES
      in LACHESIS)
    inputBinding:
      position: 104
      prefix: --minREs
  - id: non_informative_ratio
    type:
      - 'null'
      - int
    doc: cutoff for recovering skipped contigs back into the clusters (CLUSTER_NON-INFORMATIVE_RATIO
      in LACHESIS)
    inputBinding:
      position: 104
      prefix: --nonInformativeRatio
outputs:
  - id: group_counts
    type:
      type: array
      items: File
    doc: RE counts file for each partition (<counts_RE prefix>.<k>g<n>.txt)
    outputBinding:
      glob: $(inputs.counts_re.nameroot).$(inputs.k)g*.txt
  - id: clusters
    type: File
    doc: Contigs in each partition (<prefix>.clusters.txt)
    outputBinding:
      glob: '*.clusters.txt'
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.counts_re)
      - $(inputs.pairs)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/allhic:0.9.14--he881be0_0
stdout: allhic_partition.out
