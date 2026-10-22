cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sketchlib
  - inverted
  - query
label: sketchlib_inverted_query
doc: "Find distances against an inverted index\n\nTool homepage: https://github.com/bacpop/sketchlib.rust"
inputs:
  - id: ski
    type: File
    doc: 'The inverted index (.ski) file used as the reference'
    inputBinding:
      position: 1
  - id: seq_files
    type:
      - 'null'
      - type: array
        items: File
    doc: 'List of input FASTA files'
    inputBinding:
      position: 2
  - id: file_list
    type:
      - 'null'
      - File
    doc: 'File listing input files (tab separated name, sequences, see README)'
    inputBinding:
      position: 101
      prefix: -f
  - id: query_type
    type:
      - 'null'
      - string
    doc: 'Type of query to perform: match-count, all-bins or any-bins [default: match-count]'
    inputBinding:
      position: 101
      prefix: --query-type
  - id: min_count
    type:
      - 'null'
      - int
    doc: 'Minimum k-mer count (with reads) [default: 5]'
    inputBinding:
      position: 101
      prefix: --min-count
  - id: min_qual
    type:
      - 'null'
      - int
    doc: 'Minimum k-mer quality (with reads) [default: 20]'
    inputBinding:
      position: 101
      prefix: --min-qual
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Number of CPU threads [default: 1]'
    inputBinding:
      position: 101
      prefix: --threads
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: 'Don''t show any messages'
    inputBinding:
      position: 101
      prefix: --quiet
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: 'Show progress messages'
    inputBinding:
      position: 101
      prefix: --verbose
  - id: output_path
    type: string
    doc: 'Output filename'
    inputBinding:
      position: 102
      prefix: -o
outputs:
  - id: output
    type: File
    doc: Query results
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sketchlib:0.2.4--h4349ce8_0
