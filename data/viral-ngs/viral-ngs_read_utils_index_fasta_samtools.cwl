cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - read_utils.py
  - index_fasta_samtools
label: viral-ngs_read_utils_index_fasta_samtools
doc: "Index a reference genome for Samtools.\n\nTool homepage: https://github.com/broadinstitute/viral-ngs"
inputs:
  - id: in_fasta
    type: File
    doc: "Reference genome, FASTA format. It is staged writable because the index is written beside it."
    inputBinding:
      position: 1
  - id: loglevel
    type:
      - 'null'
      - type: enum
        symbols:
          - DEBUG
          - INFO
          - WARNING
          - ERROR
          - CRITICAL
          - EXCEPTION
    doc: "Verboseness of output. [default: DEBUG]"
    inputBinding:
      position: 20
      prefix: --loglevel
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: fasta_index
    type: File
    doc: "Samtools .fai index"
    outputBinding:
      glob: $(inputs.in_fasta.basename).fai
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.in_fasta)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
stdout: viral-ngs_read_utils_index_fasta_samtools.out
