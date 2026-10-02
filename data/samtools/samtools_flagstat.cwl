cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - samtools
  - flagstat
label: samtools_flagstat
doc: Output stats for input BAM file
inputs:
  - id: in_bam
    type: File
    doc: Input BAM file
    inputBinding:
      position: 1
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
  - id: output_fmt
    type:
      - 'null'
      - string
    doc: Specify output format (json, tsv)
    inputBinding:
      position: 102
      prefix: --output-fmt
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/samtools:1.23--h96c455f_0
stdout: samtools_flagstat.out
s:url: https://github.com/samtools/samtools
$namespaces:
  s: https://schema.org/
