cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - samtools
  - flagstat
label: samtools_flagstat
doc: "Counts the number of alignments for each FLAG type\n\nTool homepage: https://github.com/samtools/samtools"
inputs:
  - id: input_file
    type: File
    doc: Input BAM/SAM/CRAM file
    inputBinding:
      position: 1
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
  - id: output_fmt
    type:
      - 'null'
      - string
    doc: Specify output format (json, tsv)
    inputBinding:
      position: 102
      prefix: --output-fmt
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of additional threads to use
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
stdout: samtools_flagstat.out
