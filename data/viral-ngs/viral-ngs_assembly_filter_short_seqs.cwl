cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - assembly.py
  - filter_short_seqs
label: viral-ngs_assembly_filter_short_seqs
doc: "Check sequences in inFile, retaining only those that are at least minLength\n\nTool homepage: https://github.com/broadinstitute/viral-ngs"
inputs:
  - id: in_file
    type: File
    doc: "input sequence file"
    inputBinding:
      position: 1
  - id: min_length
    type: int
    doc: "minimum length for contig"
    inputBinding:
      position: 2
  - id: min_unambig
    type: float
    doc: "minimum percentage unambiguous bases for contig"
    inputBinding:
      position: 3
  - id: out_file
    type: string
    doc: "output file"
    inputBinding:
      position: 4
  - id: format
    type:
      - 'null'
      - string
    doc: "Format for input sequence (default: fasta)"
    inputBinding:
      position: 20
      prefix: --format
  - id: output_format
    type:
      - 'null'
      - string
    doc: "Format for output sequence (default: fasta)"
    inputBinding:
      position: 20
      prefix: --output-format
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
  - id: out_file_out
    type: File
    doc: "Output file"
    outputBinding:
      glob: $(inputs.out_file)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
stdout: viral-ngs_assembly_filter_short_seqs.out
