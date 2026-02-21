cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - piscem-infer
  - quant
label: piscem-infer_quant
doc: "quantify from the rad file\n\nTool homepage: https://github.com/COMBINE-lab/piscem-infer"
inputs:
  - id: convergence_thresh
    type:
      - 'null'
      - float
    doc: convergence threshold for EM
    default: 0.001
    inputBinding:
      position: 101
      prefix: --convergence-thresh
  - id: factorized_eqc_bins
    type:
      - 'null'
      - int
    doc: number of probability bins to use in RangeFactorized equivalence classes.
      If this value is set to 1, then basic equivalence classes are used
    default: 64
    inputBinding:
      position: 101
      prefix: --factorized-eqc-bins
  - id: fld_mean
    type:
      - 'null'
      - float
    doc: mean of fragment length distribution mean (required, and used, only in the
      case of unpaired fragments)
    inputBinding:
      position: 101
      prefix: --fld-mean
  - id: fld_sd
    type:
      - 'null'
      - float
    doc: mean of fragment length distribution standard deviation (required, and used,
      only in the case of unpaired fragments)
    inputBinding:
      position: 101
      prefix: --fld-sd
  - id: input
    type: string
    doc: input stem (i.e. without the .rad suffix)
    inputBinding:
      position: 101
      prefix: --input
  - id: lib_type
    type: string
    doc: the expected library type
    inputBinding:
      position: 101
      prefix: --lib-type
  - id: max_iter
    type:
      - 'null'
      - int
    doc: max iterations to run the EM
    default: 1500
    inputBinding:
      position: 101
      prefix: --max-iter
  - id: num_bootstraps
    type:
      - 'null'
      - int
    doc: number of bootstrap replicates to perform
    default: 0
    inputBinding:
      position: 101
      prefix: --num-bootstraps
  - id: num_threads
    type:
      - 'null'
      - int
    doc: number of threads to use (used during the EM and for bootstrapping)
    default: 16
    inputBinding:
      position: 101
      prefix: --num-threads
  - id: param_est_frags
    type:
      - 'null'
      - int
    doc: number of (unique) mappings to use to perform initial coarse-grained estimation
      of the fragment length distribution. These fragments will have to be read from
      the file and interrogated twice
    default: 500000
    inputBinding:
      position: 101
      prefix: --param-est-frags
  - id: presence_thresh
    type:
      - 'null'
      - float
    doc: presence threshold for EM
    default: 1e-08
    inputBinding:
      position: 101
      prefix: --presence-thresh
outputs:
  - id: output
    type: File
    doc: output file prefix (multiple output files may be created, the main will have
      a `.quant` suffix)
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/piscem-infer:0.7.0--h090f6cf_0
