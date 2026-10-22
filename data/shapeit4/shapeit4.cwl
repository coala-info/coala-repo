cwlVersion: v1.2
class: CommandLineTool
baseCommand: shapeit4
label: shapeit4
doc: "SHAPEIT4 is a fast and accurate method for estimation of haplotypes (phasing)
  from genotype data.\n\nTool homepage: https://odelaneau.github.io/shapeit4/"
inputs:
  - id: input
    type: File
    secondaryFiles:
      - pattern: .csi
        required: false
      - pattern: .tbi
        required: false
    doc: Input genotypes to be phased in VCF/BCF format
    inputBinding:
      position: 101
      prefix: --input
  - id: map
    type: File
    doc: Genetic map in the format used by SHAPEIT
    inputBinding:
      position: 101
      prefix: --map
  - id: mcmc_iterations
    type:
      - 'null'
      - string
    doc: MCMC strategy to be used
    inputBinding:
      position: 101
      prefix: --mcmc-iterations
  - id: pbwt_depth
    type:
      - 'null'
      - int
    doc: Number of neighbors to store in the PBWT
    inputBinding:
      position: 101
      prefix: --pbwt-depth
  - id: reference
    type:
      - 'null'
      - File
    secondaryFiles:
      - pattern: .csi
        required: false
      - pattern: .tbi
        required: false
    doc: Reference panel of haplotypes in VCF/BCF format
    inputBinding:
      position: 101
      prefix: --reference
  - id: region
    type: string
    doc: Target region to be phased (e.g. chr20:1000000-2000000)
    inputBinding:
      position: 101
      prefix: --region
  - id: scaffold
    type:
      - 'null'
      - File
    secondaryFiles:
      - pattern: .csi
        required: false
      - pattern: .tbi
        required: false
    doc: Scaffold of haplotypes (e.g. from SNP array) in VCF/BCF format
    inputBinding:
      position: 101
      prefix: --scaffold
  - id: thread
    type:
      - 'null'
      - int
    doc: Number of threads to use
    inputBinding:
      position: 101
      prefix: --thread
  - id: window
    type:
      - 'null'
      - float
    doc: Size of the window in Mb in which conditioning haplotypes are selected
    inputBinding:
      position: 101
      prefix: --window
  - id: log_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `log_path`
    inputBinding:
      position: 102
      prefix: --log
  - id: output_path
    type: string
    doc: Output or path parameter `output_path`
    inputBinding:
      position: 103
      prefix: --output
  - id: seed
    type: ['null', int]
    doc: Seed of the random number generator
    inputBinding:
      position: 101
      prefix: --seed
  - id: use_ps
    type: ['null', string]
    doc: Informs phasing using PS field from read based phasing
    inputBinding:
      position: 101
      prefix: --use-PS
  - id: sequencing
    type: ['null', boolean]
    doc: Default parameter setting for sequencing data (this divides by 50 the default value of --pbwt-modulo)
    inputBinding:
      position: 101
      prefix: --sequencing
  - id: mcmc_prune
    type: ['null', float]
    doc: Pruning threshold for genotype graphs
    inputBinding:
      position: 101
      prefix: --mcmc-prune
  - id: pbwt_modulo
    type: ['null', float]
    doc: Storage frequency of PBWT indexes in cM
    inputBinding:
      position: 101
      prefix: --pbwt-modulo
  - id: pbwt_mac
    type: ['null', int]
    doc: Minimal Minor Allele Count at which PBWT is evaluated
    inputBinding:
      position: 101
      prefix: --pbwt-mac
  - id: pbwt_mdr
    type: ['null', float]
    doc: Maximal Missing Data Rate at which PBWT is evaluated
    inputBinding:
      position: 101
      prefix: --pbwt-mdr
  - id: pbwt_disable_init
    type: ['null', boolean]
    doc: Disable initialization by PBWT sweep
    inputBinding:
      position: 101
      prefix: --pbwt-disable-init
  - id: effective_size
    type: ['null', int]
    doc: Effective size of the population
    inputBinding:
      position: 101
      prefix: --effective-size
  - id: bingraph_path
    type: ['null', string]
    doc: Phased haplotypes in BIN format (to sample multiple likely haplotype configurations per sample)
    inputBinding:
      position: 104
      prefix: --bingraph
outputs:
  - id: output
    type: File
    doc: Phased haplotypes in VCF/BCF format
    outputBinding:
      glob: $(inputs.output_path)
  - id: bingraph
    type: ['null', File]
    doc: Phased haplotypes in BIN format
    outputBinding:
      glob: $(inputs.bingraph_path)
  - id: log
    type:
      - 'null'
      - File
    doc: Log file
    outputBinding:
      glob: $(inputs.log_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/shapeit4:4.2.2--h6959450_5
