cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hatchet
  - cluster-bins
label: hatchet_cluster_bins
doc: "Cluster the bins of a BB file with a hidden Markov model (HMM) to obtain the segments and a BBC file adding the clusters.

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
    doc: "Maximum diploid-BAF shift used to determine the largest copy-neutral cluster and to rescale all the cluster inside this threshold accordingly (default: 0.1)"
    inputBinding:
      position: 10
      prefix: -d
  - id: minK
    type:
      - 'null'
      - int
    doc: Minimum number of clusters to infer (default = 5)
    inputBinding:
      position: 10
      prefix: --minK
  - id: maxK
    type:
      - 'null'
      - int
    doc: Maximum number of clusters to infer (default = 30)
    inputBinding:
      position: 10
      prefix: --maxK
  - id: exactK
    type:
      - 'null'
      - int
    doc: "Skip model selection and infer exactly this many clusters (default: None)"
    inputBinding:
      position: 10
      prefix: --exactK
  - id: transmat
    type:
      - 'null'
      - string
    doc: "Form of transition matrix to infer: fixed, diag (1-parameter), or full (default: diag)"
    inputBinding:
      position: 10
      prefix: -t
  - id: tau
    type:
      - 'null'
      - float
    doc: "Off-diagonal value for initializing transition matrix (default: 1e-06)"
    inputBinding:
      position: 10
      prefix: --tau
  - id: covar
    type:
      - 'null'
      - string
    doc: "Form of covariance matrix: spherical, diag, full, or tied (default: diag)"
    inputBinding:
      position: 10
      prefix: -c
  - id: decoding
    type:
      - 'null'
      - string
    doc: "Decoding algorithm to use: map or viterbi (default: map)"
    inputBinding:
      position: 10
      prefix: -x
  - id: selection
    type:
      - 'null'
      - string
    doc: "Number of HMM states selection criterion: bic or silhouette (default: bic)"
    inputBinding:
      position: 10
      prefix: -s
  - id: restarts
    type:
      - 'null'
      - int
    doc: "Number of restarts performed by the clustering to choose the best (default: 10)"
    inputBinding:
      position: 10
      prefix: -R
  - id: subset
    type:
      - 'null'
      - type: array
        items: string
    doc: "List of sample names to use as a subset of those included in binning (default: none, run on all samples)"
    inputBinding:
      position: 10
      prefix: -S
  - id: allow_gaps
    type:
      - 'null'
      - boolean
    doc: "Allow gaps in chromosomes (each contiguous region is considered a separate \"arm\")"
    inputBinding:
      position: 10
      prefix: --allow_gaps
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
stdout: hatchet_cluster_bins.out
