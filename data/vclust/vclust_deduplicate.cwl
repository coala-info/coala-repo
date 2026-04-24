cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - vclust
  - deduplicate
label: vclust_deduplicate
doc: "Output FASTA file with unique, nonredundant sequences, removing duplicates and
  their reverse complements\n\nTool homepage: https://github.com/refresh-bio/vclust"
inputs:
  - id: add_prefixes
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Add prefixes to sequence IDs. Without any values, prefixes are set to input
      file names. Provide space-separated prefixes to override. Default: prefixes
      are disabled [False]'
    inputBinding:
      position: 101
      prefix: --add-prefixes
  - id: gzip_level
    type:
      - 'null'
      - int
    doc: Compression level for gzip (1-9) [4]
    inputBinding:
      position: 101
      prefix: --gzip-level
  - id: gzip_output
    type:
      - 'null'
      - boolean
    doc: Compress the output FASTA file with gzip [False]
    inputBinding:
      position: 101
      prefix: --gzip-output
  - id: input_files
    type:
      type: array
      items: File
    doc: Space-separated input FASTA files (gzipped or uncompressed)
    inputBinding:
      position: 101
      prefix: --in
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads [20]
    inputBinding:
      position: 101
      prefix: --threads
  - id: verbosity_level
    type:
      - 'null'
      - int
    doc: 'Verbosity level [1]: 0: Errors only 1: Info 2: Debug'
    inputBinding:
      position: 101
      prefix: -v
outputs:
  - id: output_file
    type: File
    doc: Output FASTA file with unique, nonredundant sequences, removing 
      duplicates and their reverse complements
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vclust:1.3.1--py311he264feb_1
