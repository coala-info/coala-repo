cwlVersion: v1.2
class: CommandLineTool
baseCommand: swiftlink
label: swiftlink
doc: "SwiftLink performs multipoint parametric linkage analysis with parallel MCMC, and ELOD calculation.\n\nTool homepage: https://github.com/ajm/swiftlink"
inputs:
  - id: pedfile
    type: File
    doc: Pedigree file in LINKAGE format
    inputBinding:
      position: 1
      prefix: --pedigree
  - id: mapfile
    type: ['null', File]
    doc: Map file (required unless --elod is used)
    inputBinding:
      position: 1
      prefix: --map
  - id: datfile
    type: ['null', File]
    doc: Locus data file (required unless --elod is used)
    inputBinding:
      position: 1
      prefix: --dat
  - id: output_file_path
    type: ['null', string]
    doc: Output file name (default swiftlink.out)
    default: swiftlink.out
    inputBinding:
      position: 1
      prefix: --output
  - id: iterations
    type: ['null', int]
    doc: Number of MCMC iterations (default 50000)
    inputBinding:
      position: 1
      prefix: --iterations
  - id: burnin
    type: ['null', int]
    doc: Number of MCMC burn-in iterations (default 50000)
    inputBinding:
      position: 1
      prefix: --burnin
  - id: sequentialimputation
    type: ['null', int]
    doc: Sequential imputation interval (default 1000)
    inputBinding:
      position: 1
      prefix: --sequentialimputation
  - id: scoringperiod
    type: ['null', int]
    doc: Scoring period for MCMC (default 10)
    inputBinding:
      position: 1
      prefix: --scoringperiod
  - id: lsamplerprobability
    type: ['null', float]
    doc: L-sampler probability (default 0.5)
    inputBinding:
      position: 1
      prefix: --lsamplerprobability
  - id: lodscores
    type: ['null', int]
    doc: Number of LOD scores to calculate (default 5)
    inputBinding:
      position: 1
      prefix: --lodscores
  - id: runs
    type: ['null', int]
    doc: Number of MCMC runs (default 1)
    inputBinding:
      position: 1
      prefix: --runs
  - id: trace
    type: ['null', boolean]
    doc: Enable MCMC trace
    inputBinding:
      position: 1
      prefix: --trace
  - id: traceprefix
    type: ['null', string]
    doc: Prefix for MCMC trace files (default trace)
    inputBinding:
      position: 1
      prefix: --traceprefix
  - id: elod
    type: ['null', boolean]
    doc: Calculate ELOD scores
    inputBinding:
      position: 1
      prefix: --elod
  - id: frequency
    type: ['null', float]
    doc: ELOD frequency (default 1.0e-04)
    inputBinding:
      position: 1
      prefix: --frequency
  - id: separation
    type: ['null', float]
    doc: ELOD separation (default 0.0500)
    inputBinding:
      position: 1
      prefix: --separation
  - id: penetrance
    type:
      - 'null'
      - type: array
        items: float
    doc: ELOD penetrance values, three floats (default 0.00,0.00,1.00)
    inputBinding:
      position: 1
      prefix: --penetrance
      itemSeparator: ','
  - id: replicates
    type: ['null', int]
    doc: Number of ELOD replicates (default 1000000)
    inputBinding:
      position: 1
      prefix: --replicates
  - id: cores
    type: ['null', int]
    doc: Number of CPU cores to use (default 1)
    inputBinding:
      position: 1
      prefix: --cores
  - id: gpu
    type: ['null', boolean]
    doc: Use the GPU (unavailable when compiled without CUDA)
    inputBinding:
      position: 1
      prefix: --gpu
  - id: sexlinked
    type: ['null', boolean]
    doc: Consider sex-linked inheritance
    inputBinding:
      position: 1
      prefix: --sexlinked
  - id: affectedonly
    type: ['null', boolean]
    doc: Analyze only affected individuals
    inputBinding:
      position: 1
      prefix: --affectedonly
  - id: peelseqiter
    type: ['null', int]
    doc: Number of iterations for the peel sequence (default 1000000)
    inputBinding:
      position: 1
      prefix: --peelseqiter
  - id: randomseeds
    type: ['null', File]
    doc: File containing random seeds
    inputBinding:
      position: 1
      prefix: --randomseeds
  - id: verbose
    type: ['null', boolean]
    doc: Enable verbose output
    inputBinding:
      position: 1
      prefix: --verbose
outputs:
  - id: output_file
    type: ['null', File]
    doc: LOD score output file
    outputBinding:
      glob: $(inputs.output_file_path)
  - id: trace_files
    type: File[]
    doc: MCMC trace files (only with --trace)
    outputBinding:
      glob: $(inputs.traceprefix || 'trace')*
  - id: stdout
    type: stdout
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/swiftlink:1.0--1
stdout: swiftlink.stdout.txt
