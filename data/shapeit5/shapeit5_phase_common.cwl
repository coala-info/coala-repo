cwlVersion: v1.2
class: CommandLineTool
baseCommand: [SHAPEIT5_phase_common]
label: shapeit5_phase_common
doc: "Jointly phase multiple common markers (SHAPEIT5 phase_common).\n\nTool homepage: https://odelaneau.github.io/shapeit5/"
inputs:
  - id: input
    type: File
    secondaryFiles:
      - pattern: .csi
        required: false
      - pattern: .tbi
        required: false
    doc: Genotypes to be phased in VCF/BCF format
    inputBinding:
      position: 101
      prefix: --input
  - id: map
    type: ['null', File]
    doc: Genetic map
    inputBinding:
      position: 101
      prefix: --map
  - id: region
    type: string
    doc: Target region
    inputBinding:
      position: 101
      prefix: --region
  - id: reference
    type: ['null', File]
    secondaryFiles:
      - pattern: .csi
        required: false
      - pattern: .tbi
        required: false
    doc: Reference panel of haplotypes in VCF/BCF format
    inputBinding:
      position: 101
      prefix: --reference
  - id: scaffold
    type: ['null', File]
    secondaryFiles:
      - pattern: .csi
        required: false
      - pattern: .tbi
        required: false
    doc: Scaffold of haplotypes in VCF/BCF format
    inputBinding:
      position: 101
      prefix: --scaffold
  - id: pedigree
    type: ['null', File]
    doc: Pedigree information (kid father mother)
    inputBinding:
      position: 101
      prefix: --pedigree
  - id: haploids
    type: ['null', File]
    doc: List of haploid samples (e.g. chrX for males). One sample ID per line.
    inputBinding:
      position: 101
      prefix: --haploids
  - id: seed
    type: ['null', int]
    doc: Seed of the random number generator
    inputBinding:
      position: 101
      prefix: --seed
  - id: thread
    type: ['null', int]
    doc: Number of thread used
    inputBinding:
      position: 101
      prefix: --thread
  - id: progress
    type: ['null', boolean]
    doc: Verbose progress percentages on screen for longer tasks
    inputBinding:
      position: 101
      prefix: --progress
  - id: mcmc_iterations
    type: ['null', string]
    doc: Iteration scheme of the MCMC
    inputBinding:
      position: 101
      prefix: --mcmc-iterations
  - id: mcmc_prune
    type: ['null', float]
    doc: Pruning threshold for genotype graphs
    inputBinding:
      position: 101
      prefix: --mcmc-prune
  - id: mcmc_noinit
    type: ['null', boolean]
    doc: Disable phasing initialization by PBWT sweep
    inputBinding:
      position: 101
      prefix: --mcmc-noinit
  - id: pbwt_modulo
    type: ['null', float]
    doc: Storage frequency of PBWT indexes in cM
    inputBinding:
      position: 101
      prefix: --pbwt-modulo
  - id: pbwt_depth
    type: ['null', int]
    doc: Depth of PBWT indexes to condition on
    inputBinding:
      position: 101
      prefix: --pbwt-depth
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
  - id: pbwt_window
    type: ['null', float]
    doc: Run PBWT selection in windows of this size (cM)
    inputBinding:
      position: 101
      prefix: --pbwt-window
  - id: hmm_window
    type: ['null', float]
    doc: Minimal size of the phasing window in cM
    inputBinding:
      position: 101
      prefix: --hmm-window
  - id: hmm_ne
    type: ['null', int]
    doc: Effective size of the population
    inputBinding:
      position: 101
      prefix: --hmm-ne
  - id: filter_snp
    type: ['null', boolean]
    doc: Only consider SNPs
    inputBinding:
      position: 101
      prefix: --filter-snp
  - id: filter_maf
    type: ['null', float]
    doc: Only retains variants with a MAF above the specified value, requires AC/AN tags
    inputBinding:
      position: 101
      prefix: --filter-maf
  - id: output_format
    type: ['null', string]
    doc: Output file format
    inputBinding:
      position: 101
      prefix: --output-format
  - id: output_path
    type: string
    doc: Phased haplotypes output file
    inputBinding:
      position: 102
      prefix: --output
  - id: log_path
    type: ['null', string]
    doc: Log file
    inputBinding:
      position: 103
      prefix: --log
outputs:
  - id: output
    type: File
    doc: Phased haplotypes output file
    outputBinding:
      glob: $(inputs.output_path)
    secondaryFiles:
      - pattern: .csi
        required: false
  - id: log
    type: ['null', File]
    doc: Log file
    outputBinding:
      glob: $(inputs.log_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/shapeit5:5.1.1--h34261f4_2
