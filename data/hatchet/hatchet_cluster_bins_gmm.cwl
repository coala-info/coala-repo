cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hatchet
  - cluster-bins-gmm
label: hatchet_cluster_bins_gmm
doc: "Cluster the bins of a BB file with a Dirichlet-process Gaussian mixture model to obtain the segments and a BBC file adding the clusters.

Tool homepage: https://github.com/raphael-group/hatchet"
inputs:
  - id: bbfile
    type: File
    doc: A BB file containing a line for each bin in each sample and the corresponding values of read-depth ratio and B-allele frequency (BAF)
    inputBinding:
      position: 100
  - id: outsegments
    type:
      - 'null'
      - string
    doc: "Output filename for the segments computed by clustering bins (default: stdout)"
    inputBinding:
      position: 10
      prefix: -o
  - id: outbins
    type:
      - 'null'
      - string
    doc: "Output filename for a BB file adding the clusters (default: stdout)"
    inputBinding:
      position: 10
      prefix: -O
  - id: diploidbaf
    type:
      - 'null'
      - float
    doc: "Maximum diploid-BAF shift used to determine the largest copy-neutral cluster and to rescale all the cluster inside this threshold accordingly (default: None, scaling is not performed)"
    inputBinding:
      position: 10
      prefix: -d
  - id: tolerancerdr
    type:
      - 'null'
      - float
    doc: "Refine the clustering merging the clusters with this maximum difference in RDR values (default: None, gurobipy required)"
    inputBinding:
      position: 10
      prefix: -tR
  - id: tolerancebaf
    type:
      - 'null'
      - float
    doc: "Refine the clustering merging the clusters with this maximum difference in BAF values (default: None, gurobipy required)"
    inputBinding:
      position: 10
      prefix: -tB
  - id: bootclustering
    type:
      - 'null'
      - int
    doc: "Number of points to add for bootstraping each bin to improve the clustering (default: 0)"
    inputBinding:
      position: 10
      prefix: -u
  - id: ratiodeviation
    type:
      - 'null'
      - float
    doc: "Standard deviation of the read ratios used to generate the points in the clouds (default: 0.02)"
    inputBinding:
      position: 10
      prefix: -dR
  - id: bafdeviation
    type:
      - 'null'
      - float
    doc: "Standard deviation of the BAFs used to generate the points in the clouds (default: 0.02)"
    inputBinding:
      position: 10
      prefix: -dB
  - id: seed
    type:
      - 'null'
      - int
    doc: "Random seed used for clustering AND the normal distributions used in the clouds (default: 0)"
    inputBinding:
      position: 10
      prefix: -e
  - id: initclusters
    type:
      - 'null'
      - int
    doc: "The maximum number of clusters to infer (default: 50)"
    inputBinding:
      position: 10
      prefix: -K
  - id: concentration
    type:
      - 'null'
      - float
    doc: "Concentration parameter for the Dirichlet process prior. Higher favors more clusters, lower favors fewer clusters (default 0.02 = 1/K)"
    inputBinding:
      position: 10
      prefix: -c
  - id: restarts
    type:
      - 'null'
      - int
    doc: "Number of restarts performed by the clustering to choose the best (default: 10)"
    inputBinding:
      position: 10
      prefix: -R
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Use verbose log messages
    inputBinding:
      position: 10
      prefix: -v
  - id: disablebar
    type:
      - 'null'
      - boolean
    doc: Disable progress bar
    inputBinding:
      position: 10
      prefix: --disablebar
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: segments
    type:
      - 'null'
      - File
    doc: Segments computed by clustering bins
    outputBinding:
      glob: $(inputs.outsegments)
  - id: clustered_bins
    type:
      - 'null'
      - File
    doc: "BBC file: the BB file with the cluster of each bin"
    outputBinding:
      glob: $(inputs.outbins)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hatchet:2.1.2--py310h184ae93_0
stdout: hatchet_cluster_bins_gmm.out
