cwlVersion: v1.2
class: CommandLineTool
baseCommand: rapifilt
label: rapifilt
doc: "RAPId FILTer\n\nTool homepage: https://github.com/andvides/RAPIFILT.git"
inputs:
  - id: bin_size_statistic
    type:
      - 'null'
      - int
    doc: Bin size used to compute statistic per base
    default: 1
    inputBinding:
      position: 101
      prefix: -bin
  - id: enable_fasta_output
    type:
      - 'null'
      - boolean
    doc: Enable fasta output (default fastq)
    default: false
    inputBinding:
      position: 101
      prefix: -f
  - id: fastq_input
    type:
      - 'null'
      - File
    doc: single fastq input (file.fastq) the file can be gz compressed
    inputBinding:
      position: 101
      prefix: -fastq
  - id: illumina_inputs
    type:
      - 'null'
      - type: array
        items: File
    doc: Illumina inputs(file1.fastq file2.fastq) the files can be gz compressed
    inputBinding:
      position: 101
      prefix: -i
  - id: lef_cut_quality
    type:
      - 'null'
      - int
    doc: Set lef-cut value for quality scores
    default: 0
    inputBinding:
      position: 101
      prefix: -l
  - id: max_len
    type:
      - 'null'
      - int
    doc: Filter sequence larger than max_len
    default: 5000
    inputBinding:
      position: 101
      prefix: -mx
  - id: min_len
    type:
      - 'null'
      - int
    doc: Filter sequence shorter than min_len
    default: 1
    inputBinding:
      position: 101
      prefix: -m
  - id: remove_bases_from_begin
    type:
      - 'null'
      - int
    doc: Remove n bases from the begins of sequencing fragments
    default: 0
    inputBinding:
      position: 101
      prefix: -tb
  - id: remove_bases_from_end
    type:
      - 'null'
      - int
    doc: Remove n bases from the ends of sequencing fragments
    default: 0
    inputBinding:
      position: 101
      prefix: -te
  - id: right_cut_quality
    type:
      - 'null'
      - int
    doc: Set right-cut value for quality scores
    default: 0
    inputBinding:
      position: 101
      prefix: -r
  - id: sff_input
    type:
      - 'null'
      - File
    doc: 454 input (file.sff)
    inputBinding:
      position: 101
      prefix: -sff
  - id: window_size_quality_scores
    type:
      - 'null'
      - int
    doc: Set windows size to check on the quality scores
    default: 1
    inputBinding:
      position: 101
      prefix: -w
outputs:
  - id: output_fastq_file
    type:
      - 'null'
      - File
    doc: Desired fastq output file. If not specified to stdout
    outputBinding:
      glob: $(inputs.output_fastq_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rapifilt:1.0--h5ca1c30_7
