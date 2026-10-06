cwlVersion: v1.2
class: CommandLineTool
baseCommand: bracken
label: bracken
doc: "Estimates the abundance of organisms in a metagenomic sample using Kraken and
  Bracken.\n\nTool homepage: https://github.com/jenniferlu717/Bracken"
inputs:
  - id: database
    type: Directory
    doc: location of Kraken database
    inputBinding:
      position: 101
      prefix: -d
  - id: input_report
    type: File
    doc: Kraken REPORT file to use for abundance estimation
    inputBinding:
      position: 101
      prefix: -i
  - id: level
    type: string
    doc: 'level to estimate abundance at [options: D,P,C,O,F,G,S,S1,etc]'
    inputBinding:
      position: 101
      prefix: -l
  - id: read_length
    type: int
    doc: read length to get all classifications for
    inputBinding:
      position: 101
      prefix: -r
  - id: threshold
    type: int
    doc: number of reads required PRIOR to abundance estimation to perform 
      reestimation
    inputBinding:
      position: 101
      prefix: -t
  - id: output_file_path
    type: string
    doc: file name for Bracken default output
    inputBinding:
      position: 102
      prefix: -o
  - id: output_report_path
    type:
      - 'null'
      - string
    doc: New Kraken REPORT output file with Bracken read estimates
    inputBinding:
      position: 103
      prefix: -w
outputs:
  - id: output_file
    type: File
    doc: file name for Bracken default output
    outputBinding:
      glob: $(inputs.output_file_path)
  - id: output_report
    type:
      - 'null'
      - File
    doc: New Kraken REPORT output file with Bracken read estimates
    outputBinding:
      glob: $(inputs.output_report_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bracken:3.1--h9948957_0
