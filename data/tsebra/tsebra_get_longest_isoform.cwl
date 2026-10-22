cwlVersion: v1.2
class: CommandLineTool
baseCommand: get_longest_isoform.py
label: tsebra_get_longest_isoform
doc: "Combine gene sets by choosing the isoform with the longest coding sequence for each gene locus.\n\nTool homepage: https://github.com/Gaius-Augustus/TSEBRA"
inputs:
  - id: gtf
    type:
      type: array
      items: File
    doc: "List of gene prediction files in GTF (joined with commas)"
    inputBinding:
      position: 101
      prefix: -g
      itemSeparator: ','
  - id: out_path
    type: string
    doc: "Output file for the combined gene prediction in GTF"
    inputBinding:
      position: 101
      prefix: -o
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: "Quiet mode"
    inputBinding:
      position: 101
      prefix: -q
  - id: verbose
    type:
      - 'null'
      - int
    doc: "Verbosity level"
    inputBinding:
      position: 101
      prefix: -v
outputs:
  - id: out
    type: File
    doc: "Gene prediction with the longest isoform per locus"
    outputBinding:
      glob: "$(inputs.out_path)"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tsebra:1.1.2.5--pyhca03a8a_0
