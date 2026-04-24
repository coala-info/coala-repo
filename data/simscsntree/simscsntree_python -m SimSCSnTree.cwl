cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - python
  - main.py
label: simscsntree_python -m SimSCSnTree
doc: "A single cell simulator generating low coverage data. The program automatically
  generates a phylogenetic tree with copy number variations on the branches. On each
  leave of the tree, it generates the reads whose error profile, such as uneven coverage,
  mimics the real single cell data.\n\nTool homepage: https://github.com/compbiofan/SimSCSnTree"
inputs:
  - id: acceptance_rate
    type:
      - 'null'
      - float
    doc: The probability to accept a proposal in Metropolis Hasting.
    inputBinding:
      position: 101
      prefix: --acceptance-rate
  - id: alpha
    type:
      - 'null'
      - float
    doc: The Alpha in Beta-splitting model. Specify a value between [0, 1]. The 
      closer Alpha and Beta, the more balanced the tree.
    inputBinding:
      position: 101
      prefix: --Alpha
  - id: amp_num_geo_par
    type:
      - 'null'
      - float
    doc: 'Whole amplification copy number distribution (geometric distribution parameter:
      the smaller, the more evenly distributed).'
    inputBinding:
      position: 101
      prefix: --amp-num-geo-par
  - id: amp_p
    type:
      - 'null'
      - float
    doc: The parameter for the Genometric distribution for the number of copies 
      amplified.
    inputBinding:
      position: 101
      prefix: --amp-p
  - id: beta
    type:
      - 'null'
      - float
    doc: The program uses the Beta-splitting model to generate the phylogenetic 
      tree. Specify a value between [0, 1].
    inputBinding:
      position: 101
      prefix: --Beta
  - id: bulk_levels
    type:
      - 'null'
      - string
    doc: The levels of the bulk sequencing separated by semicolon. The 
      definition of the levels is the same as in -L. The default for this option
      is NA, meaning no bulk sequencing.
    inputBinding:
      position: 101
      prefix: --bulk-levels
  - id: cell_num
    type:
      - 'null'
      - int
    doc: Number of the cells on a level of interest. Always greater than -F 
      treewidth. Treewidth controls the total number of clones whereas cell-num 
      controls the total number of cells sequenced at a certain tree depth.
    inputBinding:
      position: 101
      prefix: --cell-num
  - id: cn_num
    type:
      - 'null'
      - int
    doc: The average number of copy number variations to be added on a branch.
    inputBinding:
      position: 101
      prefix: --cn-num
  - id: cov_bulk
    type:
      - 'null'
      - int
    doc: The coverage of the bulk sequencing. The same for all levels. This 
      parameter is needed when -U is identified.
    inputBinding:
      position: 101
      prefix: --cov-bulk
  - id: coverage
    type:
      - 'null'
      - float
    doc: The average coverage of the sequence.
    inputBinding:
      position: 101
      prefix: --coverage
  - id: del_rate
    type:
      - 'null'
      - float
    doc: The rate of deletion as compared to amplification.
    inputBinding:
      position: 101
      prefix: --del-rate
  - id: delta
    type:
      - 'null'
      - float
    doc: The rate of a node to disappear. Specify a value between [0, 1]. If all
      nodes have daughter nodes, take 0.
    inputBinding:
      position: 101
      prefix: --Delta
  - id: directory
    type:
      - 'null'
      - Directory
    doc: Location of simulated data. The program will remove the whole directory
      if it already exists. Otherwise it will create one.
    inputBinding:
      position: 101
      prefix: --directory
  - id: exp_theta
    type:
      - 'null'
      - float
    doc: The parameter for the Exponential distribution for copy number size, 
      beyond the minimum one.
    inputBinding:
      position: 101
      prefix: --exp-theta
  - id: fa_prefix
    type:
      - 'null'
      - string
    doc: The prefix of the alleles and read names.
    inputBinding:
      position: 101
      prefix: --fa-prefix
  - id: leaf_index_range
    type:
      - 'null'
      - string
    doc: For parallele job submission. >= min, < max leaf index will be 
      processed. min.max. This counts leaf nodes from 0.
    inputBinding:
      position: 101
      prefix: --leaf-index-range
  - id: levels
    type:
      - 'null'
      - string
    doc: This is for both tree inference and sampling ancestral nodes. If the 
      user is interested in sequencing nodes on multiple levels, user can 
      specify the levels of interest by separating them by semicolon. The first 
      tumor cell/clone under the trunk has level 1. If counting from the bottom 
      (leaf) of the tree, use minus before the number. For example, -1 is the 
      leaf level. The range of the level should be within [-depth, depth]. Users
      can specify desired levels according to -G to know which levels are 
      available. If that is the case, use a very small -K to make sure the depth
      is not smaller than the biggest level you specify.
    inputBinding:
      position: 101
      prefix: --levels
  - id: lorenz_x
    type:
      - 'null'
      - float
    doc: The value on the x-axis of the point furthest from the diagonal on the 
      Lorenz curve imitating the real coverage uneveness.
    inputBinding:
      position: 101
      prefix: --Lorenz-x
  - id: lorenz_y
    type:
      - 'null'
      - float
    doc: The value on the y-axis of the Lorenz curve imitating the real coverage
      unevenness. x > y. The closer (x, y) to the diagonal, the better the 
      coverage evenness.
    inputBinding:
      position: 101
      prefix: --Lorenz-y
  - id: min_cn_size
    type:
      - 'null'
      - int
    doc: Minimum copy number size.
    inputBinding:
      position: 101
      prefix: --min-cn-size
  - id: multi_root
    type:
      - 'null'
      - int
    doc: The multiplier of the mean CNV on root.
    inputBinding:
      position: 101
      prefix: --multi-root
  - id: outfile
    type:
      - 'null'
      - string
    doc: The standard output file, will be saved in output folder, just give the
      file name.
    inputBinding:
      position: 101
      prefix: --outfile
  - id: processors
    type:
      - 'null'
      - int
    doc: Numbers of processors available.
    inputBinding:
      position: 101
      prefix: --processors
  - id: readlen
    type:
      - 'null'
      - int
    doc: Read length for each read sequenced.
    inputBinding:
      position: 101
      prefix: --readlen
  - id: single_cell_per_node
    type:
      - 'null'
      - int
    doc: If this is on, each node represents one cell and there is no clonality 
      in the node. In this case tree_width will be the same as n (leaf num). 1 
      is on.
    inputBinding:
      position: 101
      prefix: --single-cell-per-node
  - id: skip_first_step
    type:
      - 'null'
      - int
    doc: If the alleles for all nodes have been made, the step can be skipped. 
      Make it 1 then.
    inputBinding:
      position: 101
      prefix: --skip-first-step
  - id: snv_rate
    type:
      - 'null'
      - float
    doc: 'The rate of the snv. snv-rate * branch-length = # snvs.'
    inputBinding:
      position: 101
      prefix: --snv-rate
  - id: template_ref
    type: File
    doc: The reference file to sequence the reads.
    inputBinding:
      position: 101
      prefix: --template-ref
  - id: treedepth
    type:
      - 'null'
      - int
    doc: The mean of the tree depth distribution. The final tree depth will be 
      sampled from a Gaussian with this mean and a fixed standard deviation.
    inputBinding:
      position: 101
      prefix: --treedepth
  - id: treedepthsigma
    type:
      - 'null'
      - float
    doc: The standard deviation of the tree depth distribution. To get exactly 
      the tree depth defined by -F, use a very small standard deviation, e.g., 
      0.0001.
    inputBinding:
      position: 101
      prefix: --treedepthsigma
  - id: treewidth
    type:
      - 'null'
      - int
    doc: The mean of the tree width distribution. The final tree width will be 
      sampled from a Gaussian with this mean and a fixed standard deviation.
    inputBinding:
      position: 101
      prefix: --treewidth
  - id: treewidthsigma
    type:
      - 'null'
      - float
    doc: The standard deviation of the tree width distribution. To get exactly 
      the tree width defined by -F, use a very small standard deviation, e.g., 
      0.0001.
    inputBinding:
      position: 101
      prefix: --treewidthsigma
  - id: wgsim_dir
    type: Directory
    doc: The directory of the binary of wgsim. It is in the same folder of this 
      main.py.
    inputBinding:
      position: 101
      prefix: --wgsim-dir
  - id: whole_amp
    type:
      - 'null'
      - int
    doc: If there is whole chromosome amplification, 1 as yes.
    inputBinding:
      position: 101
      prefix: --whole-amp
  - id: whole_amp_num
    type:
      - 'null'
      - int
    doc: Whole amplification copy number addition, which occurs to one allele at
      a time.
    inputBinding:
      position: 101
      prefix: --whole-amp-num
  - id: whole_amp_rate
    type:
      - 'null'
      - float
    doc: 'Whole amplification rate: rate of an allele chosen to be amplified'
    inputBinding:
      position: 101
      prefix: --whole-amp-rate
  - id: window_size
    type:
      - 'null'
      - int
    doc: Within a window, the coverage is according to a Gaussian distribution. 
      Neighboring windows' read coverage is according to a Metropolis Hasting 
      process.
    inputBinding:
      position: 101
      prefix: --window-size
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/simscsntree:0.0.9--pyh5e36f6f_0
stdout: simscsntree_python -m SimSCSnTree.out
