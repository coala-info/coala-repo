cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pyfastaq
  - fastaq
  - sort_by_name
label: pyfastaq_fastaq sort_by_name
doc: "Sort FASTA/FASTQ records by name.\n\nTool homepage: https://github.com/sanger-pathogens/Fastaq"
inputs:
  - id: input_file
    type: File
    doc: Input FASTA/FASTQ file. Reads from stdin if not specified.
    inputBinding:
      position: 1
  - id: compress
    type:
      - 'null'
      - boolean
    doc: Compress output using gzip.
    inputBinding:
      position: 102
      prefix: --compress
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use for compression.
    inputBinding:
      position: 102
      prefix: --threads
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output FASTA/FASTQ file. Writes to stdout if not specified.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyfastaq:3.18.0--pyhdfd78af_0
