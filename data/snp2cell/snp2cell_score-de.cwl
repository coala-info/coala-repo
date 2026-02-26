cwlVersion: v1.2
class: CommandLineTool
baseCommand: snp2cell score-de
label: snp2cell_score-de
doc: "Add an anndata object to the s2c object, find differentially expressed genes
  and propagate the gene scores across the network. Then the DE scores and previously
  computed SNP scores are combined and statistics are computed based on random permutations.\n\
  \nTool homepage: https://github.com/Teichlab/snp2cell"
inputs:
  - id: s2c_obj
    type: File
    doc: path to SNP2CELL object
    inputBinding:
      position: 1
  - id: anndata
    type: File
    doc: path to anndata object
    inputBinding:
      position: 2
  - id: groupby
    type:
      - 'null'
      - string
    doc: '`ad.obs` column with annotation for computing differential expression'
    inputBinding:
      position: 3
  - id: group
    type:
      - 'null'
      - type: array
        items: string
    doc: restrict to groups of `groupby`; may be set multiple times; default is 
      to use all groups
    inputBinding:
      position: 104
      prefix: -g
  - id: method
    type:
      - 'null'
      - string
    doc: method for DE calculation
    default: wilcoxon
    inputBinding:
      position: 104
  - id: n_cpu
    type:
      - 'null'
      - int
    doc: number of cpus to use
    inputBinding:
      position: 104
      prefix: -c
  - id: no_run_lognorm
    type:
      - 'null'
      - boolean
    doc: log-normalise counts
    inputBinding:
      position: 104
      prefix: --no-run-lognorm
  - id: no_use_raw
    type:
      - 'null'
      - boolean
    doc: use `ad.raw` attribute
    inputBinding:
      position: 104
      prefix: --no-use-raw
  - id: rank_by
    type:
      - 'null'
      - string
    doc: 'rank DE scores by absolute value, up- or downregulation; default: upregulation'
    default: up
    inputBinding:
      position: 104
      prefix: -r
  - id: reference
    type:
      - 'null'
      - string
    doc: reference group to compare against; default is to compare against the 
      rest
    inputBinding:
      position: 104
  - id: run_lognorm
    type:
      - 'null'
      - boolean
    doc: log-normalise counts
    inputBinding:
      position: 104
      prefix: --run-lognorm
  - id: snp_score_key
    type:
      - 'null'
      - string
    doc: key for accessing saved snp scores in object
    default: snp_score
    inputBinding:
      position: 104
      prefix: -k
  - id: use_raw
    type:
      - 'null'
      - boolean
    doc: use `ad.raw` attribute
    inputBinding:
      position: 104
      prefix: --use-raw
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snp2cell:0.3.0--pyhdfd78af_0
stdout: snp2cell_score-de.out
