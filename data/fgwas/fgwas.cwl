cwlVersion: v1.2
class: CommandLineTool
baseCommand: fgwas
label: fgwas
doc: "fgwas v. 0.3.6\nby Joe Pickrell (jkpickrell@nygenome.org)\n\nTool homepage:
  https://github.com/joepickrell/fgwas"
inputs:
  - id: annotations
    type:
      - 'null'
      - string
    doc: which annotation(s) to use. Separate multiple annotations with plus 
      signs
    inputBinding:
      position: 101
      prefix: -w
  - id: bed_file
    type:
      - 'null'
      - File
    doc: read block positions from a .bed file
    inputBinding:
      position: 101
      prefix: -bed
  - id: block_size
    type:
      - 'null'
      - int
    doc: block size in number of SNPs
    default: 5000
    inputBinding:
      position: 101
      prefix: -k
  - id: case_control
    type:
      - 'null'
      - boolean
    doc: this is a case-control study, which implies a different input file 
      format
    inputBinding:
      position: 101
      prefix: -cc
  - id: conditional_effect
    type:
      - 'null'
      - string
    doc: estimate the effect size of an annotation conditional on the others in 
      the model
    inputBinding:
      position: 101
      prefix: -cond
  - id: cross_validation
    type:
      - 'null'
      - boolean
    doc: do 10-fold cross-validation
    inputBinding:
      position: 101
      prefix: -xv
  - id: density_model
    type:
      - 'null'
      - type: array
        items: string
    doc: model segment probability according to quantiles of an annotation
    inputBinding:
      position: 101
      prefix: -dens
  - id: distance_models
    type:
      - 'null'
      - type: array
        items: string
    doc: the name of the distance annotation(s) and the file(s) containing the 
      distance model(s)
    inputBinding:
      position: 101
      prefix: -dists
  - id: fine_mapping
    type:
      - 'null'
      - boolean
    doc: this is a fine mapping study, which implies a different input file 
      format
    inputBinding:
      position: 101
      prefix: -fine
  - id: input_file
    type:
      - 'null'
      - File
    doc: input file w/ Z-scores
    inputBinding:
      position: 101
      prefix: -i
  - id: only_optimization
    type:
      - 'null'
      - boolean
    doc: only do optimization under penalized likelihood
    inputBinding:
      position: 101
      prefix: -onlyp
  - id: output_stem
    type:
      - 'null'
      - string
    doc: stem for names of output files
    inputBinding:
      position: 101
      prefix: -o
  - id: penalty
    type:
      - 'null'
      - float
    doc: penalty on sum of squared lambdas, only relevant for -print
    default: 0.2
    inputBinding:
      position: 101
      prefix: -p
  - id: print_per_snp
    type:
      - 'null'
      - boolean
    doc: print the per-SNP output
    inputBinding:
      position: 101
      prefix: -print
  - id: prior_variance
    type:
      - 'null'
      - type: array
        items: float
    doc: variance of prior on normalized effect size. To average priors, 
      separate with commas
    default:
      - 0.01
      - 0.1
      - 0.5
    inputBinding:
      position: 101
      prefix: -v
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fgwas:0.3.6--ha172671_9
stdout: fgwas.out
