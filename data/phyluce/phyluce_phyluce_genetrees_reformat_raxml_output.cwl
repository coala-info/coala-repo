cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phyluce_genetrees_reformat_raxml_output
label: phyluce_phyluce_genetrees_reformat_raxml_output
doc: "Program description\n\nTool homepage: https://github.com/faircloth-lab/phyluce"
inputs:
  - id: genetrees
    type:
      - 'null'
      - Directory
    doc: "The path to the directory containing RAxML best trees"
    inputBinding:
      position: 1
      prefix: --genetrees
  - id: bootreps
    type:
      - 'null'
      - Directory
    doc: "The path to the directory containing RAxML bootreps"
    inputBinding:
      position: 2
      prefix: --bootreps
  - id: output
    type: string
    doc: "The output file name"
    inputBinding:
      position: 3
      prefix: --output
outputs:
  - id: genetrees_file
    type:
      - 'null'
      - File
    doc: "The reformatted best trees (<output>.genetrees)."
    outputBinding:
      glob: "$(inputs.output).genetrees"
  - id: bootreps_file
    type:
      - 'null'
      - File
    doc: "The reformatted bootstrap replicates (<output>.bootreps)."
    outputBinding:
      glob: "$(inputs.output).bootreps"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyluce:1.6.8--py_0
