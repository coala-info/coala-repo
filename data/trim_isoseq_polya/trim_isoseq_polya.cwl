cwlVersion: v1.2
class: CommandLineTool
baseCommand: trim_isoseq_polya
label: trim_isoseq_polya
doc: "Trim polyA tails from Iso-Seq reads.\n\nTool homepage: https://github.com/PacificBiosciences/trim_isoseq_polyA"
inputs:
  - id: input_fastq
    type: File
    doc: Input FASTQ file containing Iso-Seq reads.
    inputBinding:
      position: 1
  - id: max_polyA_len
    type:
      - 'null'
      - int
    doc: Maximum length of polyA tail to consider. Default is 30.
    inputBinding:
      position: 102
      prefix: --max-polyA-len
  - id: min_polyA_len
    type:
      - 'null'
      - int
    doc: Minimum length of polyA tail to trim. Default is 10.
    inputBinding:
      position: 102
      prefix: --min-polyA-len
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use. Default is 1.
    inputBinding:
      position: 102
      prefix: --threads
  - id: trim_threshold
    type:
      - 'null'
      - float
    doc: Threshold for trimming polyA tail (e.g., 0.9 means trim if 90% of the 
      tail is A). Default is 0.9.
    inputBinding:
      position: 102
      prefix: --trim-threshold
outputs:
  - id: output_fastq
    type: File
    doc: Output FASTQ file with polyA tails trimmed.
    outputBinding:
      glob: $(inputs.output_fastq)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/trim_isoseq_polya:0.0.3--h7c8eefc_0
