cwlVersion: v1.2
class: CommandLineTool
baseCommand: gmer_caller
label: genometester_gmer_caller
doc: "No input file specified\n\nTool homepage: https://github.com/bioinfo-ut/GenomeTester4"
inputs:
  - id: counts_file
    type: File
    doc: File containing counts
    inputBinding:
      position: 1
  - id: alternatives
    type:
      - 'null'
      - boolean
    doc: Print probabilities of all alternative genotypes
    inputBinding:
      position: 102
      prefix: --alternatives
  - id: coverage
    type:
      - 'null'
      - float
    doc: Average coverage of reads
    inputBinding:
      position: 102
      prefix: --coverage
  - id: debug_level
    type:
      - 'null'
      - boolean
    doc: increase debug level
    inputBinding:
      position: 102
      prefix: -D
  - id: header
    type:
      - 'null'
      - boolean
    doc: Print table header
    inputBinding:
      position: 102
      prefix: --header
  - id: info
    type:
      - 'null'
      - boolean
    doc: Print information about individual
    inputBinding:
      position: 102
      prefix: --info
  - id: model
    type:
      - 'null'
      - string
    doc: Model type (full, diploid, haploid)
    inputBinding:
      position: 102
      prefix: --model
  - id: no_genotypes
    type:
      - 'null'
      - boolean
    doc: Print only summary information, not actual genotypes
    inputBinding:
      position: 102
      prefix: --no_genotypes
  - id: non_canonical
    type:
      - 'null'
      - boolean
    doc: Output non-canonical genotypes
    inputBinding:
      position: 102
      prefix: --non_canonical
  - id: num_threads
    type:
      - 'null'
      - int
    doc: Use NUM threads (min 1, max 32)
    inputBinding:
      position: 102
      prefix: --num_threads
  - id: params
    type:
      - 'null'
      - string
    doc: Model parameters (error, p0, p1, p2, coverage, size, size2)
    inputBinding:
      position: 102
      prefix: --params
  - id: prob_cutoff
    type:
      - 'null'
      - float
    doc: probability cutoff for calling genotype
    inputBinding:
      position: 102
      prefix: --prob_cutoff
  - id: runs
    type:
      - 'null'
      - int
    doc: Perform NUMBER runs of model training (use 0 for no training)
    inputBinding:
      position: 102
      prefix: --runs
  - id: training_size
    type:
      - 'null'
      - int
    doc: Use NUM markers for training
    inputBinding:
      position: 102
      prefix: --training_size
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/genometester:v4.0git20180508.a9c14a6dfsg-1-deb_cv1
stdout: genometester_gmer_caller.out
