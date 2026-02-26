cwlVersion: v1.2
class: CommandLineTool
baseCommand: tribal_preprocess
label: tribal_preprocess
doc: "Preprocesses sequencing data for tribal analysis.\n\nTool homepage: https://github.com/elkebir-group/TRIBAL"
inputs:
  - id: cores
    type:
      - 'null'
      - int
    doc: number of cores to use
    default: 1
    inputBinding:
      position: 101
      prefix: --cores
  - id: data
    type: File
    doc: filename of csv file with the sequencing data
    inputBinding:
      position: 101
      prefix: --data
  - id: dataframe
    type:
      - 'null'
      - Directory
    doc: path to where the filtered dataframe with additional sequences and 
      isotype encodings should be saved.
    inputBinding:
      position: 101
      prefix: --dataframe
  - id: encoding
    type: File
    doc: filename isotype encodings
    inputBinding:
      position: 101
      prefix: --encoding
  - id: heavy
    type:
      - 'null'
      - boolean
    doc: only use the heavy chain and ignore the light chain
    inputBinding:
      position: 101
      prefix: --heavy
  - id: min_size
    type:
      - 'null'
      - int
    doc: minimum clonotype size
    default: 4
    inputBinding:
      position: 101
      prefix: --min-size
  - id: roots
    type: File
    doc: filename of csv file with the root sequences
    inputBinding:
      position: 101
      prefix: --roots
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: print additional messages
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: out
    type: Directory
    doc: path to where pickled clonotype dictionary input should be saved
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tribal:0.1.1--py310hdbdd923_1
