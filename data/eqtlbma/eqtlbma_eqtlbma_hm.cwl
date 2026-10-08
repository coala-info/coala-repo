cwlVersion: v1.2
class: CommandLineTool
baseCommand: eqtlbma_hm
label: eqtlbma_eqtlbma_hm
doc: "Fits the hierarchical model of eQtlBma with an EM algorithm.\n\nTool homepage: https://github.com/timflutre/eqtlbma"
inputs:
  - id: verbose
    type:
      - 'null'
      - int
    doc: "verbosity level (0/default=1/2/3)"
    inputBinding:
      position: 101
      prefix: --verbose
  - id: data
    type: File
    doc: "input data (usually output files from eqtlbma_bf)"
    inputBinding:
      position: 101
      prefix: --data
  - id: nsubgrp
    type: int
    doc: "number of subgroups"
    inputBinding:
      position: 101
      prefix: --nsubgrp
  - id: model
    type:
      - 'null'
      - string
    doc: "which model to fit (default=configs/types)"
    inputBinding:
      position: 101
      prefix: --model
  - id: dim
    type:
      - 'null'
      - int
    doc: "dimension of the model (nb of active configs or types)"
    inputBinding:
      position: 101
      prefix: --dim
  - id: ngrid
    type: int
    doc: "number of grid points"
    inputBinding:
      position: 101
      prefix: --ngrid
  - id: out_path
    type: string
    doc: "output file (gzipped)"
    inputBinding:
      position: 101
      prefix: --out
  - id: init
    type:
      - 'null'
      - File
    doc: "file for initialization (3 columns: param, value, fixed TRUE or FALSE)"
    inputBinding:
      position: 101
      prefix: --init
  - id: rand
    type:
      - 'null'
      - boolean
    doc: "random initialization"
    inputBinding:
      position: 101
      prefix: --rand
  - id: seed
    type:
      - 'null'
      - int
    doc: "seed used with --rand, otherwise use time"
    inputBinding:
      position: 101
      prefix: --seed
  - id: thresh
    type:
      - 'null'
      - float
    doc: "threshold to stop the EM (default=0.05)"
    inputBinding:
      position: 101
      prefix: --thresh
  - id: maxit
    type:
      - 'null'
      - int
    doc: "maximum number of iterations (optional)"
    inputBinding:
      position: 101
      prefix: --maxit
  - id: msl
    type:
      - 'null'
      - float
    doc: "maximum step length for SQUAREM, default=1 (classical EM), around 3 is a good option"
    inputBinding:
      position: 101
      prefix: --msl
  - id: thread
    type:
      - 'null'
      - int
    doc: "number of threads (default=1)"
    inputBinding:
      position: 101
      prefix: --thread
  - id: configs
    type:
      - 'null'
      - string
    doc: "subset of configurations to keep (e.g. \"1|3|1-3\")"
    inputBinding:
      position: 101
      prefix: --configs
  - id: keepgen
    type:
      - 'null'
      - boolean
    doc: "keep 'general' ABFs (useful for BMAlite)"
    inputBinding:
      position: 101
      prefix: --keepgen
  - id: getci
    type:
      - 'null'
      - boolean
    doc: "compute the confidence intervals (single thread, thus slow)"
    inputBinding:
      position: 101
      prefix: --getci
  - id: getbf
    type:
      - 'null'
      - boolean
    doc: "compute the Bayes Factors using the estimated weights"
    inputBinding:
      position: 101
      prefix: --getbf
  - id: pi0
    type:
      - 'null'
      - float
    doc: "fixed value for pi0 (pi0 hence won't be updated in the EM)"
    inputBinding:
      position: 101
      prefix: --pi0
  - id: ci
    type:
      - 'null'
      - File
    doc: "file with estimates of hyperparameters to only compute confidence intervals"
    inputBinding:
      position: 101
      prefix: --ci
outputs:
  - id: out
    type: File
    doc: Output file (gzipped)
    outputBinding:
      glob: $(inputs.out_path)
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/eqtlbma:1.3.3--h3dbd7e7_0
stdout: eqtlbma_eqtlbma_hm.out
