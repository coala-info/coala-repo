cwlVersion: v1.2
class: CommandLineTool
baseCommand: decifer
label: decifer
doc: "DeCiFer.\n\nTool homepage: https://github.com/raphael-group/decifer"
inputs:
  - id: input
    type: File
    doc: Input file in DeCiFer format.
    inputBinding:
      position: 1
  - id: betabinomial
    type:
      - 'null'
      - boolean
    doc: 'Use betabinomial likelihood to cluster mutations (default: binomial)'
    default: false
    inputBinding:
      position: 102
      prefix: --betabinomial
  - id: binarysearch
    type:
      - 'null'
      - boolean
    doc: 'Use binary-search model selection (default: False, iterative is used; use
      binary search when considering large numbers of clusters'
    default: false
    inputBinding:
      position: 102
      prefix: --binarysearch
  - id: ccf
    type:
      - 'null'
      - boolean
    doc: 'Run with CCF instead of DCF (default: False)'
    default: false
    inputBinding:
      position: 102
      prefix: --ccf
  - id: conservativecis
    type:
      - 'null'
      - boolean
    doc: 'Beta: compute CIs using DCF point values assigned to cluster instead of
      cluster likelihood function'
    inputBinding:
      position: 102
      prefix: --conservativeCIs
  - id: debug
    type:
      - 'null'
      - boolean
    doc: single-threaded mode for development/debugging
    inputBinding:
      position: 102
      prefix: --debug
  - id: elbow
    type:
      - 'null'
      - float
    doc: 'Elbow sensitivity, lower values increase sensitivity (default: 0.06)'
    default: 0.06
    inputBinding:
      position: 102
      prefix: --elbow
  - id: jobs
    type:
      - 'null'
      - int
    doc: 'Number of parallele jobs to use (default: equal to number of available processors)'
    inputBinding:
      position: 102
      prefix: --jobs
  - id: maxit
    type:
      - 'null'
      - int
    doc: 'Maximum number of iterations per restart (default: 200)'
    default: 200
    inputBinding:
      position: 102
      prefix: --maxit
  - id: maxk
    type:
      - 'null'
      - int
    doc: 'Maximum number of clusters (default: 12)'
    default: 12
    inputBinding:
      position: 102
      prefix: --maxk
  - id: mink
    type:
      - 'null'
      - int
    doc: 'Minimum number of clusters, which must be at least 2 (default: 2)'
    default: 2
    inputBinding:
      position: 102
      prefix: --mink
  - id: output
    type:
      - 'null'
      - string
    doc: 'Output prefix (default: ./decifer)'
    default: ./decifer
    inputBinding:
      position: 102
      prefix: --output
  - id: printallk
    type:
      - 'null'
      - boolean
    doc: Print all results for each value of K explored by DeCiFer
    inputBinding:
      position: 102
      prefix: --printallk
  - id: purityfile
    type: File
    doc: File with purity of each sample (TSV file in two columns`SAMPLE 
      PURITY`)
    inputBinding:
      position: 102
      prefix: --purityfile
  - id: record
    type:
      - 'null'
      - boolean
    doc: 'Record objectives (default: False)'
    default: false
    inputBinding:
      position: 102
      prefix: --record
  - id: restarts
    type:
      - 'null'
      - int
    doc: 'Number of restarts (default: 20)'
    default: 20
    inputBinding:
      position: 102
      prefix: --restarts
  - id: restarts_bb
    type:
      - 'null'
      - int
    doc: 'Maximum size of brute-force search, when fitting betabinomial parameters
      (default: 1e4)'
    default: 10000
    inputBinding:
      position: 102
      prefix: --restarts_bb
  - id: seed
    type:
      - 'null'
      - int
    doc: 'Random-generator seed (default: None)'
    inputBinding:
      position: 102
      prefix: --seed
  - id: segfile
    type:
      - 'null'
      - File
    doc: 'File with precisions for betabinomial fit (default: binomial likelihood)'
    inputBinding:
      position: 102
      prefix: --segfile
  - id: sensitivity
    type:
      - 'null'
      - float
    doc: 'Sensitivity E to exclude SNPs with 0.5 - E <= BAF < 0.5, for estimating
      betabinomial parameters (default: 0.1)'
    default: 0.1
    inputBinding:
      position: 102
      prefix: --sensitivity
  - id: silhouette
    type:
      - 'null'
      - boolean
    doc: 'Beta: select the number of clusters using a silhouette score'
    inputBinding:
      position: 102
      prefix: --silhouette
  - id: skip
    type:
      - 'null'
      - int
    doc: 'Numbers to skip in the brute-force search, when fitting betabinomial parameters
      (default: 10)'
    default: 10
    inputBinding:
      position: 102
      prefix: --skip
  - id: snpfile
    type:
      - 'null'
      - File
    doc: 'File with precisions for betabinomial fit (default: binomial likelihood)'
    inputBinding:
      position: 102
      prefix: --snpfile
  - id: statetrees
    type:
      - 'null'
      - File
    doc: 'Filename of state-trees file (default: use state_trees.txt in the package)'
    inputBinding:
      position: 102
      prefix: --statetrees
  - id: vafdevfilter
    type:
      - 'null'
      - float
    doc: Filter poorly fit SNVs with VAFs that are more than this number of 
      standard deviations away from the cluster center VAF (default 1.5)
    default: 1.5
    inputBinding:
      position: 102
      prefix: --vafdevfilter
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/decifer:2.1.4--py312hf731ba3_4
stdout: decifer.out
