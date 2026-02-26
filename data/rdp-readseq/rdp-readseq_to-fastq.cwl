cwlVersion: v1.2
class: CommandLineTool
baseCommand: rdp-readseq_to-fastq
label: rdp-readseq_to-fastq
doc: Converts sequence files to FASTQ format.
inputs:
  - id: input_file
    type: File
    doc: Input sequence file (e.g., FASTA, GenBank)
    inputBinding:
      position: 1
  - id: force
    type:
      - 'null'
      - boolean
    doc: Overwrite output file if it already exists.
    inputBinding:
      position: 102
      prefix: --force
  - id: interleaved
    type:
      - 'null'
      - boolean
    doc: Output interleaved FASTQ format (for paired-end reads).
    inputBinding:
      position: 102
      prefix: --interleaved
  - id: max_length
    type:
      - 'null'
      - int
    doc: Maximum sequence length to include in the output.
    inputBinding:
      position: 102
      prefix: --max-length
  - id: min_length
    type:
      - 'null'
      - int
    doc: Minimum sequence length to include in the output.
    inputBinding:
      position: 102
      prefix: --min-length
  - id: quality_score
    type:
      - 'null'
      - int
    doc: Assign a constant quality score to all bases (0-41).
    inputBinding:
      position: 102
      prefix: --quality-score
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output FASTQ file name. If not specified, output will be written to 
      standard output.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/rdp-readseq:v2.0.2-6-deb_cv1
