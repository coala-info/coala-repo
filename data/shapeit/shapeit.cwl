cwlVersion: v1.2
class: CommandLineTool
baseCommand: shapeit
label: shapeit
doc: "Segmented Haplotype Estimation & Imputation Tool\n\nTool homepage: https://github.com/odelaneau/shapeit4"
inputs:
  - id: aligned
    type:
      - 'null'
      - boolean
    doc: Ref allele is aligned on the reference genome
    inputBinding:
      position: 101
      prefix: --aligned
  - id: burn
    type:
      - 'null'
      - int
    doc: Number of burn-in MCMC iterations.
    default: 7
    inputBinding:
      position: 101
      prefix: --burn
  - id: chrX
    type:
      - 'null'
      - boolean
    doc: Unphased genotypes are from chromosome X non autosomal region.
    inputBinding:
      position: 101
      prefix: --chrX
  - id: duohmm
    type:
      - 'null'
      - boolean
    doc: Phase pedigrees using the duoHMM algorithm.
    inputBinding:
      position: 101
      prefix: --duohmm
  - id: effective_size
    type:
      - 'null'
      - int
    doc: Effective size of the population.
    default: 15000
    inputBinding:
      position: 101
      prefix: --effective-size
  - id: exclude_grp
    type:
      - 'null'
      - string
    doc: List of populations to exclude in input files. Works only on the 
      reference panel of haplotypes.
    inputBinding:
      position: 101
      prefix: --exclude-grp
  - id: exclude_ind
    type:
      - 'null'
      - string
    doc: List of samples to exclude in input/output files.
    inputBinding:
      position: 101
      prefix: --exclude-ind
  - id: exclude_snp
    type:
      - 'null'
      - string
    doc: List of positions to exclude in input/output files.
    inputBinding:
      position: 101
      prefix: --exclude-snp
  - id: include_grp
    type:
      - 'null'
      - string
    doc: List of populations to include in input files. Works only on the 
      reference panel of haplotypes.
    inputBinding:
      position: 101
      prefix: --include-grp
  - id: include_ind
    type:
      - 'null'
      - string
    doc: List of samples to include in input/output files.
    inputBinding:
      position: 101
      prefix: --include-ind
  - id: include_snp
    type:
      - 'null'
      - string
    doc: List of positions to include in input/output files.
    inputBinding:
      position: 101
      prefix: --include-snp
  - id: input_bed
    type:
      - 'null'
      - File
    doc: Unphased genotypes in BED/BIM/FAM format.
    inputBinding:
      position: 101
      prefix: --input-bed
  - id: input_copy_states
    type:
      - 'null'
      - string
    doc: To specify who to copy from
    inputBinding:
      position: 101
      prefix: --input-copy-states
  - id: input_from
    type:
      - 'null'
      - int
    doc: First physical position to consider in input files.
    default: 0
    inputBinding:
      position: 101
      prefix: --input-from
  - id: input_gen
    type:
      - 'null'
      - File
    doc: Unphased genotypes in GEN/SAMPLE format.
    inputBinding:
      position: 101
      prefix: --input-gen
  - id: input_init
    type:
      - 'null'
      - File
    doc: Phased haplotypes in HAPS/SAMPLE format used for initialisation.
    inputBinding:
      position: 101
      prefix: --input-init
  - id: input_map
    type:
      - 'null'
      - File
    doc: Genetic map in HapMap format.
    inputBinding:
      position: 101
      prefix: --input-map
  - id: input_ped
    type:
      - 'null'
      - File
    doc: Unphased genotypes in PED/MAP format.
    inputBinding:
      position: 101
      prefix: --input-ped
  - id: input_ref
    type:
      - 'null'
      - File
    doc: Reference set of haplotypes in HAPS/SAMPLE format.
    inputBinding:
      position: 101
      prefix: --input-ref
  - id: input_sex
    type:
      - 'null'
      - File
    doc: Sex of the samples.
    inputBinding:
      position: 101
  - id: input_thr
    type:
      - 'null'
      - float
    doc: Probability threshold used to call genotypes in GEN file.
    default: 0.9
    inputBinding:
      position: 101
      prefix: --input-thr
  - id: input_to
    type:
      - 'null'
      - int
    doc: Last physical position to consider in input file.
    default: 1000000000
    inputBinding:
      position: 101
      prefix: --input-to
  - id: input_vcf
    type:
      - 'null'
      - File
    doc: Unphased genotypes in VCF format.
    inputBinding:
      position: 101
      prefix: --input-vcf
  - id: main
    type:
      - 'null'
      - int
    doc: Number of main MCMC iterations.
    default: 20
    inputBinding:
      position: 101
      prefix: --main
  - id: missing_code
    type:
      - 'null'
      - string
    doc: Missing data character in PED/MAP format.
    default: '0'
    inputBinding:
      position: 101
      prefix: --missing-code
  - id: missing_maf
    type:
      - 'null'
      - boolean
    doc: MAF based initialisation of missing genotypes prior to phasing
    inputBinding:
      position: 101
      prefix: --missing-maf
  - id: model_version1
    type:
      - 'null'
      - boolean
    doc: Use the graphical model to represent the conditioning haplotypes (as in
      SHAPEIT v1).
    inputBinding:
      position: 101
      prefix: --model-version1
  - id: no_mcmc
    type:
      - 'null'
      - boolean
    doc: No MCMC iteration (just phase given the reference panel haplotypes).
    inputBinding:
      position: 101
      prefix: --no-mcmc
  - id: noped
    type:
      - 'null'
      - boolean
    doc: No pedigree information taken into account.
    inputBinding:
      position: 101
      prefix: --noped
  - id: output_from
    type:
      - 'null'
      - int
    doc: First physical position to output.
    default: 0
    inputBinding:
      position: 101
      prefix: --output-from
  - id: output_graph
    type:
      - 'null'
      - File
    doc: Phased haplotype graphs in binary format (v2.2).
    inputBinding:
      position: 101
      prefix: --output-graph
  - id: output_log
    type:
      - 'null'
      - string
    doc: Log file containing a copy of the screen output.
    default: shapeit_date_time_UUID.log
    inputBinding:
      position: 101
      prefix: --output-log
  - id: output_max
    type:
      - 'null'
      - File
    doc: Phased haplotypes in HAPS/SAMPLE format.
    inputBinding:
      position: 101
      prefix: --output-max
  - id: output_to
    type:
      - 'null'
      - int
    doc: Last physical position to output.
    default: 1000000000
    inputBinding:
      position: 101
      prefix: --output-to
  - id: prune
    type:
      - 'null'
      - int
    doc: Number of pruning MCMC iterations.
    default: 8
    inputBinding:
      position: 101
      prefix: --prune
  - id: rho
    type:
      - 'null'
      - float
    doc: Constant recombination rate.
    default: 0.0004
    inputBinding:
      position: 101
      prefix: --rho
  - id: run
    type:
      - 'null'
      - int
    doc: Number of pruning stages
    default: 1
    inputBinding:
      position: 101
      prefix: --run
  - id: seed
    type:
      - 'null'
      - int
    doc: Seed of the random number generator.
    default: 1771980220
    inputBinding:
      position: 101
      prefix: --seed
  - id: states
    type:
      - 'null'
      - int
    doc: Number of hidden states used for phasing (selected using Hamming 
      distance minimisation).
    default: 100
    inputBinding:
      position: 101
      prefix: --states
  - id: states_cov
    type:
      - 'null'
      - int
    doc: Number of hidden states used for phasing (selected using perfect match 
      that maximise coverage of the region).
    default: 0
    inputBinding:
      position: 101
      prefix: --states-cov
  - id: states_pmatch
    type:
      - 'null'
      - int
    doc: Number of hidden states used for phasing (selected using perfect match 
      maximisation).
    default: 0
    inputBinding:
      position: 101
      prefix: --states-pmatch
  - id: states_random
    type:
      - 'null'
      - int
    doc: Number of hidden states used for phasing (selected at random).
    default: 0
    inputBinding:
      position: 101
      prefix: --states-random
  - id: thread
    type:
      - 'null'
      - int
    doc: Number of thread used for phasing.
    default: 1
    inputBinding:
      position: 101
      prefix: --thread
  - id: window
    type:
      - 'null'
      - int
    doc: Mean size of the windows in which conditioning haplotypes are defined.
    default: 2
    inputBinding:
      position: 101
      prefix: --window
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/shapeit:2.r837--h09b0a5c_1
stdout: shapeit.out
