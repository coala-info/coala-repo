cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - samtools
  - idxstats
label: samtools_idxstats
doc: Reports alignment summary statistics from a BAM index file
inputs:
  - id: in_bam
    type: File
    doc: Input BAM file
    inputBinding:
      position: 1
  - id: customized_index
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
      - string
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
    inputBinding:
      position: 102
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/samtools:1.23--h96c455f_0
stdout: samtools_idxstats.out
s:url: https://github.com/samtools/samtools
$namespaces:
  s: https://schema.org/
