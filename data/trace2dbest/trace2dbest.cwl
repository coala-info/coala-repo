cwlVersion: v1.2
class: CommandLineTool
baseCommand: trace2dbest
label: trace2dbest
doc: Convert trace data to a FASTA or FASTQ file.
inputs:
  - id: input_file
    type: File
    doc: Input trace file (e.g., .ab1, .scf)
    inputBinding:
      position: 1
  - id: format
    type:
      - 'null'
      - string
    doc: Output format (fasta or fastq)
    inputBinding:
      position: 102
      prefix: --format
  - id: min_length
    type:
      - 'null'
      - int
    doc: Minimum sequence length to include in output
    inputBinding:
      position: 102
      prefix: --min-length
  - id: quality_threshold
    type:
      - 'null'
      - int
    doc: Minimum Phred quality score to include in output
    inputBinding:
      position: 102
      prefix: --quality-threshold
  - id: trim_ends
    type:
      - 'null'
      - boolean
    doc: Trim low-quality bases from the ends of sequences
    inputBinding:
      position: 102
      prefix: --trim-ends
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output
    inputBinding:
      position: 102
      prefix: --verbose
  - id: output_file_path
    type: string
    doc: Output or path parameter `output_file_path`
    inputBinding:
      position: 103
      prefix: --output-file
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output FASTA or FASTQ file
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/trace2dbest:v3.0.1-1-deb_cv1
