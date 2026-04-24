cwlVersion: v1.2
class: CommandLineTool
baseCommand: glimpse-bio_GLIMPSE2_chunk
label: glimpse-bio_GLIMPSE2_chunk
doc: "Split chromosomes into chunks\n\nTool homepage: https://odelaneau.github.io/GLIMPSE/"
inputs:
  - id: buffer_cm
    type:
      - 'null'
      - float
    doc: Minimal buffer size in cM
    inputBinding:
      position: 101
      prefix: --buffer-cm
  - id: buffer_count
    type:
      - 'null'
      - int
    doc: 'Minimal buffer size in # common variants'
    inputBinding:
      position: 101
      prefix: --buffer-count
  - id: buffer_mb
    type:
      - 'null'
      - float
    doc: Minimal buffer size in Mb
    inputBinding:
      position: 101
      prefix: --buffer-mb
  - id: input
    type:
      - 'null'
      - File
    doc: Reference or target dataset at all variable positions in VCF/BCF 
      format. The GT field is not required
    inputBinding:
      position: 101
      prefix: --input
  - id: log
    type:
      - 'null'
      - File
    doc: Log file
    inputBinding:
      position: 101
      prefix: --log
  - id: map
    type:
      - 'null'
      - File
    doc: Genetic map
    inputBinding:
      position: 101
      prefix: --map
  - id: recursive
    type:
      - 'null'
      - boolean
    doc: Recursive algorithm
    inputBinding:
      position: 101
      prefix: --recursive
  - id: region
    type:
      - 'null'
      - string
    doc: Chromosome or region to be split
    inputBinding:
      position: 101
      prefix: --region
  - id: seed
    type:
      - 'null'
      - int
    doc: Seed of the random number generator
    inputBinding:
      position: 101
      prefix: --seed
  - id: sequential
    type:
      - 'null'
      - boolean
    doc: (Recommended). Sequential algorithm
    inputBinding:
      position: 101
      prefix: --sequential
  - id: sparse_maf
    type:
      - 'null'
      - float
    doc: (Expert setting) Rare variant threshold
    inputBinding:
      position: 101
      prefix: --sparse-maf
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    inputBinding:
      position: 101
      prefix: --threads
  - id: uniform_number_variants
    type:
      - 'null'
      - boolean
    doc: (Experimental) Uniform the number of variants in the sequential 
      algorithm
    inputBinding:
      position: 101
      prefix: --uniform-number-variants
  - id: window_cm
    type:
      - 'null'
      - float
    doc: Minimal window size in cM
    inputBinding:
      position: 101
      prefix: --window-cm
  - id: window_count
    type:
      - 'null'
      - int
    doc: 'Minimal window size in # common variants'
    inputBinding:
      position: 101
      prefix: --window-count
  - id: window_mb
    type:
      - 'null'
      - float
    doc: Minimal window size in Mb
    inputBinding:
      position: 101
      prefix: --window-mb
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: File containing the chunks for phasing and imputation
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/glimpse-bio:2.0.1--ha5d29c5_3
