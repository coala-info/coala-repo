cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - taxon_filter.py
  - trim_trimmomatic
label: viral-ngs_taxon_filter_trim_trimmomatic
doc: "Trim read sequences with Trimmomatic.\n\nTool homepage: https://github.com/broadinstitute/viral-ngs"
inputs:
  - id: in_fastq1
    type: File
    doc: "Input reads 1"
    inputBinding:
      position: 1
  - id: in_fastq2
    type: File
    doc: "Input reads 2"
    inputBinding:
      position: 2
  - id: paired_out_fastq1
    type: string
    doc: "Paired output 1"
    inputBinding:
      position: 3
  - id: paired_out_fastq2
    type: string
    doc: "Paired output 2"
    inputBinding:
      position: 4
  - id: clip_fasta
    type: File
    doc: "Fasta file with adapters, PCR sequences, etc. to clip off"
    inputBinding:
      position: 5
  - id: unpaired_out_fastq1
    type:
      - 'null'
      - string
    doc: "Unpaired output 1 (default: write to temp and discard)"
    inputBinding:
      position: 20
      prefix: --unpairedOutFastq1
  - id: unpaired_out_fastq2
    type:
      - 'null'
      - string
    doc: "Unpaired output 2 (default: write to temp and discard)"
    inputBinding:
      position: 20
      prefix: --unpairedOutFastq2
  - id: leading_q_cutoff
    type:
      - 'null'
      - int
    doc: "minimum quality required to keep a base on the leading end (default: 15)"
    inputBinding:
      position: 20
      prefix: --leadingQCutoff
  - id: trailing_q_cutoff
    type:
      - 'null'
      - int
    doc: "minimum quality required to keep a base on the trailing end (default: 15)"
    inputBinding:
      position: 20
      prefix: --trailingQCutoff
  - id: minlength_to_keep
    type:
      - 'null'
      - int
    doc: "minimum length of reads to be kept (default: 30)"
    inputBinding:
      position: 20
      prefix: --minlengthToKeep
  - id: sliding_window_size
    type:
      - 'null'
      - int
    doc: "the number of bases to average across (default: 4)"
    inputBinding:
      position: 20
      prefix: --slidingWindowSize
  - id: sliding_window_q_cutoff
    type:
      - 'null'
      - int
    doc: "specifies the average quality required in the sliding window (default: 25)"
    inputBinding:
      position: 20
      prefix: --slidingWindowQCutoff
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
  - id: paired_out_fastq1_file
    type: File
    doc: "Paired output 1"
    outputBinding:
      glob: $(inputs.paired_out_fastq1)
  - id: paired_out_fastq2_file
    type: File
    doc: "Paired output 2"
    outputBinding:
      glob: $(inputs.paired_out_fastq2)
  - id: unpaired_out_fastq1_file
    type:
      - 'null'
      - File
    doc: "Unpaired output 1"
    outputBinding:
      glob: $(inputs.unpaired_out_fastq1)
  - id: unpaired_out_fastq2_file
    type:
      - 'null'
      - File
    doc: "Unpaired output 2"
    outputBinding:
      glob: $(inputs.unpaired_out_fastq2)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
stdout: viral-ngs_taxon_filter_trim_trimmomatic.out
