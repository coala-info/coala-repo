cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - python
  - -m
  - SimSCSnTree
label: simscsntree_python_-m_SimSCSnTree
doc: "SimSCSnTree is a single cell simulator generating low coverage data. It
  generates a phylogenetic tree with copy number variations and single nucleotide
  variations on the branches (first step) and, with wgsim, the reads for each leaf
  (second step, skip_first_step 1).\n\nTool homepage: https://github.com/compbiofan/SimSCSnTree"
inputs:
  - id: directory
    type: string
    doc: Location of simulated data. The program removes the whole directory if it already exists. Otherwise it creates one.
    inputBinding:
      position: 1
      prefix: --directory
  - id: processors
    type:
      - 'null'
      - int
    doc: "Numbers of processors available."
    inputBinding:
      position: 1
      prefix: --processors
  - id: wgsim_dir
    type:
      - 'null'
      - Directory
    doc: "The directory of the wgsim binary (needed for the read sampling step)."
    inputBinding:
      position: 1
      prefix: --wgsim-dir
  - id: leaf_num
    type:
      - 'null'
      - int
    doc: "Number of the cells on a level of interest. Always greater than the tree width. (default: 8)"
    inputBinding:
      position: 1
      prefix: --leaf-num
  - id: beta
    type:
      - 'null'
      - float
    doc: "The Beta in the Beta-splitting model, between 0 and 1. (default: 0.5)"
    inputBinding:
      position: 1
      prefix: --Beta
  - id: alpha
    type:
      - 'null'
      - float
    doc: "The Alpha in the Beta-splitting model, between 0 and 1. The closer Alpha and Beta, the more balanced the tree. (default: 0.5)"
    inputBinding:
      position: 1
      prefix: --Alpha
  - id: delta
    type:
      - 'null'
      - float
    doc: "The rate of a node to disappear, between 0 and 1. (default: 0)"
    inputBinding:
      position: 1
      prefix: --Delta
  - id: treewidth
    type:
      - 'null'
      - float
    doc: "The mean of the tree width distribution. (default: 8)"
    inputBinding:
      position: 1
      prefix: --treewidth
  - id: treedepth
    type:
      - 'null'
      - float
    doc: "The mean of the tree depth distribution. (default: 4 counting from the first cancer cell)"
    inputBinding:
      position: 1
      prefix: --treedepth
  - id: treewidthsigma
    type:
      - 'null'
      - float
    doc: "The standard deviation of the tree width distribution. (default: 0.5)"
    inputBinding:
      position: 1
      prefix: --treewidthsigma
  - id: treedepthsigma
    type:
      - 'null'
      - float
    doc: "The standard deviation of the tree depth distribution. (default: 0.5)"
    inputBinding:
      position: 1
      prefix: --treedepthsigma
  - id: cn_num
    type:
      - 'null'
      - float
    doc: "The average number of copy number variations to be added on a branch. (default: 1)"
    inputBinding:
      position: 1
      prefix: --cn-num
  - id: del_rate
    type:
      - 'null'
      - float
    doc: "The rate of deletion as compared to amplification. (default: 0.5)"
    inputBinding:
      position: 1
      prefix: --del-rate
  - id: min_cn_size
    type:
      - 'null'
      - int
    doc: "Minimum copy number size. (default: 2000000)"
    inputBinding:
      position: 1
      prefix: --min-cn-size
  - id: exp_theta
    type:
      - 'null'
      - int
    doc: "The parameter for the exponential distribution of copy number size beyond the minimum. (default: 5000000)"
    inputBinding:
      position: 1
      prefix: --exp-theta
  - id: amp_p
    type:
      - 'null'
      - float
    doc: "The parameter for the geometric distribution for the number of copies amplified. (default: 0.5)"
    inputBinding:
      position: 1
      prefix: --amp-p
  - id: template_ref
    type:
      - 'null'
      - File
    doc: "The reference file to sequence the reads from (FASTA with one entry per chromosome)."
    inputBinding:
      position: 1
      prefix: --template-ref
  - id: outfile
    type:
      - 'null'
      - string
    doc: "The standard output file, saved in the output folder (just a file name). (default: std.out)"
    inputBinding:
      position: 1
      prefix: --outfile
  - id: fa_prefix
    type:
      - 'null'
      - string
    doc: "The prefix of the alleles and read names. (default: ref)"
    inputBinding:
      position: 1
      prefix: --fa-prefix
  - id: lorenz_x
    type:
      - 'null'
      - float
    doc: "The x value of the point furthest from the diagonal on the Lorenz curve imitating coverage unevenness. (default: 0.5)"
    inputBinding:
      position: 1
      prefix: --Lorenz-x
  - id: lorenz_y
    type:
      - 'null'
      - float
    doc: "The y value of the Lorenz curve imitating coverage unevenness (x > y). (default: 0.4)"
    inputBinding:
      position: 1
      prefix: --Lorenz-y
  - id: coverage
    type:
      - 'null'
      - float
    doc: "The average coverage of the sequence. (default: 0.02)"
    inputBinding:
      position: 1
      prefix: --coverage
  - id: readlen
    type:
      - 'null'
      - int
    doc: "Read length for each read sequenced. (default: 35)"
    inputBinding:
      position: 1
      prefix: --readlen
  - id: window_size
    type:
      - 'null'
      - int
    doc: "Window size within which coverage follows a Gaussian distribution. (default: 200000)"
    inputBinding:
      position: 1
      prefix: --window-size
  - id: acceptance_rate
    type:
      - 'null'
      - float
    doc: "The probability to accept a proposal in Metropolis Hasting. (default: 0.5)"
    inputBinding:
      position: 1
      prefix: --acceptance-rate
  - id: skip_first_step
    type:
      - 'null'
      - int
    doc: "Set to 1 if the alleles for all nodes have been made, to skip the first step. (default: 0)"
    inputBinding:
      position: 1
      prefix: --skip-first-step
  - id: snv_rate
    type:
      - 'null'
      - float
    doc: "The rate of the SNV: snv-rate * branch-length = number of SNVs. (default: 0)"
    inputBinding:
      position: 1
      prefix: --snv_rate
  - id: multi_root
    type:
      - 'null'
      - float
    doc: "The multiplier of the mean CNV on the root. (default: 4)"
    inputBinding:
      position: 1
      prefix: --multi-root
  - id: whole_amp
    type:
      - 'null'
      - int
    doc: "If there is whole chromosome amplification, 1 as yes. (default: 0)"
    inputBinding:
      position: 1
      prefix: --whole-amp
  - id: whole_amp_rate
    type:
      - 'null'
      - float
    doc: "Whole amplification rate: rate of an allele chosen to be amplified. (default: 0.2)"
    inputBinding:
      position: 1
      prefix: --whole-amp-rate
  - id: whole_amp_num
    type:
      - 'null'
      - int
    doc: "Whole amplification copy number addition, which occurs to one allele at a time. (default: 1)"
    inputBinding:
      position: 1
      prefix: --whole-amp-num
  - id: amp_num_geo_par
    type:
      - 'null'
      - float
    doc: "Whole amplification copy number distribution (geometric distribution parameter). (default: 1)"
    inputBinding:
      position: 1
      prefix: --amp-num-geo-par
  - id: leaf_index_range
    type:
      - 'null'
      - string
    doc: "For parallel job submission: leaf indices >= min and < max are processed, as min.max. (default: -1)"
    inputBinding:
      position: 1
      prefix: --leaf-index-range
  - id: levels
    type:
      - 'null'
      - string
    doc: "Levels of interest for sequencing, separated by semicolons; negative numbers count from the leaf level. (default: -1)"
    inputBinding:
      position: 1
      prefix: --levels
  - id: bulk_levels
    type:
      - 'null'
      - string
    doc: "The levels of the bulk sequencing separated by semicolons. (default: NA, no bulk sequencing)"
    inputBinding:
      position: 1
      prefix: --bulk-levels
  - id: cov_bulk
    type:
      - 'null'
      - float
    doc: "The coverage of the bulk sequencing, the same for all levels. (default: 30)"
    inputBinding:
      position: 1
      prefix: --cov-bulk
  - id: single_cell_per_clone
    type:
      - 'null'
      - int
    doc: "If 1, each node represents one cell and there is no clonality in the node. (default: 0)"
    inputBinding:
      position: 1
      prefix: --single-cell-per-clone
outputs:
  - id: simulation_directory
    type: Directory
    doc: Directory with the simulated tree (.npy files), alleles, reads and log file
    outputBinding:
      glob: $(inputs.directory)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/simscsntree:0.0.9--pyh5e36f6f_0
