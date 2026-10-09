cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hyphy
  - mclk
label: hyphy_mclk
doc: "Test for the presence of a global molecular clock on the tree using its root.\n\nTool homepage: http://hyphy.org/"
inputs:
  - id: cpu
    type:
      - 'null'
      - int
    doc: "Number of threads to use (HyPhy CPU= argument)."
    inputBinding:
      position: 0
      prefix: CPU=
      separate: false
  - id: data_type
    type: string
    doc: "Data type: Nucleotide/Protein or Codon. HyPhy asks for this at a prompt; it is passed as a positional answer (prompts are answered in the order of the position numbers)."
    inputBinding:
      position: 1
  - id: genetic_code
    type:
      - 'null'
      - string
    doc: "Genetic code name (only for codon data), for example Universal. HyPhy asks for this at a prompt; it is passed as a positional answer (prompts are answered in the order of the position numbers)."
    inputBinding:
      position: 2
  - id: data_file
    type: File
    doc: "Data file. HyPhy asks for this at a prompt; it is passed as a positional answer (prompts are answered in the order of the position numbers)."
    inputBinding:
      position: 3
  - id: model_answers
    type:
      - 'null'
      - type: array
        items: string
    doc: "Answers to the model selection prompts in order, for example HKY85 then Global. HyPhy asks for this at a prompt; it is passed as a positional answer (prompts are answered in the order of the position numbers)."
    inputBinding:
      position: 4
  - id: use_tree_in_data
    type:
      - 'null'
      - string
    doc: "Answer Y to use the tree found in the data file. HyPhy asks for this at a prompt; it is passed as a positional answer (prompts are answered in the order of the position numbers)."
    inputBinding:
      position: 5
  - id: tree_file
    type:
      - 'null'
      - File
    doc: "Tree file, asked for when the data file holds no tree. HyPhy asks for this at a prompt; it is passed as a positional answer (prompts are answered in the order of the position numbers)."
    inputBinding:
      position: 6
outputs:
  - id: stdout
    type: stdout
    doc: Standard output with the analysis results
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hyphy:2.5.94--h5837470_0
stdout: hyphy_mclk.out
