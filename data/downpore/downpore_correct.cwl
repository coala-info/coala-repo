cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - downpore
  - correct
label: downpore_correct
doc: "Experimental read correction: finds overlaps for the longest reads and builds base-space consensus sequences from them. Progress messages and results are written to stdout.\n\nTool homepage: https://github.com/jteutenberg/downpore"
inputs:
  - id: seed_batch_size
    type:
      - 'null'
      - int
    doc: 'Maximum total unique seeds to use in each query batch (default 10000)'
    inputBinding:
      position: 101
      prefix: -seed_batch_size
  - id: k
    type:
      - 'null'
      - int
    doc: 'Number of bases in each seed (default 10)'
    inputBinding:
      position: 101
      prefix: -k
  - id: num_workers
    type:
      - 'null'
      - int
    doc: 'Number of worker threads to spawn (default 4)'
    inputBinding:
      position: 101
      prefix: -num_workers
  - id: input
    type: File
    doc: 'Fasta/fastq input file'
    inputBinding:
      position: 101
      prefix: -input
  - id: trim
    type:
      - 'null'
      - int
    doc: 'Whether to search for and trim adapters: 0=off, 1=on (default 0)'
    inputBinding:
      position: 101
      prefix: -trim
  - id: front_adapters
    type:
      - 'null'
      - File
    doc: 'Fasta/fastq file containing front adapters'
    inputBinding:
      position: 101
      prefix: -front_adapters
  - id: himem
    type:
      - 'null'
      - boolean
    doc: 'Whether to cache all reads in memory (default true)'
    inputBinding:
      position: 101
      prefix: -himem
      valueFrom: '$(self ? "true" : "false")'
  - id: overlap_size
    type:
      - 'null'
      - int
    doc: 'Size of overlap to search for in bases (default 1000)'
    inputBinding:
      position: 101
      prefix: -overlap_size
  - id: num_seeds
    type:
      - 'null'
      - int
    doc: 'Minimum number of seeds to generate for each overlap query (default 15)'
    inputBinding:
      position: 101
      prefix: -num_seeds
  - id: chunk_size
    type:
      - 'null'
      - int
    doc: 'Size to chop long reads into for querying against, in bases (default 10000)'
    inputBinding:
      position: 101
      prefix: -chunk_size
  - id: min_hits
    type:
      - 'null'
      - float
    doc: 'Minimum proportion of seeds that must match each query (default 0.25)'
    inputBinding:
      position: 101
      prefix: -min_hits
  - id: back_adapters
    type:
      - 'null'
      - File
    doc: 'Fasta/fastq file containing back adapters'
    inputBinding:
      position: 101
      prefix: -back_adapters
  - id: model
    type:
      - 'null'
      - File
    doc: 'K-mer numeric values to use in alignment'
    inputBinding:
      position: 101
      prefix: -model
  - id: output_file_path
    type:
      - 'null'
      - string
    doc: Name of the file that receives the output written to stdout
    default: correct.out
outputs:
  - id: output_file
    type: File
    doc: Progress messages and consensus results printed by the tool
    outputBinding:
      glob: $(inputs.output_file_path)
stdout: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/downpore:0.3.4--h375a9b1_0
