cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hyphy
  - mt
label: hyphy_mt
doc: "Select an evolutionary model for nucleotide data, using the methods of ModelTest by David Posada and Keith Crandall.\n\nTool homepage: http://hyphy.org/"
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
  - id: data_file
    type: File
    doc: "Nucleotide data file. HyPhy asks for this at a prompt; it is passed as a positional answer (prompts are answered in the order of the position numbers)."
    inputBinding:
      position: 1
  - id: use_tree_in_data
    type:
      - 'null'
      - string
    doc: "Answer Y to use the tree found in the data file. HyPhy asks for this at a prompt; it is passed as a positional answer (prompts are answered in the order of the position numbers)."
    inputBinding:
      position: 2
  - id: tree_file
    type:
      - 'null'
      - File
    doc: "Tree file, asked for when the data file holds no tree. HyPhy asks for this at a prompt; it is passed as a positional answer (prompts are answered in the order of the position numbers)."
    inputBinding:
      position: 3
  - id: rate_classes
    type: int
    doc: "Number of rate classes in rate variation models (for example 4). HyPhy asks for this at a prompt; it is passed as a positional answer (prompts are answered in the order of the position numbers)."
    inputBinding:
      position: 4
  - id: selection_method
    type: string
    doc: "Model selection method: Hierarchical Test, AIC Test or Both. HyPhy asks for this at a prompt; it is passed as a positional answer (prompts are answered in the order of the position numbers)."
    inputBinding:
      position: 5
  - id: rejection_level
    type:
      - 'null'
      - float
    doc: "Model rejection level (for example 0.05), asked for by the hierarchical test. HyPhy asks for this at a prompt; it is passed as a positional answer (prompts are answered in the order of the position numbers)."
    inputBinding:
      position: 6
  - id: hierarchical_fit_file
    type:
      - 'null'
      - string
    doc: "File name to save the hierarchical fit to. HyPhy asks for this at a prompt; it is passed as a positional answer (prompts are answered in the order of the position numbers)."
    inputBinding:
      position: 7
  - id: aic_fit_file
    type:
      - 'null'
      - string
    doc: "File name to save the AIC-based fit to. HyPhy asks for this at a prompt; it is passed as a positional answer (prompts are answered in the order of the position numbers)."
    inputBinding:
      position: 8
outputs:
  - id: stdout
    type: stdout
    doc: Standard output with the analysis results
  - id: fits
    type:
      type: array
      items: File
    doc: Saved model fits written to the working directory.
    outputBinding:
      glob: '*.bf'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hyphy:2.5.94--h5837470_0
stdout: hyphy_mt.out
