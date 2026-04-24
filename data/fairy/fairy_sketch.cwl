cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fairy
  - sketch
label: fairy_sketch
doc: "Sketch (index) reads. Each sample.fq -> sample.bcsp\n\nTool homepage: https://github.com/bluenote-1577/fairy"
inputs:
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Debug output
    inputBinding:
      position: 101
      prefix: --debug
  - id: first_pairs
    type:
      - 'null'
      - type: array
        items: File
    doc: First pairs for paired end reads
    inputBinding:
      position: 101
      prefix: --first-pairs
  - id: k_value
    type:
      - 'null'
      - int
    doc: Value of k. Only k = 21, 31 are currently supported
    inputBinding:
      position: 101
      prefix: -k
  - id: list_first_pair
    type:
      - 'null'
      - File
    doc: Newline delimited file; inputs are first pair of PE reads
    inputBinding:
      position: 101
      prefix: --l1
  - id: list_sample_names
    type:
      - 'null'
      - File
    doc: Newline delimited file; read sketches are renamed to given sample names
    inputBinding:
      position: 101
      prefix: --lS
  - id: list_second_pair
    type:
      - 'null'
      - File
    doc: Newline delimited file; inputs are second pair of PE reads
    inputBinding:
      position: 101
      prefix: --l2
  - id: reads
    type:
      - 'null'
      - type: array
        items: File
    doc: Single-end fasta/fastq reads
    inputBinding:
      position: 101
      prefix: --reads
  - id: sample_names
    type:
      - 'null'
      - type: array
        items: string
    doc: Read sketches are renamed to given sample names as opposed to using the
      read file name
    inputBinding:
      position: 101
      prefix: --sample-names
  - id: second_pairs
    type:
      - 'null'
      - type: array
        items: File
    doc: Second pairs for paired end reads
    inputBinding:
      position: 101
      prefix: --second-pairs
  - id: subsampling_rate
    type:
      - 'null'
      - int
    doc: Subsampling rate
    inputBinding:
      position: 101
      prefix: -c
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    inputBinding:
      position: 101
      prefix: -t
  - id: trace
    type:
      - 'null'
      - boolean
    doc: 'Trace output (caution: very verbose)'
    inputBinding:
      position: 101
      prefix: --trace
outputs:
  - id: sample_output_directory
    type:
      - 'null'
      - Directory
    doc: Output directory for sample sketches
    outputBinding:
      glob: $(inputs.sample_output_directory)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fairy:0.5.8--hc1c3326_0
