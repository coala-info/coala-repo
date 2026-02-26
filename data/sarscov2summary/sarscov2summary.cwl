cwlVersion: v1.2
class: CommandLineTool
baseCommand: sarscov2summary
label: sarscov2summary
doc: "Summarize selection analysis results.\n\nTool homepage: https://github.com/nickeener/sarscov2formatter"
inputs:
  - id: coordinates
    type: File
    doc: An alignment with reference sequence (assumed to start with NC)
    inputBinding:
      position: 101
      prefix: --coordinates
  - id: database
    type: string
    doc: Primary database record to extract sequence information from
    inputBinding:
      position: 101
      prefix: --database
  - id: duplicates
    type: File
    doc: The JSON file recording compressed sequence duplicates
    inputBinding:
      position: 101
      prefix: --duplicates
  - id: evolutionary_annotation
    type:
      - 'null'
      - File
    doc: If provided use evolutionary likelihood annotation
    inputBinding:
      position: 101
      prefix: --evolutionary_annotation
  - id: evolutionary_fragment
    type:
      - 'null'
      - string
    doc: Used in conjunction with evolutionary annotation to designate the 
      fragment to look up
    inputBinding:
      position: 101
      prefix: --evolutionary_fragment
  - id: fel
    type: File
    doc: FEL results file
    inputBinding:
      position: 101
      prefix: --fel
  - id: maf
    type:
      - 'null'
      - float
    doc: Also include sites with hapoltype MAF >= this frequency
    inputBinding:
      position: 101
      prefix: --MAF
  - id: meme
    type: File
    doc: MEME results file
    inputBinding:
      position: 101
      prefix: --meme
  - id: prime
    type:
      - 'null'
      - File
    doc: PRIME results file
    inputBinding:
      position: 101
      prefix: --prime
  - id: pvalue
    type:
      - 'null'
      - float
    doc: p-value
    inputBinding:
      position: 101
      prefix: --pvalue
  - id: slac
    type: File
    doc: SLAC results file
    inputBinding:
      position: 101
      prefix: --slac
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Write results here
    outputBinding:
      glob: $(inputs.output)
  - id: mafs
    type:
      - 'null'
      - File
    doc: If provided, write a CSV file with MAF/p-value tables
    outputBinding:
      glob: $(inputs.mafs)
  - id: evolutionary_csv
    type:
      - 'null'
      - File
    doc: If provided, write a CSV file with observed/predicted frequncies
    outputBinding:
      glob: $(inputs.evolutionary_csv)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sarscov2summary:0.5--py_1
