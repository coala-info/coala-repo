cwlVersion: v1.2
class: CommandLineTool
baseCommand: hackgap countwith
label: hackgap_countwith
doc: "Count k-mers in files using an existing index.\n\nTool homepage: https://gitlab.com/rahmannlab/hackgap"
inputs:
  - id: files
    type:
      - 'null'
      - type: array
        items: File
    doc: file(s) in which to count k-mers ([gzipped] FASTA or FASTQ)
    inputBinding:
      position: 101
      prefix: --files
  - id: input_prefix
    type: string
    doc: path/prefix of the existing index which should be used for counting
    inputBinding:
      position: 101
      prefix: --index
  - id: statistics
    type:
      - 'null'
      - string
    doc: statistics level of detail (none, *summary*, details, full (all 
      subtables))
    default: summary
    inputBinding:
      position: 101
      prefix: --statistics
  - id: threads_read
    type:
      - 'null'
      - int
    doc: number of reader threads
    inputBinding:
      position: 101
      prefix: --threads-read
  - id: threads_split
    type:
      - 'null'
      - int
    doc: number of splitter threads
    inputBinding:
      position: 101
      prefix: --threads-split
outputs:
  - id: output_prefix
    type: File
    doc: path/prefix of output file with k-mer count hash (required; use 
      '/dev/null' or 'null' or 'none' to avoid output)
    outputBinding:
      glob: $(inputs.output_prefix)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hackgap:1.0.1--pyhdfd78af_0
