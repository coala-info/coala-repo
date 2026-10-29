cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - read_utils.py
  - fastq_to_fasta
label: viral-ngs_read_utils_fastq_to_fasta
doc: "Convert from fastq format to fasta format. Warning: output reads might be split onto multiple lines.\n\nTool homepage: https://github.com/broadinstitute/viral-ngs"
inputs:
  - id: in_fastq
    type: File
    doc: "Input fastq file."
    inputBinding:
      position: 1
  - id: out_fasta
    type: string
    doc: "Output fasta file."
    inputBinding:
      position: 2
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
  - id: tmp_dir
    type:
      - 'null'
      - string
    doc: "Base directory for temp files. [default: /tmp]"
    inputBinding:
      position: 21
      prefix: --tmp_dir
  - id: tmp_dir_keep
    type:
      - 'null'
      - boolean
    doc: "Keep the tmp_dir if an exception occurs while running. Default is to delete all temp files at the end, even if there's a failure."
    inputBinding:
      position: 21
      prefix: --tmp_dirKeep
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: out_fasta_file
    type: File
    doc: "Output fasta file"
    outputBinding:
      glob: $(inputs.out_fasta)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
stdout: viral-ngs_read_utils_fastq_to_fasta.out
