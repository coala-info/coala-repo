cwlVersion: v1.2
class: CommandLineTool
baseCommand: multinomial
label: evofold2_multinomial
doc: "multinomial calculates probabilities of category counts under the multinomial distribution. By default all input and output files use named data format.\n\nTool homepage: https://github.com/jakob-skou-pedersen/phy"
inputs:
  - id: precision
    type:
      - 'null'
      - int
    doc: "Output precision of real numbers (default 5)"
    inputBinding:
      position: 1
      prefix: --precision
  - id: coefficients
    type:
      - 'null'
      - boolean
    doc: "Output coefficients instead of probabilities"
    inputBinding:
      position: 2
      prefix: --coefficients
  - id: output_format
    type:
      - 'null'
      - string
    doc: "Use alternative output format: vector, rowMat or colMat (ublas style formatting)"
    inputBinding:
      position: 3
      prefix: --outputFormat
  - id: logarithm
    type:
      - 'null'
      - boolean
    doc: "Output natural logarithm of result values"
    inputBinding:
      position: 4
      prefix: --logarithm
  - id: parameters
    type: File
    doc: "Category probabilities (named data format)"
    inputBinding:
      position: 100
  - id: counts
    type: File
    doc: "Category counts (named data format)"
    inputBinding:
      position: 101
  - id: output_file
    type: string
    doc: "Output file"
    inputBinding:
      position: 102
outputs:
  - id: result
    type: File
    doc: "Multinomial probabilities"
    outputBinding:
      glob: $(inputs.output_file)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/evofold2:0.1--0
