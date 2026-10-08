cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - downpore
  - overlap
label: downpore_overlap
doc: "Finds overlaps amongst a set of long reads by matching the beginning and end of each read (default 1000 bases) against all reads with seed k-mers, similar to minimap2 ava mode. Writes the overlaps to stdout in PAF format.\n\nTool homepage: https://github.com/jteutenberg/downpore"
inputs:
  - id: chunk_size
    type:
      - 'null'
      - int
    doc: 'Size to chop long reads into for querying against, in bases (default 10000)'
    inputBinding:
      position: 101
      prefix: -chunk_size
  - id: query_batch_size
    type:
      - 'null'
      - int
    doc: 'Maximum number of queries per batch (if max seeds not reached) (default 20000)'
    inputBinding:
      position: 101
      prefix: -query_batch_size
  - id: num_workers
    type:
      - 'null'
      - int
    doc: 'Number of worker threads to spawn (default 4)'
    inputBinding:
      position: 101
      prefix: -num_workers
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
  - id: min_hits
    type:
      - 'null'
      - float
    doc: 'Minimum proportion of seeds that must match each query (default 0.25)'
    inputBinding:
      position: 101
      prefix: -min_hits
  - id: input
    type: File
    doc: 'Fasta/fastq input file'
    inputBinding:
      position: 101
      prefix: -input
  - id: seed_values
    type:
      - 'null'
      - File
    doc: 'File containing values to use during seed selection.'
    inputBinding:
      position: 101
      prefix: -seed_values
  - id: k
    type:
      - 'null'
      - int
    doc: 'Number of bases in each seed (default 10)'
    inputBinding:
      position: 101
      prefix: -k
  - id: seed_batch_size
    type:
      - 'null'
      - int
    doc: 'Maximum total unique seeds to use in each query batch (default 10000)'
    inputBinding:
      position: 101
      prefix: -seed_batch_size
  - id: output_file_path
    type:
      - 'null'
      - string
    doc: Name of the file that receives the output written to stdout
    default: overlaps.paf
outputs:
  - id: output_file
    type: File
    doc: Overlaps in PAF format
    outputBinding:
      glob: $(inputs.output_file_path)
stdout: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/downpore:0.3.4--h375a9b1_0
