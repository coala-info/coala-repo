cwlVersion: v1.2
class: CommandLineTool
baseCommand: PIACli
label: pia
doc: "PIA - Protein Inference Algorithms. Performs compilation or analysis of protein
  search results.\n\nTool homepage: https://github.com/medbioinf/pia"
inputs:
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: 'input file(s): search results for the compilation, json and intermediate
      file for analysis. For the search results, possible further information can
      be passed, separated by semicolon.'
    inputBinding:
      position: 1
  - id: compile
    type:
      - 'null'
      - boolean
    doc: perform a compilation, otherwise perform analysis
    inputBinding:
      position: 102
      prefix: --compile
  - id: example
    type:
      - 'null'
      - boolean
    doc: returns an example json for a PIA analysis
    inputBinding:
      position: 102
      prefix: --example
  - id: name
    type:
      - 'null'
      - string
    doc: name of the compilation
    inputBinding:
      position: 102
      prefix: --name
  - id: threads
    type:
      - 'null'
      - int
    doc: maximum number of used threads for compilation (0 for use all)
    default: 0
    inputBinding:
      position: 102
      prefix: --threads
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: output file name (e.g. intermediate PIA file)
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pia:1.5.7--hdfd78af_0
