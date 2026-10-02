cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - samtools
  - head
label: samtools_head
doc: Display header and alignment record lines from a SAM/BAM/CRAM file
inputs:
  - id: file
    type:
      - 'null'
      - File
    doc: Input SAM/BAM/CRAM file
    inputBinding:
      position: 1
  - id: headers
    type:
      - 'null'
      - int
    doc: Display INT header lines [all]
    inputBinding:
      position: 102
      prefix: --headers
  - id: records
    type:
      - 'null'
      - int
    doc: Display INT alignment record lines [none]
    inputBinding:
      position: 102
      prefix: --records
  - id: input_fmt_option
    type:
      - 'null'
      - string
    doc: Specify a single input file format option in the form of OPTION or 
      OPTION=VALUE
    inputBinding:
      position: 102
      prefix: --input-fmt-option
  - id: reference
    type:
      - 'null'
      - File
    doc: Reference sequence FASTA FILE [null]
    secondaryFiles:
      - .fai
    inputBinding:
      position: 102
      prefix: --reference
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of additional threads to use [0]
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
stdout: samtools_head.out
s:url: https://github.com/samtools/samtools
$namespaces:
  s: https://schema.org/
