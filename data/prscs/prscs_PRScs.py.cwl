cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - python
  - PRScs.py
label: prscs_PRScs.py
doc: "PRS-CS: a polygenic prediction method that infers posterior SNP effect sizes
  under continuous shrinkage (CS) priors using GWAS summary statistics and an external
  LD reference panel.\n\nTool homepage: https://github.com/getian107/PRScs"
inputs:
  - id: a
    type:
      - 'null'
      - float
    doc: Parameter a in the gamma-gamma prior
    inputBinding:
      position: 101
      prefix: --a
  - id: b
    type:
      - 'null'
      - float
    doc: Parameter b in the gamma-gamma prior
    inputBinding:
      position: 101
      prefix: --b
  - id: bim_prefix
    type: string
    doc: Prefix of the validation .bim file
    inputBinding:
      position: 101
      prefix: --bim_prefix
  - id: chrom
    type:
      - 'null'
      - string
    doc: Chromosome(s) to be analyzed
    inputBinding:
      position: 101
      prefix: --chrom
  - id: n_burnin
    type:
      - 'null'
      - int
    doc: Number of burn-in iterations
    inputBinding:
      position: 101
      prefix: --n_burnin
  - id: n_gwas
    type: int
    doc: GWAS sample size
    inputBinding:
      position: 101
      prefix: --n_gwas
  - id: n_iter
    type:
      - 'null'
      - int
    doc: Number of MCMC iterations
    inputBinding:
      position: 101
      prefix: --n_iter
  - id: phi
    type:
      - 'null'
      - float
    doc: Global shrinkage parameter phi
    inputBinding:
      position: 101
      prefix: --phi
  - id: ref_dir
    type: Directory
    doc: Path to the reference panel directory
    inputBinding:
      position: 101
      prefix: --ref_dir
  - id: seed
    type:
      - 'null'
      - int
    doc: Random seed
    inputBinding:
      position: 101
      prefix: --seed
  - id: sst_file
    type: File
    doc: GWAS summary statistics file
    inputBinding:
      position: 101
      prefix: --sst_file
  - id: thin
    type:
      - 'null'
      - int
    doc: MCMC thinning factor
    inputBinding:
      position: 101
      prefix: --thin
  - id: write_psi
    type:
      - 'null'
      - boolean
    doc: Whether to write out posterior shrinkage parameters
    inputBinding:
      position: 101
      prefix: --write_psi
outputs:
  - id: out_dir
    type: Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.out_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/prscs:1.1.0--hdfd78af_0
