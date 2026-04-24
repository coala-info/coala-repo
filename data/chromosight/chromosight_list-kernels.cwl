cwlVersion: v1.2
class: CommandLineTool
baseCommand: chromosight
label: chromosight_list-kernels
doc: "Explore and detect patterns (loops, borders, centromeres, etc.) in Hi-C contact
  maps with pattern matching.\n\nTool homepage: https://github.com/koszullab/chromosight"
inputs:
  - id: dump
    type:
      - 'null'
      - Directory
    doc: Directory where to save matrix dumps during processing and detection. 
      Each dump is saved as a compressed npz of a sparse matrix and can be 
      loaded using scipy.sparse.load_npz.
    inputBinding:
      position: 101
      prefix: --dump
  - id: inter
    type:
      - 'null'
      - boolean
    doc: 'Enable to consider interchromosomal contacts. Warning: Experimental feature
      with high memory consumption, only use with small matrices.'
    inputBinding:
      position: 101
      prefix: --inter
  - id: iterations
    type:
      - 'null'
      - string
    doc: How many iterations to perform after the first template-based pass.
    inputBinding:
      position: 101
      prefix: --iterations
  - id: kernel_config
    type:
      - 'null'
      - File
    doc: Optionally give a path to a custom JSON kernel config path. Use this to
      override pattern if you do not want to use one of the preset patterns.
    inputBinding:
      position: 101
      prefix: --kernel-config
  - id: max_dist
    type:
      - 'null'
      - string
    doc: Maximum distance from the diagonal (in base pairs) for detection.
    inputBinding:
      position: 101
      prefix: --max-dist
  - id: min_dist
    type:
      - 'null'
      - string
    doc: Minimum distance from the diagonal (in base pairs). at which detection 
      should operate.
    inputBinding:
      position: 101
      prefix: --min-dist
  - id: min_separation
    type:
      - 'null'
      - string
    doc: Minimum distance required between patterns, in basepairs. If two 
      patterns are closer than this distance in both axes, the one with the 
      lowest score is discarded.
    inputBinding:
      position: 101
      prefix: --min-separation
  - id: n_mads
    type:
      - 'null'
      - int
    doc: Maximum number of median absolute deviations below the median of the 
      bin sums distribution allowed to consider detectable bins.
    inputBinding:
      position: 101
      prefix: --n-mads
  - id: no_plotting
    type:
      - 'null'
      - boolean
    doc: Disable generation of pileup plots.
    inputBinding:
      position: 101
      prefix: --no-plotting
  - id: norm
    type:
      - 'null'
      - string
    doc: 'Normalization / balancing behaviour. auto: weights present in the cool file
      are used. raw: raw contact values are used. force: recompute weights and overwrite
      existing values. raw[default: auto]'
    inputBinding:
      position: 101
      prefix: --norm
  - id: pattern
    type:
      - 'null'
      - string
    doc: 'Which pattern to detect. This will use preset configurations for the given
      pattern. Possible values are: loops, loops_small, borders, hairpins and centromeres.'
    inputBinding:
      position: 101
      prefix: --pattern
  - id: pearson
    type:
      - 'null'
      - string
    doc: Pearson correlation threshold when detecting patterns in the contact 
      map. Lower values leads to potentially more detections, but more false 
      positives.
    inputBinding:
      position: 101
      prefix: --pearson
  - id: perc_undetected
    type:
      - 'null'
      - string
    doc: Maximum percentage of non-detectable pixels (nan) in windows allowed to
      report patterns.
    inputBinding:
      position: 101
      prefix: --perc-undetected
  - id: perc_zero
    type:
      - 'null'
      - string
    doc: Maximum percentage of empty (0) pixels in windows allowed to report 
      patterns.
    inputBinding:
      position: 101
      prefix: --perc-zero
  - id: smooth_trend
    type:
      - 'null'
      - boolean
    doc: Use isotonic regression when detrending to reduce noise at long ranges.
      Do not enable this for circular genomes.
    inputBinding:
      position: 101
      prefix: --smooth-trend
  - id: subsample
    type:
      - 'null'
      - string
    doc: If greater than 1, subsample INT contacts from the matrix. If between 0
      and 1, subsample a proportion of contacts instead. Useful when comparing 
      matrices with different coverages.
    inputBinding:
      position: 101
      prefix: --subsample
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of CPUs to use in parallel.
    inputBinding:
      position: 101
      prefix: --threads
  - id: tsvd
    type:
      - 'null'
      - boolean
    doc: Enable kernel factorisation via truncated svd. Accelerates detection, 
      at the cost of slight inaccuracies. Singular matrices are truncated to 
      retain 99.9% of the information in the kernel.
    inputBinding:
      position: 101
      prefix: --tsvd
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Displays the logo.
    inputBinding:
      position: 101
      prefix: --verbose
  - id: win_fmt
    type:
      - 'null'
      - string
    doc: File format used to store individual windows around each pattern. 
      Window order matches patterns inside the associated text file. Possible 
      formats are json and npy.
    inputBinding:
      position: 101
      prefix: --win-fmt
  - id: win_size
    type:
      - 'null'
      - string
    doc: Window size (width), in pixels, to use for the kernel when computing 
      correlations. The pattern kernel will be resized to match this size. 
      Linear linear interpolation is used to fill between pixels. If not 
      specified, the default kernel size will be used instead.
    inputBinding:
      position: 101
      prefix: --win-size
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chromosight:1.6.3--pyhdfd78af_0
stdout: chromosight_list-kernels.out
