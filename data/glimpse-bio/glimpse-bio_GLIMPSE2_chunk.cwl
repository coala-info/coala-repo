cwlVersion: v1.2
class: CommandLineTool
baseCommand: GLIMPSE2_chunk
label: glimpse-bio_GLIMPSE2_chunk
doc: "Split chromosomes into chunks\n\nTool homepage: https://github.com/odelaneau/GLIMPSE"
inputs:
  - id: seed
    type:
      - 'null'
      - int
    doc: "Seed of the random number generator"
    inputBinding:
      position: 101
      prefix: --seed
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of threads"
    inputBinding:
      position: 101
      prefix: --threads
  - id: input
    type: File
    doc: "Reference or target dataset at all variable positions in VCF/BCF format. The GT field is not required"
    secondaryFiles:
      - pattern: '.csi'
        required: false
      - pattern: '.tbi'
        required: false
    inputBinding:
      position: 101
      prefix: --input
  - id: region
    type: string
    doc: "Chromosome or region to be split"
    inputBinding:
      position: 101
      prefix: --region
  - id: map
    type:
      - 'null'
      - File
    doc: "Genetic map"
    inputBinding:
      position: 101
      prefix: --map
  - id: sparse_maf
    type:
      - 'null'
      - float
    doc: "(Expert setting) Rare variant threshold"
    inputBinding:
      position: 101
      prefix: --sparse-maf
  - id: window_cm
    type:
      - 'null'
      - float
    doc: "Minimal window size in cM"
    inputBinding:
      position: 101
      prefix: --window-cm
  - id: window_mb
    type:
      - 'null'
      - float
    doc: "Minimal window size in Mb"
    inputBinding:
      position: 101
      prefix: --window-mb
  - id: window_count
    type:
      - 'null'
      - int
    doc: "Minimal window size in # common variants"
    inputBinding:
      position: 101
      prefix: --window-count
  - id: buffer_cm
    type:
      - 'null'
      - float
    doc: "Minimal buffer size in cM"
    inputBinding:
      position: 101
      prefix: --buffer-cm
  - id: buffer_mb
    type:
      - 'null'
      - float
    doc: "Minimal buffer size in Mb"
    inputBinding:
      position: 101
      prefix: --buffer-mb
  - id: buffer_count
    type:
      - 'null'
      - int
    doc: "Minimal buffer size in # common variants"
    inputBinding:
      position: 101
      prefix: --buffer-count
  - id: recursive
    type:
      - 'null'
      - boolean
    doc: "Recursive algorithm"
    inputBinding:
      position: 101
      prefix: --recursive
  - id: sequential
    type:
      - 'null'
      - boolean
    doc: "(Recommended). Sequential algorithm"
    inputBinding:
      position: 101
      prefix: --sequential
  - id: uniform_number_variants
    type:
      - 'null'
      - boolean
    doc: "(Experimental) Uniform the number of variants in the sequential algorithm"
    inputBinding:
      position: 101
      prefix: --uniform-number-variants
  - id: output_path
    type: string
    doc: "File containing the chunks for phasing and imputation"
    inputBinding:
      position: 102
      prefix: --output
  - id: log_path
    type:
      - 'null'
      - string
    doc: "Log file"
    inputBinding:
      position: 101
      prefix: --log
outputs:
  - id: output
    type: File
    doc: File containing the chunks for phasing and imputation
    outputBinding:
      glob: $(inputs.output_path)
  - id: log
    type:
      - 'null'
      - File
    doc: Log file
    outputBinding:
      glob: $(inputs.log_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/glimpse-bio:2.0.1--ha5d29c5_3
