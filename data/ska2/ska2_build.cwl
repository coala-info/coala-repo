cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ska
  - build
label: ska2_build
doc: "Create a split-kmer file from input sequences\n\nTool homepage: https://github.com/bacpop/ska.rust"
inputs:
  - id: seq_files
    type:
      - 'null'
      - type: array
        items: File
    doc: 'List of input FASTA files'
    inputBinding:
      position: 1
  - id: file_list
    type:
      - 'null'
      - File
    doc: 'File listing input files (tab separated name, sequences)'
    inputBinding:
      position: 101
      prefix: -f
  - id: list_files
    type:
      - 'null'
      - type: array
        items: File
    doc: 'Files named in the file list; they are staged in the working directory so that the plain names in the list resolve'
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: 'K-mer size [default: 31]'
    inputBinding:
      position: 101
      prefix: -k
  - id: proportion_reads
    type:
      - 'null'
      - float
    doc: 'Number of reads before stopping'
    inputBinding:
      position: 101
      prefix: --proportion-reads
  - id: single_strand
    type:
      - 'null'
      - boolean
    doc: 'Ignore reverse complement (all contigs are oriented along same strand)'
    inputBinding:
      position: 101
      prefix: --single-strand
  - id: min_count
    type:
      - 'null'
      - int
    doc: 'Minimum k-mer count (with reads)'
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
  - id: qual_filter
    type:
      - 'null'
      - string
    doc: 'Quality filtering criteria (with reads): no-filter, middle or strict [default: strict]'
    inputBinding:
      position: 101
      prefix: --qual-filter
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Number of CPU threads [default: 1]'
    inputBinding:
      position: 101
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: 'Show progress messages'
    inputBinding:
      position: 101
      prefix: -v
  - id: output_prefix
    type: string
    doc: 'Output prefix (.skf is added)'
    inputBinding:
      position: 102
      prefix: -o
outputs:
  - id: skf_file
    type: File
    doc: 'Split-kmer file'
    outputBinding:
      glob: '$(inputs.output_prefix).skf'
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: '${ return inputs.list_files ? inputs.list_files : []; }'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ska2:0.5.1--h4349ce8_0
