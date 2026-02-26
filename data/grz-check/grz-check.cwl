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
    doc: A single BAM file to validate
    inputBinding:
      position: 101
      prefix: --bam
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
        items: string
    doc: 'A paired-end FASTQ sample. Provide FQ1, FQ2, and minimum mean read length.
      Read Length: >0 for fixed, <0 to skip length check'
    inputBinding:
      position: 101
      prefix: --fastq-paired
  - id: fastq_single
    type:
      - 'null'
      - type: array
        items: string
    doc: 'A single-end FASTQ sample. Provide the file path and minimum mean read length.
      Read Length: >0 for fixed, <0 to skip length check'
    inputBinding:
      position: 101
      prefix: --fastq-single
  - id: raw
    type:
      - 'null'
      - type: array
        items: File
    doc: A file for which to only calculate the SHA256 checksum, skipping all 
      other validation
    inputBinding:
      position: 101
      prefix: --raw
  - id: show_progress
    type:
      - 'null'
      - boolean
    doc: Flag to show progress bars during processing
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
outputs:
  - id: output
    type: File
    doc: Path to write the output JSONL report
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/grz-check:0.2.1--h3ec5717_0
