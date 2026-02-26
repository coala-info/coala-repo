cwlVersion: v1.2
class: CommandLineTool
baseCommand: segment-cnv
label: neoloop_segment-cnv
doc: "Perform HMM segmentation on a pre-calculated copy number variation profile.\n\
  \nTool homepage: https://github.com/XiaoTaoWang/NeoLoopFinder"
inputs:
  - id: binsize
    type:
      - 'null'
      - int
    doc: Bin size in base pairs.
    default: None
    inputBinding:
      position: 101
      prefix: --binsize
  - id: cbs_pvalue
    type:
      - 'null'
      - float
    doc: The P-value cutoff used in the circular binary segmentation (CBS) 
      algorithm.
    default: '1e-05'
    inputBinding:
      position: 101
      prefix: --cbs-pvalue
  - id: cnv_file
    type:
      - 'null'
      - File
    doc: Copy number profile in bedGraph format.
    default: None
    inputBinding:
      position: 101
      prefix: --cnv-file
  - id: log_file
    type:
      - 'null'
      - File
    doc: Logging file name.
    default: cnv-seg.log
    inputBinding:
      position: 101
      prefix: --logFile
  - id: max_dist
    type:
      - 'null'
      - int
    doc: Maximum allowed distance between HMM and CBS breakpoints.
    default: 4
    inputBinding:
      position: 101
      prefix: --max-dist
  - id: min_diff
    type:
      - 'null'
      - float
    doc: Minimum copy number difference between neighboring segments. Two 
      neighboring segments will be merged together if the difference of their 
      copy number ratio is less than this value.
    default: 0.4
    inputBinding:
      position: 101
      prefix: --min-diff
  - id: min_segment_size
    type:
      - 'null'
      - int
    doc: Minimum segment size. Small segments with a size less than this number 
      of bins will be merged with nearby larger segments.
    default: 3
    inputBinding:
      position: 101
      prefix: --min-segment-size
  - id: nproc
    type:
      - 'null'
      - int
    doc: Number of worker processes.
    default: 1
    inputBinding:
      position: 101
      prefix: --nproc
  - id: num_of_states
    type:
      - 'null'
      - int
    doc: The number of states to initialize. By default, this number is 
      estimated using a Gaussian Mixture model and the AIC criterion.
    default: None
    inputBinding:
      position: 101
      prefix: --num-of-states
  - id: ploidy
    type:
      - 'null'
      - int
    doc: Ploidy of the cell.
    default: 2
    inputBinding:
      position: 101
      prefix: --ploidy
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output file path.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/neoloop:0.4.3.post2--pyhdfd78af_0
