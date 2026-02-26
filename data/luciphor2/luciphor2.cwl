cwlVersion: v1.2
class: CommandLineTool
baseCommand: java -jar luciphor2.jar
label: luciphor2
doc: "JAVA-based version of Luciphor\n\nTool homepage: http://luciphor2.sourceforge.net/"
inputs:
  - id: input_file
    type: File
    doc: Input file for luciphor2
    inputBinding:
      position: 1
  - id: generate_input
    type:
      - 'null'
      - boolean
    doc: Generate a luciphor2 input file
    inputBinding:
      position: 102
      prefix: -t
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/luciphor2:2020_04_03--hdfd78af_1
stdout: luciphor2.out
