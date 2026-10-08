cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gia
  - random
label: gia_random
doc: "Generates a random BED file given some parameterizations\n\nTool homepage: https://github.com/noamteyssier/gia"
inputs:
  - id: n_intervals
    type:
      - 'null'
      - int
    doc: "Number of intervals to generate (default = 10_000)"
    inputBinding:
      position: 101
      prefix: --n-intervals
  - id: l_intervals
    type:
      - 'null'
      - int
    doc: "Length of intervals to generate (default = 150)"
    inputBinding:
      position: 101
      prefix: --l-intervals
  - id: n_chr
    type:
      - 'null'
      - int
    doc: "Number of chromosomes to generate (default = 23)"
    inputBinding:
      position: 101
      prefix: --n-chr
  - id: max_chr_len
    type:
      - 'null'
      - int
    doc: "Maximum length of chromosomes (default = 250_000_000)"
    inputBinding:
      position: 101
      prefix: --max-chr-len
  - id: seed
    type:
      - 'null'
      - int
    doc: "Seed to use for random number generation (no default)"
    inputBinding:
      position: 101
      prefix: --seed
  - id: genome
    type:
      - 'null'
      - File
    doc: "Genome file to set boundaries for random intervals"
    inputBinding:
      position: 101
      prefix: --genome
  - id: named
    type:
      - 'null'
      - boolean
    doc: "Allow for non-integer chromosome names in genome file + output"
    inputBinding:
      position: 101
      prefix: --named
  - id: format
    type:
      - 'null'
      - string
    doc: "Set the output format (bed3, bed4, bed6, gtf, bed12, ambiguous, bed-graph)"
    inputBinding:
      position: 101
      prefix: --format
  - id: compression_level
    type:
      - 'null'
      - int
    doc: "Compression level to use for output files if applicable"
    inputBinding:
      position: 101
      prefix: --compression-level
  - id: compression_threads
    type:
      - 'null'
      - int
    doc: "Compression threads to use for output files if applicable"
    inputBinding:
      position: 101
      prefix: --compression-threads
  - id: output_path
    type: string
    doc: "Output file to write to"
    inputBinding:
      position: 102
      prefix: --output
outputs:
  - id: output
    type: File
    doc: Random BED file
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gia:0.2.23--h588a25a_0
