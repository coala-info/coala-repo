cwlVersion: v1.2
class: CommandLineTool
baseCommand: swiftlink
label: swiftlink
doc: "SwiftLink is a tool for linkage analysis and ELOD calculation.\n\nTool homepage:
  https://github.com/ajm/swiftlink"
inputs:
  - id: affectedonly
    type:
      - 'null'
      - boolean
    doc: Analyze only affected individuals
    inputBinding:
      position: 101
      prefix: --affectedonly
  - id: burnin
    type:
      - 'null'
      - int
    doc: Number of MCMC burn-in iterations
    default: 50000
    inputBinding:
      position: 101
      prefix: --burnin
  - id: cores
    type:
      - 'null'
      - int
    doc: Number of CPU cores to use
    default: 1
    inputBinding:
      position: 101
      prefix: --cores
  - id: datfile
    type: File
    doc: Dat file
    inputBinding:
      position: 101
      prefix: --dat
  - id: elod
    type:
      - 'null'
      - boolean
    doc: Calculate ELOD scores
    inputBinding:
      position: 101
      prefix: --elod
  - id: elod_flag
    type:
      - 'null'
      - boolean
    doc: Enable ELOD calculation
    inputBinding:
      position: 101
      prefix: --elod
  - id: frequency
    type:
      - 'null'
      - float
    doc: ELOD frequency threshold
    default: '1.0e-04'
    inputBinding:
      position: 101
      prefix: --frequency
  - id: gpu
    type:
      - 'null'
      - boolean
    doc: Enable GPU acceleration (if available)
    inputBinding:
      position: 101
      prefix: --gpu
  - id: iterations
    type:
      - 'null'
      - int
    doc: Number of MCMC iterations
    default: 50000
    inputBinding:
      position: 101
      prefix: --iterations
  - id: lodscores
    type:
      - 'null'
      - int
    doc: Number of LOD scores to calculate
    default: 5
    inputBinding:
      position: 101
      prefix: --lodscores
  - id: lsamplerprobability
    type:
      - 'null'
      - float
    doc: L-sampler probability
    default: 0.5
    inputBinding:
      position: 101
      prefix: --lsamplerprobability
  - id: mapfile
    type: File
    doc: Map file
    inputBinding:
      position: 101
      prefix: --map
  - id: pedfile
    type: File
    doc: Pedigree file
    inputBinding:
      position: 101
      prefix: --pedigree
  - id: peelseqiter
    type:
      - 'null'
      - int
    doc: Number of iterations for Peel sequence
    default: 1000000
    inputBinding:
      position: 101
      prefix: --peelseqiter
  - id: penetrance
    type:
      - 'null'
      - type: array
        items: float
    doc: ELOD penetrance values (three floats)
    default:
      - 0.0
      - 0.0
      - 1.0
    inputBinding:
      position: 101
      prefix: --penetrance
  - id: randomseeds
    type:
      - 'null'
      - File
    doc: File containing random seeds
    inputBinding:
      position: 101
      prefix: --randomseeds
  - id: replicates
    type:
      - 'null'
      - int
    doc: Number of ELOD replicates
    default: 1000000
    inputBinding:
      position: 101
      prefix: --replicates
  - id: runs
    type:
      - 'null'
      - int
    doc: Number of MCMC runs
    default: 1
    inputBinding:
      position: 101
      prefix: --runs
  - id: scoringperiod
    type:
      - 'null'
      - int
    doc: Scoring period for MCMC
    default: 10
    inputBinding:
      position: 101
      prefix: --scoringperiod
  - id: separation
    type:
      - 'null'
      - float
    doc: ELOD separation threshold
    default: 0.05
    inputBinding:
      position: 101
      prefix: --separation
  - id: sequentialimputation
    type:
      - 'null'
      - int
    doc: Sequential imputation interval
    default: 1000
    inputBinding:
      position: 101
      prefix: --sequentialimputation
  - id: sexlinked
    type:
      - 'null'
      - boolean
    doc: Consider sex-linked inheritance
    inputBinding:
      position: 101
      prefix: --sexlinked
  - id: trace
    type:
      - 'null'
      - boolean
    doc: Enable MCMC trace
    inputBinding:
      position: 101
      prefix: --trace
  - id: traceprefix
    type:
      - 'null'
      - string
    doc: Prefix for MCMC trace files
    default: trace
    inputBinding:
      position: 101
      prefix: --traceprefix
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file name
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/swiftlink:1.0--1
