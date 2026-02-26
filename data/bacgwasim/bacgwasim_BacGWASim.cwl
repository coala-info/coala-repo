cwlVersion: v1.2
class: CommandLineTool
baseCommand: BacGWASim
label: bacgwasim_BacGWASim
doc: "Description\n\nTool homepage: https://github.com/Morteza-M-Saber/BacGWASim"
inputs:
  - id: case
    type:
      - 'null'
      - string
    doc: "In case of case-control binary phenotype\nsimulation, number of case and
      control samples\nmust be defined by 'case' and 'control'\nparameters"
    inputBinding:
      position: 101
      prefix: --case
  - id: causal_ld_max
    type:
      - 'null'
      - float
    doc: "Maximum permitted R2 score between pairs of\ncausal markers in window size
      of 1000 candidate\ncausal markers meeting --causal-maf-min and\n--causal-maf-max
      thresholds"
    inputBinding:
      position: 101
      prefix: --causal-ld-max
  - id: causal_maf_max
    type:
      - 'null'
      - float
    doc: "Maximum Minor Allele Frequency (MAF) of causal\nmarkers"
    inputBinding:
      position: 101
      prefix: --causal-maf-max
  - id: causal_maf_min
    type:
      - 'null'
      - float
    doc: "Minimum Minor Allele Frequency (MAF) of causal\nmarkers"
    inputBinding:
      position: 101
      prefix: --causal-maf-min
  - id: config
    type:
      - 'null'
      - File
    doc: Path to a config file
    inputBinding:
      position: 101
      prefix: --config
  - id: control
    type:
      - 'null'
      - string
    doc: "In case of case-control binary phenotype\nsimulation, number of case and
      control samples\nmust be defined by 'case' and 'control'\nparameters"
    inputBinding:
      position: 101
      prefix: --control
  - id: cores
    type:
      - 'null'
      - int
    doc: Number of cores available for computations
    inputBinding:
      position: 101
      prefix: --cores
  - id: disease_prevalence
    type:
      - 'null'
      - float
    doc: Prevalence of phenotype
    inputBinding:
      position: 101
      prefix: --disease-prevalence
  - id: effect_size_odr
    type:
      - 'null'
      - type: array
        items: string
    doc: "Effect sizes of causal markers (.odds ratios)\n(comma separated, must be
      a multiple of --num-\ncausal-var)"
    inputBinding:
      position: 101
      prefix: --effect-size-odr
  - id: genome_length
    type:
      - 'null'
      - int
    doc: Length of the genome (bp)
    inputBinding:
      position: 101
      prefix: --genome-length
  - id: heritability
    type:
      - 'null'
      - float
    doc: Heritability of phenotype
    inputBinding:
      position: 101
      prefix: --heritability
  - id: latency_wait
    type:
      - 'null'
      - int
    doc: "Time to wait (in sec) after a job to ensure that\nall files are present"
    inputBinding:
      position: 101
      prefix: --latency-wait
  - id: ld_maf
    type:
      - 'null'
      - float
    doc: "Minimum Minor Allele Frequency of markers for LD\nplotting (Lower this values,
      it is more\ndifficult to estimate accurate r2 values between\npairs of markers
      leading to more noisy plot)"
    inputBinding:
      position: 101
      prefix: --ld-maf
  - id: maf
    type:
      - 'null'
      - float
    doc: "Minor allele frequency threshold of rare alleles\nto be discarded"
    inputBinding:
      position: 101
      prefix: --maf
  - id: mutation_rate
    type:
      - 'null'
      - float
    doc: Mutation rate
    inputBinding:
      position: 101
      prefix: --mutation-rate
  - id: num_causal_var
    type:
      - 'null'
      - int
    doc: Number of causal markers
    inputBinding:
      position: 101
      prefix: --num-causal-var
  - id: num_species
    type:
      - 'null'
      - int
    doc: Number of samples in the simulated population
    inputBinding:
      position: 101
      prefix: --num-species
  - id: num_var
    type:
      - 'null'
      - int
    doc: "Number of simulated variants. If '-1', variant\nnumber will be solely a
      function of mutation\nrate"
    default: -1
    inputBinding:
      position: 101
      prefix: --num-var
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Path to the output directory
    inputBinding:
      position: 101
      prefix: --output-dir
  - id: phen_replication
    type:
      - 'null'
      - int
    doc: Number of phenotype replication sets
    inputBinding:
      position: 101
      prefix: --phen-replication
  - id: phen_type
    type:
      - 'null'
      - string
    doc: "Type of simulated phenotype. 'cc':binary case-\ncontrol, 'quant': quantitative"
    inputBinding:
      position: 101
      prefix: --phen-type
  - id: plot_ld
    type:
      - 'null'
      - boolean
    doc: Generate the LD plot
    inputBinding:
      position: 101
      prefix: --plot-ld
  - id: random_seed
    type:
      - 'null'
      - int
    doc: Random seed for reproducibility of results
    inputBinding:
      position: 101
      prefix: --random-seed
  - id: recomb_rate
    type:
      - 'null'
      - float
    doc: Recombination rate
    inputBinding:
      position: 101
      prefix: --recomb-rate
  - id: simvis_dpi
    type:
      - 'null'
      - int
    doc: Set the DPI for the simVis plot
    inputBinding:
      position: 101
      prefix: --simvis-dpi
  - id: snp_limit
    type:
      - 'null'
      - int
    doc: "Number of SNPs randomly selected for plotting\nlinkage map (Increasing this
      number will\nsignificantly increase computation time)"
    inputBinding:
      position: 101
      prefix: --snp-limit
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bacgwasim:2.1.1--pyhdfd78af_0
stdout: bacgwasim_BacGWASim.out
