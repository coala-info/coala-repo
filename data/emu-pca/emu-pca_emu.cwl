cwlVersion: v1.2
class: CommandLineTool
baseCommand: emu
label: emu-pca_emu
doc: "Performs PCA on genotype data using an iterative method.\n\nTool homepage: https://github.com/Rosemeis/emu"
inputs:
  - id: batch_size
    type:
      - 'null'
      - int
    doc: Number of SNPs to use in batches of memory variant
    inputBinding:
      position: 101
      prefix: --batch
  - id: bfile_prefix
    type:
      - 'null'
      - string
    doc: Prefix for PLINK files (.bed, .bim, .fam)
    inputBinding:
      position: 101
      prefix: --bfile
  - id: maf_threshold
    type:
      - 'null'
      - float
    doc: Threshold for minor allele frequencies
    inputBinding:
      position: 101
      prefix: --maf
  - id: max_iterations
    type:
      - 'null'
      - int
    doc: Maximum iterations in estimation of individual allele frequencies
    inputBinding:
      position: 101
      prefix: --iter
  - id: memory_efficient
    type:
      - 'null'
      - boolean
    doc: Memory-efficient variant
    inputBinding:
      position: 101
      prefix: --mem
  - id: num_eigenvectors
    type:
      - 'null'
      - int
    doc: Number of eigenvectors to use in iterative estimation
    inputBinding:
      position: 101
      prefix: --eig
  - id: num_eigenvectors_output
    type:
      - 'null'
      - int
    doc: Number of eigenvectors to output in final SVD
    inputBinding:
      position: 101
      prefix: --eig-out
  - id: power_iterations
    type:
      - 'null'
      - int
    doc: Number of power iterations in randomized SVD
    inputBinding:
      position: 101
      prefix: --power
  - id: random_seed
    type:
      - 'null'
      - int
    doc: Set random seed
    inputBinding:
      position: 101
      prefix: --seed
  - id: raw_output
    type:
      - 'null'
      - boolean
    doc: Raw output without '*.fam' info
    inputBinding:
      position: 101
      prefix: --raw
  - id: save_loadings
    type:
      - 'null'
      - boolean
    doc: Save SNP loadings
    inputBinding:
      position: 101
      prefix: --loadings
  - id: selection
    type:
      - 'null'
      - boolean
    doc: Perform PC-based selection scan (Galinsky et al. 2016)
    inputBinding:
      position: 101
      prefix: --selection
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    inputBinding:
      position: 101
      prefix: --threads
  - id: tolerance
    type:
      - 'null'
      - float
    doc: Tolerance in update for individual allele frequencies
    inputBinding:
      position: 101
      prefix: --tole
outputs:
  - id: output_prefix
    type:
      - 'null'
      - File
    doc: Prefix output name
    outputBinding:
      glob: $(inputs.output_prefix)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/emu-pca:1.5.0--py310h20b60a1_0
