cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - HmnTrimmer
  - HmnTrimmer
label: hmntrimmer_HmnTrimmer
doc: "HmnTrimmer, a trimmer of NGS reads\n\nTool homepage: https://github.com/guillaume-gricourt/HmnTrimmer"
inputs:
  - id: information_dust
    type:
      - 'null'
      - int
    doc: Information dust trimmer
    inputBinding:
      position: 101
      prefix: --information-dust
  - id: information_n
    type:
      - 'null'
      - int
    doc: Information N trimmer
    inputBinding:
      position: 101
      prefix: --information-n
  - id: input_fastq_forward
    type:
      - 'null'
      - File
    doc: 'File with read forward for apply trimmers. Valid filetypes are: .fq[.*]
      and .fastq[.*]'
    inputBinding:
      position: 101
      prefix: --input-fastq-forward
  - id: input_fastq_interleaved
    type:
      - 'null'
      - File
    doc: 'File with read interleaved Valid filetypes are: .fq[.*] and .fastq[.*]'
    inputBinding:
      position: 101
      prefix: --input-fastq-interleaved
  - id: input_fastq_reverse
    type:
      - 'null'
      - File
    doc: 'File with read reverse for apply trimmers. Valid filetypes are: .fq[.*]
      and .fastq[.*]'
    inputBinding:
      position: 101
      prefix: --input-fastq-reverse
  - id: length_min
    type:
      - 'null'
      - int
    doc: Minimum length trimmer
    inputBinding:
      position: 101
      prefix: --length-min
  - id: quality_sliding_window
    type:
      - 'null'
      - string
    doc: Quality sliding window trimmer configuration
    inputBinding:
      position: 101
      prefix: --quality-sliding-window
  - id: quality_tail
    type:
      - 'null'
      - string
    doc: Quality tail trimmer configuration
    inputBinding:
      position: 101
      prefix: --quality-tail
  - id: reads_batch
    type:
      - 'null'
      - int
    doc: Specify the number of reads to process in one batch. In range 
      [100..50000000].
    inputBinding:
      position: 101
      prefix: --reads-batch
  - id: threads
    type:
      - 'null'
      - int
    doc: Specify the number of threads to use. In range [1..8].
    inputBinding:
      position: 101
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - int
    doc: Specify the log level to use In range [1..6].
    inputBinding:
      position: 101
      prefix: --verbose
  - id: version_check
    type:
      - 'null'
      - boolean
    doc: Turn this option off to disable version update notifications of the 
      application. One of 1, ON, TRUE, T, YES, 0, OFF, FALSE, F, and NO.
    inputBinding:
      position: 101
      prefix: --version-check
outputs:
  - id: output_fastq_forward
    type:
      - 'null'
      - File
    doc: 'File with write forward trimmed. Valid filetypes are: .fq[.*] and .fastq[.*]'
    outputBinding:
      glob: $(inputs.output_fastq_forward)
  - id: output_fastq_reverse
    type:
      - 'null'
      - File
    doc: 'File with write reverse trimmed. Valid filetypes are: .fq[.*] and .fastq[.*]'
    outputBinding:
      glob: $(inputs.output_fastq_reverse)
  - id: output_fastq_interleaved
    type:
      - 'null'
      - File
    doc: 'File with write reverse trimmed. Valid filetypes are: .fq[.*] and .fastq[.*]'
    outputBinding:
      glob: $(inputs.output_fastq_interleaved)
  - id: output_fastq_discard
    type:
      - 'null'
      - File
    doc: 'File with discard sequences. Valid filetypes are: .fq[.*] and .fastq[.*]'
    outputBinding:
      glob: $(inputs.output_fastq_discard)
  - id: output_report
    type:
      - 'null'
      - File
    doc: 'File output report Valid filetype is: .json.'
    outputBinding:
      glob: $(inputs.output_report)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hmntrimmer:0.6.5--he93f0d0_1
