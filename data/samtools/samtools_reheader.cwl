cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - samtools
  - reheader
label: samtools_reheader
doc: "Replace the header in a SAM/BAM/CRAM file with a new header.\n\nTool homepage:
  https://github.com/samtools/samtools"
inputs:
  - id: header_file
    type:
      - 'null'
      - File
    doc: New header in SAM format. Required unless using the -c option.
    inputBinding:
      position: 1
  - id: input_file
    type: File
    doc: Input BAM or CRAM file to be reheadered.
    inputBinding:
      position: 2
  - id: command
    type:
      - 'null'
      - string
    doc: Pass the header in SAM format to external program CMD.
    inputBinding:
      position: 103
      prefix: --command
  - id: in_place
    type:
      - 'null'
      - boolean
    doc: Modify the CRAM file directly, if possible. (Defaults to outputting to 
      stdout.)
    inputBinding:
      position: 103
      prefix: --in-place
  - id: no_pg
    type:
      - 'null'
      - boolean
    doc: Do not generate a @PG header line.
    inputBinding:
      position: 103
      prefix: --no-PG
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/samtools:1.23--h96c455f_0
stdout: samtools_reheader.out
