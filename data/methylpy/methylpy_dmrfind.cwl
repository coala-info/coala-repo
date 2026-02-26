cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - methylpy
  - DMRfind
label: methylpy_dmrfind
doc: "Find differentially methylated regions (DMRs) from ALLC files.\n\nTool homepage:
  https://github.com/yupenghe/methylpy"
inputs:
  - id: allc_files
    type:
      type: array
      items: File
    doc: List of ALLC files for DMR finding.
    inputBinding:
      position: 101
      prefix: --allc-files
  - id: bin_size
    type:
      - 'null'
      - int
    doc: Size of bins for DMR finding.
    inputBinding:
      position: 101
      prefix: --bin-size
  - id: chroms
    type:
      - 'null'
      - type: array
        items: string
    doc: Space-separated list of chromosomes to process.
    inputBinding:
      position: 101
      prefix: --chroms
  - id: dmr_max_dist
    type:
      - 'null'
      - int
    doc: Maximum distance between DMRs to be merged.
    inputBinding:
      position: 101
      prefix: --dmr-max-dist
  - id: mc_max_dist
    type:
      - 'null'
      - int
    doc: Maximum distance between sites to be included in the same DMR.
    inputBinding:
      position: 101
      prefix: --mc-max-dist
  - id: mc_type
    type:
      - 'null'
      - type: array
        items: string
    doc: Type of methylation to consider (e.g., CG, CHG, CHH).
    default: CG
    inputBinding:
      position: 101
      prefix: --mc-type
  - id: min_cov
    type:
      - 'null'
      - int
    doc: Minimum coverage for a site to be considered.
    inputBinding:
      position: 101
      prefix: --min-cov
  - id: min_num_dms
    type:
      - 'null'
      - int
    doc: Minimum number of DMCs in a DMR.
    inputBinding:
      position: 101
      prefix: --min-num-dms
  - id: ndmcs
    type:
      - 'null'
      - int
    doc: Number of differentially methylated cytosines required in a DMR.
    inputBinding:
      position: 101
      prefix: --ndmcs
  - id: num_procs
    type:
      - 'null'
      - int
    doc: Number of processors to use.
    default: 1
    inputBinding:
      position: 101
      prefix: --num-procs
  - id: num_sims
    type:
      - 'null'
      - int
    doc: Number of simulations for permutation test.
    inputBinding:
      position: 101
      prefix: --num-sims
  - id: sample_category
    type:
      - 'null'
      - type: array
        items: string
    doc: Category for each sample.
    inputBinding:
      position: 101
      prefix: --sample-category
  - id: samples
    type:
      type: array
      items: string
    doc: List of sample names corresponding to the ALLC files.
    inputBinding:
      position: 101
      prefix: --samples
  - id: sig_cutoff
    type:
      - 'null'
      - float
    doc: P-value cutoff for significance.
    inputBinding:
      position: 101
      prefix: --sig-cutoff
outputs:
  - id: output_prefix
    type: File
    doc: Prefix for output files.
    outputBinding:
      glob: $(inputs.output_prefix)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/methylpy:1.4.7--py39h0ae133c_0
