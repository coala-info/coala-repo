cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - downpore
  - map
label: downpore_map
doc: "Finds the most likely approximate source location in a single reference sequence for each long read, like an approximate long-read mapper. Writes the mappings to stdout in PAF format.\n\nTool homepage: https://github.com/jteutenberg/downpore"
inputs:
  - id: circular
    type:
      - 'null'
      - boolean
    doc: 'Whether the reference genome is circular (default true)'
    inputBinding:
      position: 101
      prefix: -circular
      valueFrom: '$(self ? "true" : "false")'
  - id: k
    type:
      - 'null'
      - int
    doc: 'Length of seeds in bases (default 11)'
    inputBinding:
      position: 101
      prefix: -k
  - id: chunk_size
    type:
      - 'null'
      - int
    doc: 'The number of bases for reference index chunks (default 10000)'
    inputBinding:
      position: 101
      prefix: -chunk_size
  - id: seed_rate
    type:
      - 'null'
      - int
    doc: 'The maximum number of bases between seeds in the reference (default 40)'
    inputBinding:
      position: 101
      prefix: -seed_rate
  - id: input
    type: File
    doc: 'Fasta/fastq input file'
    inputBinding:
      position: 101
      prefix: -input
  - id: reference
    type: File
    doc: 'A fasta file containing a reference sequence to align against'
    inputBinding:
      position: 101
      prefix: -reference
  - id: query_size
    type:
      - 'null'
      - int
    doc: 'The number of bases to query at a time (default 1000)'
    inputBinding:
      position: 101
      prefix: -query_size
  - id: min_length
    type:
      - 'null'
      - int
    doc: 'The minimum sequence size to generate queries from (default 500)'
    inputBinding:
      position: 101
      prefix: -min_length
  - id: num_workers
    type:
      - 'null'
      - int
    doc: 'The number of worker process to use for mapping (default 4)'
    inputBinding:
      position: 101
      prefix: -num_workers
  - id: output_file_path
    type:
      - 'null'
      - string
    doc: Name of the file that receives the output written to stdout
    default: mappings.paf
outputs:
  - id: output_file
    type: File
    doc: Mappings in PAF format
    outputBinding:
      glob: $(inputs.output_file_path)
stdout: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/downpore:0.3.4--h375a9b1_0
