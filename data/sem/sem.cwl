cwlVersion: v1.2
class: CommandLineTool
baseCommand: sem
label: sem
doc: "SEM (Subnucleosomal Ensemble Mapping) for nucleosome detection and fragment
  size distribution analysis.\n\nTool homepage: https://github.com/YenLab/SEM"
inputs:
  - id: alphascale
    type:
      - 'null'
      - float
    doc: alpha scaling factor
    inputBinding:
      position: 101
      prefix: --alphascale
  - id: bmanalysiswindowmax
    type:
      - 'null'
      - int
    doc: Preferred potential region length
    inputBinding:
      position: 101
      prefix: --bmanalysiswindowmax
  - id: config
    type:
      - 'null'
      - File
    doc: 'config file: all options here can be specified in a name<space>value text
      file'
    inputBinding:
      position: 101
      prefix: --config
  - id: consensus_exclusion
    type:
      - 'null'
      - string
    doc: consensus exclusion zone
    inputBinding:
      position: 101
      prefix: --consensusExclusion
  - id: design
    type:
      - 'null'
      - File
    doc: experiment design file name to use instead of --expt and --ctrl
    inputBinding:
      position: 101
      prefix: --design
  - id: exclude
    type:
      - 'null'
      - File
    doc: file of regions to ignore
    inputBinding:
      position: 101
      prefix: --exclude
  - id: expt
    type:
      - 'null'
      - File
    doc: experiment file name
    inputBinding:
      position: 101
      prefix: --expt
  - id: fixedalpha
    type:
      - 'null'
      - int
    doc: minimum number of fragments a nucleosome should have
    inputBinding:
      position: 101
      prefix: --fixedalpha
  - id: format
    type:
      - 'null'
      - string
    doc: Format of experiment file (SAM/BED/SCIDX)
    inputBinding:
      position: 101
      prefix: --format
  - id: geninfo
    type: File
    doc: genome info file
    inputBinding:
      position: 101
      prefix: --geninfo
  - id: mappability
    type:
      - 'null'
      - float
    doc: fraction of the genome that is mappable for these experiments
    inputBinding:
      position: 101
      prefix: --mappability
  - id: max_model_update_rounds
    type:
      - 'null'
      - int
    doc: max. model update rounds
    inputBinding:
      position: 101
      prefix: --r
  - id: nocache
    type:
      - 'null'
      - boolean
    doc: flag to turn off caching of the entire set of experiments
    inputBinding:
      position: 101
      prefix: --nocache
  - id: nonunique
    type:
      - 'null'
      - boolean
    doc: flag to use non-unique reads
    inputBinding:
      position: 101
      prefix: --nonunique
  - id: num_clusters
    type:
      - 'null'
      - int
    doc: number of clusters for finite GMM on fragment size distribution, if set
      -1, GMM with Dirichlet prior will be used
    inputBinding:
      position: 101
      prefix: --numClusters
  - id: only_gmm
    type:
      - 'null'
      - boolean
    doc: only Run GMM without the following nucleosome calling steps
    inputBinding:
      position: 101
      prefix: --onlyGMM
  - id: provided_binding_subtypes
    type:
      - 'null'
      - string
    doc: 'custom binding subtypes (format: mean variance weight, sum of weights =
      1)'
    inputBinding:
      position: 101
      prefix: --providedBindingSubtypes
  - id: provided_potential_regions
    type:
      - 'null'
      - File
    doc: bed file to restrict nucleosome detection regions
    inputBinding:
      position: 101
      prefix: --providedPotenialRegions
  - id: seq
    type:
      - 'null'
      - Directory
    doc: fasta seq directory reqd if using motif prior
    inputBinding:
      position: 101
      prefix: --seq
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads to use
    inputBinding:
      position: 101
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: flag to print intermediate files and extra output
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: out
    type: File
    doc: output file prefix
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sem:1.2.3--hdfd78af_0
