cwlVersion: v1.2
class: CommandLineTool
baseCommand: grz-check
label: grz-check
doc: "Checks integrity of sequencing files (FASTQ, BAM).\n\nTool homepage: https://github.com/BfArM-MVH/grz-tools/packages/grz-check"
inputs:
  - id: bam
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: --bam
    doc: A single BAM file to validate
    inputBinding:
      position: 101
  - id: continue_on_error
    type:
      - 'null'
      - boolean
    doc: Continue processing all files even if an error is found
    inputBinding:
      position: 101
      prefix: --continue-on-error
  - id: fastq_paired
    type:
      - 'null'
      - type: array
        items: grz_check_fastq_paired
        inputBinding:
          prefix: --fastq-paired
    doc: 'A paired-end FASTQ sample. Provide FQ1, FQ2, and minimum mean read length.
      Read Length: >0 for fixed, <0 to skip length check'
    inputBinding:
      position: 101
  - id: fastq_single
    type:
      - 'null'
      - type: array
        items: grz_check_fastq_single
        inputBinding:
          prefix: --fastq-single
    doc: 'A single-end FASTQ sample. Provide the file path and minimum mean read length.
      Read Length: >0 for fixed, <0 to skip length check'
    inputBinding:
      position: 101
  - id: raw
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: --raw
    doc: A file for which to only calculate the SHA256 checksum, skipping all 
      other validation
    inputBinding:
      position: 101
  - id: show_progress
    type:
      - 'null'
      - string
    doc: Flag to show progress bars during processing (true or false)
    inputBinding:
      position: 101
      prefix: --show-progress
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use for processing
    inputBinding:
      position: 101
      prefix: --threads
  - id: output_path
    type: string
    inputBinding:
      position: 102
      prefix: --output
outputs:
  - id: output
    type: File
    doc: Path to write the output JSONL report
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
  - class: SchemaDefRequirement
    types:
      - name: grz_check_fastq_paired
        type: record
        fields:
          - name: fq1_path
            type: File
            inputBinding:
              position: 1
          - name: fq2_path
            type: File
            inputBinding:
              position: 2
          - name: min_mean_read_len
            type: int
            inputBinding:
              position: 3
      - name: grz_check_fastq_single
        type: record
        fields:
          - name: fq_path
            type: File
            inputBinding:
              position: 1
          - name: min_mean_read_len
            type: int
            inputBinding:
              position: 2
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/grz-check:0.2.1--h3ec5717_0
