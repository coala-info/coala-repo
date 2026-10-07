cwlVersion: v1.2
class: CommandLineTool
baseCommand: CPC2.py
label: cpc2
doc: "CPC2 (Coding Potential Calculator 2) is a fast and accurate tool to assess the
  coding potential of RNA sequences.\n\nTool homepage: https://github.com/gao-lab/CPC2_standalone"
inputs:
  - id: input_file
    type: File
    doc: Input sequence in FASTA format
    inputBinding:
      position: 101
      prefix: -i
  - id: reverse
    type:
      - 'null'
      - boolean
    doc: Also check the reverse strand
    inputBinding:
      position: 101
      prefix: -r
  - id: orf
    type:
      - 'null'
      - boolean
    doc: Output the start position of longest ORF
    inputBinding:
      position: 101
      prefix: --ORF
  - id: output_prefix
    type: string
    doc: Output file name; CPC2 adds '.txt' to it (default cpc2output gives 
      cpc2output.txt)
    inputBinding:
      position: 102
      prefix: -o
outputs:
  - id: output_file
    type: File
    doc: Tab-separated coding potential results
    outputBinding:
      glob: $(inputs.output_prefix).txt
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cpc2:1.0.1--hdfd78af_0
