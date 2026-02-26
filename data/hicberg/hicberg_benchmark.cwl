cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hicberg
  - benchmark
label: hicberg_benchmark
doc: "Perform benchmarking of the statistical model (this can be time consuming).\n\
  \nTool homepage: https://github.com/sebgra/hicberg"
inputs:
  - id: genome
    type: string
    doc: Genome to use as source for duplication
    inputBinding:
      position: 1
  - id: auto
    type:
      - 'null'
      - int
    doc: Automatically select auto intervals for duplication.
    inputBinding:
      position: 102
      prefix: --auto
  - id: bins
    type:
      - 'null'
      - int
    doc: Number of bins to select from a genomic coordinates.
    default: 1
    inputBinding:
      position: 102
      prefix: --bins
  - id: chromosome
    type:
      - 'null'
      - string
    doc: Chromosome to get as source for duplication.
    inputBinding:
      position: 102
      prefix: --chromosome
  - id: cpus
    type:
      - 'null'
      - int
    doc: Threads to use for analysis.
    default: 1
    inputBinding:
      position: 102
      prefix: --cpus
  - id: deviation
    type:
      - 'null'
      - float
    doc: Standard deviation for contact density estimation.
    default: 0.5
    inputBinding:
      position: 102
      prefix: --deviation
  - id: force
    type:
      - 'null'
      - boolean
    doc: Set if previous analysis files have to be deleted.
    inputBinding:
      position: 102
      prefix: --force
  - id: iterations
    type:
      - 'null'
      - int
    doc: Set the number of iterations for benchmarking.
    default: 3
    inputBinding:
      position: 102
      prefix: --iterations
  - id: jitter
    type:
      - 'null'
      - int
    doc: Set jitter for pattern detection interval overlapping
    default: 0
    inputBinding:
      position: 102
      prefix: --jitter
  - id: kernel_size
    type:
      - 'null'
      - int
    doc: Size of the gaussian kernel for contact density estimation.
    default: 11
    inputBinding:
      position: 102
      prefix: --kernel-size
  - id: mode
    type:
      - 'null'
      - type: array
        items: string
    doc: Statistical model to use for ambiguous reads assignment. Multiple modes
      must be coma separated.
    default: full
    inputBinding:
      position: 102
      prefix: --mode
  - id: pattern
    type:
      - 'null'
      - string
    doc: Set pattern if benchmarking considering patterns.
    inputBinding:
      position: 102
      prefix: --pattern
  - id: position
    type:
      - 'null'
      - int
    doc: Position to get as source for duplication.
    inputBinding:
      position: 102
      prefix: --position
  - id: strides
    type:
      - 'null'
      - type: array
        items: string
    doc: Strides to apply from source genomic coordinates to define targets 
      intervals. Multiple strides must be coma separated.
    inputBinding:
      position: 102
      prefix: --strides
  - id: threshold
    type:
      - 'null'
      - float
    doc: Set pattern score threshold under which pattern are discarded.
    default: 0.0
    inputBinding:
      position: 102
      prefix: --threshold
  - id: top
    type:
      - 'null'
      - int
    doc: Set the top k % of patterns to retain.
    default: 100
    inputBinding:
      position: 102
      prefix: --top
  - id: trans_chromosome
    type:
      - 'null'
      - string
    doc: Chromosome to get as target for duplication.
    inputBinding:
      position: 102
      prefix: --trans-chromosome
  - id: trans_position
    type:
      - 'null'
      - int
    doc: Position to get as target for duplication.
    inputBinding:
      position: 102
      prefix: --trans-position
  - id: trend
    type:
      - 'null'
      - string
    doc: Set if detrending of the contact map has to be performed.
    inputBinding:
      position: 102
      prefix: --trend
outputs:
  - id: output_folder
    type:
      - 'null'
      - File
    doc: Output folder to save results.
    outputBinding:
      glob: $(inputs.output_folder)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hicberg:1.0.1--py312hcf36b3e_0
