cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastqsplitter
label: fastqsplitter
doc: "Split a fastq file into multiple parts.\n\nTool homepage: https://github.com/LUMC/fastqsplitter"
inputs:
  - id: compression
    type:
      - 'null'
      - int
    doc: Compression level for output files (0-9).
    inputBinding:
      position: 101
      prefix: --compression
  - id: input
    type: File
    doc: Input fastq file (can be gzipped).
    inputBinding:
      position: 101
      prefix: --input
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use for compression.
    inputBinding:
      position: 101
      prefix: --threads
  - id: output_path
    type: string
    doc: Output or path parameter `output_path`
    inputBinding:
      position: 102
      prefix: --output
outputs:
  - id: output
    type: File
    doc: Output fastq files (can be gzipped).
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastqsplitter:1.2.0--py310h4b81fae_5
