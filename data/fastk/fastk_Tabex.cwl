cwlVersion: v1.2
class: CommandLineTool
baseCommand: Tabex
label: fastk_Tabex
doc: "Tabex is a tool for extracting k-mers from k-mer tables.\n\nTool homepage: https://github.com/thegenemyers/FASTK"
inputs:
  - id: source
    type: File
    doc: Input k-mer table file (optional .ktab extension)
    inputBinding:
      position: 1
  - id: address
    type:
      - 'null'
      - type: array
        items: string
    doc: Address or range of addresses to extract (e.g., <int> or <dna:string>)
    inputBinding:
      position: 2
  - id: check_sorting
    type:
      - 'null'
      - boolean
    doc: Check sorting
    inputBinding:
      position: 103
      prefix: -C
  - id: one_code_output
    type:
      - 'null'
      - boolean
    doc: Produce 1-code as output
    inputBinding:
      position: 103
      prefix: '-1'
  - id: output_ascii
    type:
      - 'null'
      - boolean
    doc: Output tab-delimited ASCII
    inputBinding:
      position: 103
      prefix: -A
  - id: trim_threshold
    type:
      - 'null'
      - int
    doc: Trim all k-mers with counts less than threshold
    inputBinding:
      position: 103
      prefix: -t
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastk:1.2--h71df26d_1
stdout: fastk_Tabex.out
