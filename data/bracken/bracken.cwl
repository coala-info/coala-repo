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
    default: S
    inputBinding:
      position: 101
      prefix: -l
  - id: read_length
    type: int
    doc: read length to get all classifications for
    default: 100
    inputBinding:
      position: 101
      prefix: -r
  - id: threshold
    type: int
    doc: number of reads required PRIOR to abundance estimation to perform 
      reestimation
    default: 0
    inputBinding:
      position: 101
      prefix: -t
outputs:
  - id: output_file
    type: File
    doc: file name for Bracken default output
    outputBinding:
      glob: $(inputs.output_file)
  - id: output_report
    type: File
    doc: New Kraken REPORT output file with Bracken read estimates
    outputBinding:
      glob: $(inputs.output_report)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bracken:3.1--h9948957_0
