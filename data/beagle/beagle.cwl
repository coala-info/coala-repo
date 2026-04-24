cwlVersion: v1.2
class: CommandLineTool
baseCommand: java -jar beagle.27Feb25.75f.jar
label: beagle
doc: "BEAGLE 5.5 is a software package that performs genotype imputation and phasing.\n\
  \nTool homepage: https://github.com/yampelo/beagle"
inputs:
  - id: ap
    type:
      - 'null'
      - boolean
    doc: print posterior allele probabilities
    inputBinding:
      position: 101
      prefix: --ap
  - id: burnin
    type:
      - 'null'
      - int
    doc: max burnin iterations
    inputBinding:
      position: 101
      prefix: --burnin
  - id: chrom
    type:
      - 'null'
      - string
    doc: '[chrom] or [chrom]:[start]-[end]'
    inputBinding:
      position: 101
      prefix: --chrom
  - id: cluster
    type:
      - 'null'
      - float
    doc: max cM in a marker cluster
    inputBinding:
      position: 101
      prefix: --cluster
  - id: em
    type:
      - 'null'
      - boolean
    doc: estimate ne and err parameters (true/false)
    inputBinding:
      position: 101
      prefix: --em
  - id: err
    type:
      - 'null'
      - float
    doc: allele mismatch probability
    inputBinding:
      position: 101
      prefix: --err
  - id: excludemarkers
    type:
      - 'null'
      - File
    doc: file with 1 marker ID per line
    inputBinding:
      position: 101
      prefix: --excludemarkers
  - id: excludesamples
    type:
      - 'null'
      - File
    doc: file with 1 sample ID per line
    inputBinding:
      position: 101
      prefix: --excludesamples
  - id: gp
    type:
      - 'null'
      - boolean
    doc: print posterior genotype probabilities
    inputBinding:
      position: 101
      prefix: --gp
  - id: gt
    type: File
    doc: VCF file with GT FORMAT field
    inputBinding:
      position: 101
      prefix: --gt
  - id: imp_states
    type:
      - 'null'
      - int
    doc: model states for imputation
    inputBinding:
      position: 101
      prefix: --imp-states
  - id: impute
    type:
      - 'null'
      - boolean
    doc: impute ungenotyped markers (true/false)
    inputBinding:
      position: 101
      prefix: --impute
  - id: iterations
    type:
      - 'null'
      - int
    doc: phasing iterations
    inputBinding:
      position: 101
      prefix: --iterations
  - id: map
    type:
      - 'null'
      - File
    doc: PLINK map file with cM units
    inputBinding:
      position: 101
      prefix: --map
  - id: ne
    type:
      - 'null'
      - int
    doc: effective population size
    inputBinding:
      position: 101
      prefix: --ne
  - id: nthreads
    type:
      - 'null'
      - int
    doc: number of threads
    inputBinding:
      position: 101
      prefix: --nthreads
  - id: out
    type: string
    doc: output file prefix
    inputBinding:
      position: 101
      prefix: --out
  - id: overlap
    type:
      - 'null'
      - float
    doc: window overlap in cM
    inputBinding:
      position: 101
      prefix: --overlap
  - id: phase_states
    type:
      - 'null'
      - int
    doc: model states for phasing
    inputBinding:
      position: 101
      prefix: --phase-states
  - id: ref
    type:
      - 'null'
      - File
    doc: bref3 or VCF file with phased genotypes
    inputBinding:
      position: 101
      prefix: --ref
  - id: seed
    type:
      - 'null'
      - int
    doc: random seed
    inputBinding:
      position: 101
      prefix: --seed
  - id: window
    type:
      - 'null'
      - float
    doc: window length in cM
    inputBinding:
      position: 101
      prefix: --window
  - id: window_markers
    type:
      - 'null'
      - int
    doc: maximum markers per window
    inputBinding:
      position: 101
      prefix: --window-markers
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/beagle:5.5_27Feb25.75f--hdfd78af_0
stdout: beagle.out
