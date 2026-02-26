cwlVersion: v1.2
class: CommandLineTool
baseCommand: mquad
label: mquad
doc: "mquad\n\nTool homepage: https://github.com/aaronkwc/MQuad"
inputs:
  - id: batch_fit
    type:
      - 'null'
      - int
    doc: 1 if fit MixBin model using batch mode, 0 else
    default: 1
    inputBinding:
      position: 101
      prefix: --batchFit
  - id: batch_size
    type:
      - 'null'
      - int
    doc: Number of variants in one batch, cooperate with --nproc for speeding up
    default: 128
    inputBinding:
      position: 101
      prefix: --batchSize
  - id: beta_mode
    type:
      - 'null'
      - int
    doc: Use betabinomial model if True
    default: 0
    inputBinding:
      position: 101
      prefix: --beta
  - id: bic_params
    type:
      - 'null'
      - string
    doc: Existing unsorted_debug_BIC_params.csv
    inputBinding:
      position: 101
      prefix: --BICparams
  - id: cell_data
    type:
      - 'null'
      - Directory
    doc: The cellSNP folder with AD and DP sparse matrices.
    inputBinding:
      position: 101
      prefix: --cellData
  - id: min_cell
    type:
      - 'null'
      - int
    doc: Minimum no. of cells in minor component
    default: 2
    inputBinding:
      position: 101
      prefix: --minCell
  - id: min_dp
    type:
      - 'null'
      - int
    doc: Minimum DP to include for modelling
    default: 10
    inputBinding:
      position: 101
      prefix: --minDP
  - id: mtx_data
    type:
      - 'null'
      - string
    doc: The two mtx files for AD and DP matrices, comma separated
    inputBinding:
      position: 101
      prefix: --mtxData
  - id: nproc
    type:
      - 'null'
      - int
    doc: Number of subprocesses
    default: 1
    inputBinding:
      position: 101
      prefix: --nproc
  - id: rand_seed
    type:
      - 'null'
      - string
    doc: Seed for random initialization
    default: none
    inputBinding:
      position: 101
      prefix: --randSeed
  - id: tenx_cutoff
    type:
      - 'null'
      - string
    doc: User-defined deltaBIC cutoff mainly for low-depth data
    inputBinding:
      position: 101
      prefix: --tenx
  - id: vcf_data
    type:
      - 'null'
      - File
    doc: The cell genotype file in VCF format
    inputBinding:
      position: 101
      prefix: --vcfData
outputs:
  - id: out_dir
    type:
      - 'null'
      - Directory
    doc: Dirtectory for output files
    outputBinding:
      glob: $(inputs.out_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mquad:0.1.8b--pyhdfd78af_0
