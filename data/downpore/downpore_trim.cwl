cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - downpore
  - trim
label: downpore_trim
doc: "Removes adapters or barcodes from the ends of long reads and splits reads at internal adapters (similar to Porechop). Writes the trimmed reads to stdout in the input format, or one file per barcode into the demultiplex folder.\n\nTool homepage: https://github.com/jteutenberg/downpore"
inputs:
  - id: chunk_size
    type:
      - 'null'
      - int
    doc: 'Split long reads into chunks of this size when indexing (default 5000)'
    inputBinding:
      position: 101
      prefix: -chunk_size
  - id: discard_middle
    type:
      - 'null'
      - boolean
    doc: 'Whether to keep halves of split reads (default false)'
    inputBinding:
      position: 101
      prefix: -discard_middle
      valueFrom: '$(self ? "true" : "false")'
  - id: verbosity
    type:
      - 'null'
      - int
    doc: 'Level (0-2) of output to stderr (default 1)'
    inputBinding:
      position: 101
      prefix: -verbosity
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
    doc: 'Whether to cache all reads in memory (default false)'
    inputBinding:
      position: 101
      prefix: -himem
      valueFrom: '$(self ? "true" : "false")'
  - id: require_pairs
    type:
      - 'null'
      - boolean
    doc: 'Whether front/back adapters with the same name must appear together (default false)'
    inputBinding:
      position: 101
      prefix: -require_pairs
      valueFrom: '$(self ? "true" : "false")'
  - id: extra_middle_trim
    type:
      - 'null'
      - int
    doc: 'Number of bases to remove around read-splitting adapters (default 100)'
    inputBinding:
      position: 101
      prefix: -extra_middle_trim
  - id: determine_adapters
    type:
      - 'null'
      - boolean
    doc: 'Whether to use a fixed set of adapters or to search for those present (default true)'
    inputBinding:
      position: 101
      prefix: -determine_adapters
      valueFrom: '$(self ? "true" : "false")'
  - id: middle_threshold
    type:
      - 'null'
      - int
    doc: '% identity for matching adapters that split reads (default 85)'
    inputBinding:
      position: 101
      prefix: -middle_threshold
  - id: check_reads
    type:
      - 'null'
      - int
    doc: 'Number of reads to use to determine which adapters are present (default 10000)'
    inputBinding:
      position: 101
      prefix: -check_reads
  - id: adapter_threshold
    type:
      - 'null'
      - int
    doc: '% identity required at check_adapters stage (default 90)'
    inputBinding:
      position: 101
      prefix: -adapter_threshold
  - id: extra_end_trim
    type:
      - 'null'
      - int
    doc: 'Number of bases to remove around adapters at read edges (default 5)'
    inputBinding:
      position: 101
      prefix: -extra_end_trim
  - id: back_adapters
    type:
      - 'null'
      - File
    doc: 'Fasta/fastq file containing back adapters'
    inputBinding:
      position: 101
      prefix: -back_adapters
  - id: num_workers
    type:
      - 'null'
      - int
    doc: 'Number of threads to use (default 4)'
    inputBinding:
      position: 101
      prefix: -num_workers
  - id: demultiplex
    type:
      - 'null'
      - string
    doc: 'A path to demultiplex to, otherwise write sequences to stdout'
    inputBinding:
      position: 101
      prefix: -demultiplex
  - id: input
    type: File
    doc: 'Fasta/fastq/gzip input file'
    inputBinding:
      position: 101
      prefix: -input
  - id: k
    type:
      - 'null'
      - int
    doc: 'k-mer size to use when matching adapters (default 6)'
    inputBinding:
      position: 101
      prefix: -k
  - id: tag_adapters
    type:
      - 'null'
      - boolean
    doc: 'Whether to add adapter names to output sequence names (default true)'
    inputBinding:
      position: 101
      prefix: -tag_adapters
      valueFrom: '$(self ? "true" : "false")'
  - id: output_file_path
    type:
      - 'null'
      - string
    doc: Name of the file that receives the output written to stdout
    default: trimmed.fastq
outputs:
  - id: output_file
    type: File
    doc: Trimmed reads (fasta/fastq, same format as the input); empty when demultiplexing
    outputBinding:
      glob: $(inputs.output_file_path)
  - id: demultiplexed
    type:
      - 'null'
      - Directory
    doc: Folder with one fasta/fastq file per barcode (when -demultiplex is set)
    outputBinding:
      glob: '${ return inputs.demultiplex ? inputs.demultiplex : []; }'
stdout: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - '${ if (inputs.demultiplex) { return {"class": "Directory", "basename": inputs.demultiplex, "listing": [], "writable": true}; } return null; }'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/downpore:0.3.4--h375a9b1_0
