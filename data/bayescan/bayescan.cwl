cwlVersion: v1.2
class: CommandLineTool
baseCommand: bayescan2
label: bayescan
doc: "BayeScan is a tool for detecting natural selection from population genetic data
  using Bayesian model selection.\n\nTool homepage: https://github.com/mfoll/BayeScan"
inputs:
  - id: input_file
    type: File
    doc: Name of the genotypes data input file
    inputBinding:
      position: 1
  - id: discard_loci
    type:
      - 'null'
      - File
    doc: Optional input file containing list of loci to discard
    inputBinding:
      position: 102
      prefix: -d
  - id: snp
    type:
      - 'null'
      - boolean
    doc: Use SNP genotypes matrix
    inputBinding:
      position: 102
      prefix: -snp
  - id: fstat
    type:
      - 'null'
      - boolean
    doc: Only estimate F-stats (no selection)
    inputBinding:
      position: 102
      prefix: -fstat
  - id: iterations
    type:
      - 'null'
      - int
    doc: Number of outputted iterations, default is 5000
    inputBinding:
      position: 102
      prefix: -n
  - id: thinning_interval
    type:
      - 'null'
      - int
    doc: Thinning interval size, default is 10
    inputBinding:
      position: 102
      prefix: -thin
  - id: nb_pilot_runs
    type:
      - 'null'
      - int
    doc: Number of pilot runs, default is 20
    inputBinding:
      position: 102
      prefix: -nbp
  - id: pilot_length
    type:
      - 'null'
      - int
    doc: Length of pilot runs, default is 5000
    inputBinding:
      position: 102
      prefix: -pilot
  - id: burn_in
    type:
      - 'null'
      - int
    doc: Burn-in length, default is 50000
    inputBinding:
      position: 102
      prefix: -burn
  - id: prior_odds
    type:
      - 'null'
      - float
    doc: Prior odds for the neutral model, default is 10
    inputBinding:
      position: 102
      prefix: -pr_odds
  - id: lb_fis
    type:
      - 'null'
      - float
    doc: Lower bound for uniform prior on Fis (dominant data), default is 0
    inputBinding:
      position: 102
      prefix: -lb_fis
  - id: hb_fis
    type:
      - 'null'
      - float
    doc: Higher bound for uniform prior on Fis (dominant data), default is 1
    inputBinding:
      position: 102
      prefix: -hb_fis
  - id: beta_fis
    type:
      - 'null'
      - boolean
    doc: Optional beta prior for Fis (dominant data, m_fis and sd_fis need to be
      set)
    inputBinding:
      position: 102
      prefix: -beta_fis
  - id: m_fis
    type:
      - 'null'
      - float
    doc: Optional mean for beta prior on Fis (dominant data with -beta_fis)
    inputBinding:
      position: 102
      prefix: -m_fis
  - id: sd_fis
    type:
      - 'null'
      - float
    doc: Optional std. deviation for beta prior on Fis (dominant data with -beta_fis)
    inputBinding:
      position: 102
      prefix: -sd_fis
  - id: aflp_pc
    type:
      - 'null'
      - float
    doc: Threshold for the recessive genotype as a fraction of maximum band intensity,
      default is 0.1
    inputBinding:
      position: 102
      prefix: -aflp_pc
  - id: out_pilot
    type:
      - 'null'
      - boolean
    doc: Optional output file for pilot runs
    inputBinding:
      position: 102
      prefix: -out_pilot
  - id: out_freq
    type:
      - 'null'
      - boolean
    doc: Optional output file for allele frequencies
    inputBinding:
      position: 102
      prefix: -out_freq
  - id: output_prefix
    type: string
    default: bayescan
    doc: Output file prefix, default is input file without the extension
    inputBinding:
      position: 102
      prefix: -o
outputs:
  - id: output_files
    type:
      type: array
      items: File
    doc: Output files written with the prefix (.sel, _fst.txt, _Verif.txt, _AccRte.txt,
      _prop.txt, _freq.txt)
    outputBinding:
      glob: $(inputs.output_prefix)*
  - id: log
    type: stdout
    doc: Progress log
arguments:
  - position: 101
    prefix: -od
    valueFrom: .
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bayescan:2.0.1--h9948957_7
stdout: stdout_log.txt
