cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hyphy
  - mcc
label: hyphy_mcc
doc: "Compare mean within-clade branch length or pairwise divergence between two or more non-nested clades in a tree.\n\nTool homepage: http://hyphy.org/"
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
  - id: test_type
    type: string
    doc: "Test for: Mean branch length or Mean pairwise divergence. HyPhy asks for this at a prompt; it is passed as a positional answer (prompts are answered in the order of the position numbers)."
    inputBinding:
      position: 1
  - id: data_type
    type: string
    doc: "Data type: Nucleotide/Protein or Codon. HyPhy asks for this at a prompt; it is passed as a positional answer (prompts are answered in the order of the position numbers)."
    inputBinding:
      position: 2
  - id: genetic_code
    type:
      - 'null'
      - string
    doc: "Genetic code name (only for codon data), for example Universal. HyPhy asks for this at a prompt; it is passed as a positional answer (prompts are answered in the order of the position numbers)."
    inputBinding:
      position: 3
  - id: data_file
    type: File
    doc: "Data file. HyPhy asks for this at a prompt; it is passed as a positional answer (prompts are answered in the order of the position numbers)."
    inputBinding:
      position: 4
  - id: model_answers
    type:
      - 'null'
      - type: array
        items: string
    doc: "Answers to the model selection prompts in order, for example HKY85 then Global. HyPhy asks for this at a prompt; it is passed as a positional answer (prompts are answered in the order of the position numbers)."
    inputBinding:
      position: 5
  - id: use_tree_in_data
    type:
      - 'null'
      - string
    doc: "Answer Y to use the tree found in the data file. HyPhy asks for this at a prompt; it is passed as a positional answer (prompts are answered in the order of the position numbers)."
    inputBinding:
      position: 6
  - id: tree_file
    type:
      - 'null'
      - File
    doc: "Tree file whose clade roots are labeled Clade1, Clade2, ... (asked for when the data file holds no tree). HyPhy asks for this at a prompt; it is passed as a positional answer (prompts are answered in the order of the position numbers)."
    inputBinding:
      position: 7
outputs:
  - id: stdout
    type: stdout
    doc: Standard output with the analysis results
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hyphy:2.5.94--h5837470_0
stdout: hyphy_mcc.out
