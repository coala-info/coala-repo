cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - amiga
  - compare
label: amiga_compare
doc: "Compare summary statistics for two growth curves\n\nTool homepage: https://github.com/firasmidani/amiga"
inputs:
  - id: input
    type:
      type: array
      items: File
      inputBinding:
        prefix: --input
    doc: Summary file(s) of growth parameters (from amiga fit with pooled replicates)
    inputBinding:
      position: 1
  - id: output
    type: string
    doc: "ouptut filename including path (without extension; .txt is added)"
    inputBinding:
      position: 1
      prefix: --output
  - id: subset
    type: string
    doc: "Two conditions to compare (e.g. 'Ribotype:RT053;Substrate:Fructose;Concentration:Low,High')"
    inputBinding:
      position: 1
      prefix: --subset
  - id: confidence
    type: ['null', float]
    doc: "Must be between 80 and 100. Default is 95."
    inputBinding:
      position: 1
      prefix: --confidence
  - id: verbose
    type: ['null', boolean]
    doc: "Print verbose messages"
    inputBinding:
      position: 1
      prefix: --verbose
outputs:
  - id: comparison
    type: File
    doc: Table comparing the growth parameters of the two conditions
    outputBinding:
      glob: $(inputs.output).txt
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/amiga:3.0.4--pyhdfd78af_1
