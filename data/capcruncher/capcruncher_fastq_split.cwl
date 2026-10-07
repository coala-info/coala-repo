cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - capcruncher
  - fastq
  - split
label: capcruncher_fastq_split
doc: "Splits fastq file(s) into equal chunks of n reads.\n\nTool homepage: https://github.com/sims-lab/CapCruncher.git"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: "FASTQ file(s) to split"
    inputBinding:
      position: 1
  - id: method
    type:
      - 'null'
      - string
    doc: "Method to use for splitting (python or unix)"
    inputBinding:
      position: 2
      prefix: -m
  - id: output_prefix
    type: string
    default: split
    doc: "Output prefix for split fastq file(s)"
    inputBinding:
      position: 2
      prefix: -o
  - id: compression_level
    type:
      - 'null'
      - int
    doc: "Level of compression for output files"
    inputBinding:
      position: 2
      prefix: --compression_level
  - id: n_reads
    type:
      - 'null'
      - int
    doc: "Number of reads per fastq file"
    inputBinding:
      position: 2
      prefix: -n
  - id: gzip
    type:
      - 'null'
      - boolean
    doc: "Gzip output files (default)"
    inputBinding:
      position: 2
      prefix: --gzip
  - id: no_gzip
    type:
      - 'null'
      - boolean
    doc: "Do not gzip output files"
    inputBinding:
      position: 2
      prefix: --no-gzip
  - id: n_cores
    type:
      - 'null'
      - int
    doc: "Number of cores"
    inputBinding:
      position: 2
      prefix: -p
  - id: suffix
    type:
      - 'null'
      - string
    doc: "Suffix to add to output files (ignore {read_number}.fastq as this is added automatically)"
    inputBinding:
      position: 2
      prefix: -s
outputs:
  - id: split_fastq
    type:
      type: array
      items: File
    doc: "Split FASTQ files"
    outputBinding:
      glob: $(inputs.output_prefix)*
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/capcruncher:0.3.14--pyhdfd78af_1
