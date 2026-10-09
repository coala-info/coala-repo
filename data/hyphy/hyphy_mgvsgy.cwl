cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hyphy
  - mgvsgy
label: hyphy_mgvsgy
doc: "Compare the fits of MG94 and GY94 models (crossed with an arbitrary nucleotide bias) on codon data.\n\nTool homepage: http://hyphy.org/"
inputs:
  - id: genetic_code
    type: string
    doc: "Genetic code name, for example Universal. HyPhy asks for this at a prompt; it is passed as a positional answer (prompts are answered in the order of the position numbers)."
    inputBinding:
      position: 1
  - id: model_designation
    type: string
    doc: "Six character nucleotide model designation, for example 010010 for HKY85. HyPhy asks for this at a prompt; it is passed as a positional answer (prompts are answered in the order of the position numbers)."
    inputBinding:
      position: 2
  - id: kh_samples
    type: int
    doc: "Number of samples for the KH test (0 to skip the test). HyPhy asks for this at a prompt; it is passed as a positional answer (prompts are answered in the order of the position numbers)."
    inputBinding:
      position: 3
  - id: branch_lengths
    type: string
    doc: "Branch lengths: Codon Model or Nucleotide Model. HyPhy asks for this at a prompt; it is passed as a positional answer (prompts are answered in the order of the position numbers)."
    inputBinding:
      position: 4
  - id: data_file
    type: File
    doc: "Codon data file (with a tree, or give tree_file). HyPhy asks for this at a prompt; it is passed as a positional answer (prompts are answered in the order of the position numbers)."
    inputBinding:
      position: 5
  - id: use_tree_in_data
    type:
      - 'null'
      - string
    doc: "Answer Y to use the tree found in the data file, N to be asked for a tree file. HyPhy asks for this at a prompt; it is passed as a positional answer (prompts are answered in the order of the position numbers)."
    inputBinding:
      position: 6
outputs:
  - id: stdout
    type: stdout
    doc: Standard output with the analysis results
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hyphy:2.5.94--h5837470_0
stdout: hyphy_mgvsgy.out
