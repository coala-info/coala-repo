cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - kingfisher
  - extract
label: kingfisher_extract
doc: "Extract .sra format files into FASTQ or FASTA format, compressed or uncompressed.\n\
  \nTool homepage: https://github.com/wwood/kingfisher-download"
inputs:
  - id: debug
    type:
      - 'null'
      - boolean
    doc: output debug information
    inputBinding:
      position: 101
      prefix: --debug
  - id: force
    type:
      - 'null'
      - boolean
    doc: Re-download / extract files even if they already exist
    inputBinding:
      position: 101
      prefix: --force
  - id: output_directory
    type:
      - 'null'
      - string
    doc: Output directory to write to
    inputBinding:
      position: 101
      prefix: --output-directory
  - id: output_format_possibilities
    type:
      - 'null'
      - type: array
        items: string
    doc: Allowable output formats. If more than one is specified, downloaded 
      data will processed as little as possible
    inputBinding:
      position: 101
      prefix: --output-format-possibilities
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: only output errors
    inputBinding:
      position: 101
      prefix: --quiet
  - id: sra
    type: File
    doc: Extract this SRA file
    inputBinding:
      position: 101
      prefix: --sra
  - id: stdout
    type:
      - 'null'
      - boolean
    doc: Output sequences to STDOUT. Currently requires --unsorted
    inputBinding:
      position: 101
      prefix: --stdout
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use for extraction
    inputBinding:
      position: 101
      prefix: --threads
  - id: unsorted
    type:
      - 'null'
      - boolean
    doc: Output the sequences in arbitrary order, usually the order that they 
      appear in the .sra file. Even pairs of reads may be in the usual order, 
      but it is possible to tell which pair is which, and which is a forward and
      which is a reverse read from the name. Currently requires download from 
      NCBI rather than ENA.
    inputBinding:
      position: 101
      prefix: --unsorted
outputs:
  - id: stdout
    type: stdout
    doc: Standard output (sequences when --stdout is set)
  - id: sequence_files
    type:
      type: array
      items: File
    doc: Downloaded or extracted .sra, FASTQ or FASTA files.
    outputBinding:
      glob: |-
        ${
          var d = inputs.output_directory ? inputs.output_directory + "/" : "";
          return [d + "*.sra", d + "*.fastq", d + "*.fastq.gz", d + "*.fasta", d + "*.fasta.gz"];
        }
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kingfisher:0.4.1--pyh7cba7a3_0
stdout: kingfisher_extract.out
