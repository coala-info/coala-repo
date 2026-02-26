cwlVersion: v1.2
class: CommandLineTool
baseCommand: downpore_kmers
label: downpore_kmers
doc: "Compute k-mers from a FASTQ file.\n\nTool homepage: https://github.com/jteutenberg/downpore"
inputs:
  - id: input_fastq
    type: File
    doc: Input FASTQ file
    inputBinding:
      position: 1
  - id: k
    type:
      - 'null'
      - int
    doc: k-mer size
    default: 31
    inputBinding:
      position: 102
      prefix: --k
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    default: 1
    inputBinding:
      position: 102
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file for k-mer counts
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/downpore:0.3.4--h375a9b1_0
