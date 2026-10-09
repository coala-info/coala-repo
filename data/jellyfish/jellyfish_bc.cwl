cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - jellyfish
  - bc
label: jellyfish_bc
doc: "Create a bloom filter from the input k-mers\n\nTool homepage: http://www.genome.umd.edu/jellyfish.html"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: Input k-mer files
    inputBinding:
      position: 1
  - id: canonical
    type:
      - 'null'
      - boolean
    doc: Count both strand, canonical representation
    inputBinding:
      position: 102
      prefix: --canonical
  - id: expected_num_kmers
    type: int
    doc: Expected number of k-mers in input
    inputBinding:
      position: 102
      prefix: --size
  - id: false_positive_rate
    type:
      - 'null'
      - float
    doc: False positive rate
    inputBinding:
      position: 102
      prefix: --fpr
  - id: generator_file
    type:
      - 'null'
      - File
    doc: File of commands generating fast[aq]
    inputBinding:
      position: 102
      prefix: --generator
  - id: mer_len
    type: int
    doc: Length of mer
    inputBinding:
      position: 102
      prefix: --mer-len
  - id: num_files_open_simultaneously
    type:
      - 'null'
      - int
    doc: Number files open simultaneously
    inputBinding:
      position: 102
      prefix: --Files
  - id: num_generators_simultaneously
    type:
      - 'null'
      - int
    doc: Number of generators run simultaneously
    inputBinding:
      position: 102
      prefix: --Generators
  - id: output_file
    type: string
    default: mer_bloom_filter
    doc: Output file
    inputBinding:
      position: 102
      prefix: --output
  - id: shell
    type:
      - 'null'
      - string
    doc: Shell used to run generator commands
    inputBinding:
      position: 102
      prefix: --shell
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    inputBinding:
      position: 102
      prefix: --threads
  - id: timing_file
    type:
      - 'null'
      - string
    doc: Print timing information
    inputBinding:
      position: 102
      prefix: --timing
outputs:
  - id: bloom_filter
    type: File
    doc: Bloom filter file
    outputBinding:
      glob: $(inputs.output_file)
  - id: timing_output
    type:
      - 'null'
      - File
    doc: Timing information
    outputBinding:
      glob: '$(inputs.timing_file === null ? [] : inputs.timing_file)'
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/jellyfish:v2.2.10-2-deb_cv1
