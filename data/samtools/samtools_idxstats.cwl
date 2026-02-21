cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - samtools
  - idxstats
label: samtools_idxstats
doc: "Reports alignment statistics from a BAM index file, including sequence names,
  sequence lengths, number of mapped reads, and number of unmapped reads.\n\nTool
  homepage: https://github.com/samtools/samtools"
inputs:
  - id: input_bam
    type: File
    doc: Input BAM file
    inputBinding:
      position: 1
  - id: custom_index
    type:
      - 'null'
      - boolean
    doc: Include customized index file
    inputBinding:
      position: 102
      prefix: -X
  - id: input_fmt_option
    type:
      - 'null'
      - type: array
        items: string
    doc: Specify a single input file format option in the form of OPTION or 
      OPTION=VALUE
    inputBinding:
      position: 102
      prefix: --input-fmt-option
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of additional threads to use
    default: 0
    inputBinding:
      position: 102
      prefix: --threads
  - id: verbosity
    type:
      - 'null'
      - int
    doc: Set level of verbosity
    inputBinding:
      position: 102
      prefix: --verbosity
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/samtools:1.23--h96c455f_0
stdout: samtools_idxstats.out
