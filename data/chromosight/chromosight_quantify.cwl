cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - chromosight
  - quantify
label: chromosight_quantify
doc: "Given a list of pairs of positions and a contact map, computes the correlation
  coefficients between those positions and the kernel of the selected pattern.\n\n\
  Tool homepage: https://github.com/koszullab/chromosight"
inputs:
  - id: bed2d
    type: File
    doc: Tab-separated text files with columns chrom1, start1 end1, chrom2, 
      start2, end2. Each line correspond to a pair of positions (i.e. a position
      in the matrix).
    inputBinding:
      position: 1
  - id: contact_map
    type: File
    doc: Path to the contact map, in cool format.
    inputBinding:
      position: 2
  - id: prefix
    type: string
    doc: Common path prefix used to generate output files. Extensions will be 
      added for each file.
    inputBinding:
      position: 3
  - id: inter
    type:
      - 'null'
      - boolean
    doc: 'Enable to consider interchromosomal contacts. Warning: Experimental feature
      with high memory consumption, only use with small matrices.'
    inputBinding:
      position: 104
      prefix: --inter
  - id: kernel_config
    type:
      - 'null'
      - File
    doc: Optionally give a path to a custom JSON kernel config path. Use this to
      override pattern if you do not want to use one of the preset patterns.
    inputBinding:
      position: 104
      prefix: --kernel-config
  - id: n_mads
    type:
      - 'null'
      - int
    doc: Maximum number of median absolute deviations below the median of the 
      bin sums distribution allowed to consider detectable bins.
    default: 5
    inputBinding:
      position: 104
      prefix: --n-mads
  - id: no_plotting
    type:
      - 'null'
      - boolean
    doc: Disable generation of pileup plots.
    inputBinding:
      position: 104
      prefix: --no-plotting
  - id: norm
    type:
      - 'null'
      - string
    doc: 'Normalization / balancing behaviour. auto: weights present in the cool file
      are used. raw: raw contact values are used. force: recompute weights and overwrite
      existing values. raw[default: auto]'
    default: auto
    inputBinding:
      position: 104
      prefix: --norm
  - id: pattern
    type:
      - 'null'
      - string
    doc: 'Which pattern to detect. This will use preset configurations for the given
      pattern. Possible values are: loops, loops_small, borders, hairpins and centromeres.'
    default: loops
    inputBinding:
      position: 104
      prefix: --pattern
  - id: perc_undetected
    type:
      - 'null'
      - string
    doc: Maximum percentage of non-detectable pixels (nan) in windows allowed to
      report patterns.
    default: auto
    inputBinding:
      position: 104
      prefix: --perc-undetected
  - id: perc_zero
    type:
      - 'null'
      - string
    doc: Maximum percentage of empty (0) pixels in windows allowed to report 
      patterns.
    default: auto
    inputBinding:
      position: 104
      prefix: --perc-zero
  - id: subsample
    type:
      - 'null'
      - string
    doc: If greater than 1, subsample INT contacts from the matrix. If between 0
      and 1, subsample a proportion of contacts instead. Useful when comparing 
      matrices with different coverages.
    default: no
    inputBinding:
      position: 104
      prefix: --subsample
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of CPUs to use in parallel.
    default: 1
    inputBinding:
      position: 104
      prefix: --threads
  - id: tsvd
    type:
      - 'null'
      - boolean
    doc: Enable kernel factorisation via truncated svd. Accelerates detection, 
      at the cost of slight inaccuracies. Singular matrices are truncated to 
      retain 99.9% of the information in the kernel.
    inputBinding:
      position: 104
      prefix: --tsvd
  - id: win_fmt
    type:
      - 'null'
      - string
    doc: File format used to store individual windows around each pattern. 
      Window order matches patterns inside the associated text file. Possible 
      formats are json and npy.
    default: json
    inputBinding:
      position: 104
      prefix: --win-fmt
  - id: win_size
    type:
      - 'null'
      - string
    doc: Window size (width), in pixels, to use for the kernel when computing 
      correlations. The pattern kernel will be resized to match this size. 
      Linear linear interpolation is used to fill between pixels. If not 
      specified, the default kernel size will be used instead.
    default: auto
    inputBinding:
      position: 104
      prefix: --win-size
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chromosight:1.6.3--pyhdfd78af_0
stdout: chromosight_quantify.out
