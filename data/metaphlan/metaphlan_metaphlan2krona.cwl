cwlVersion: v1.2
class: CommandLineTool
baseCommand: metaphlan2krona.py
label: metaphlan_metaphlan2krona
doc: "Convert a MetaPhlAn standard result file into the input format of Krona.\n\nTool homepage: https://github.com/biobakery/metaphlan"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: profile
    type: File
    doc: "The input file is the MetaPhlAn standard result file"
    inputBinding:
      position: 101
      prefix: "--profile"
  - id: krona
    type: string
    doc: "The Krona output file name"
    inputBinding:
      position: 101
      prefix: "--krona"
outputs:
  - id: krona_out
    type: File
    doc: "Krona input table"
    outputBinding:
      glob: "$(inputs.krona)"
  - id: stdout
    type: stdout
    doc: "Standard output"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metaphlan:4.2.4--pyhdfd78af_0
stdout: metaphlan_metaphlan2krona.out
