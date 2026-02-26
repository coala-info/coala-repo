cwlVersion: v1.2
class: CommandLineTool
baseCommand: rrmscorer
label: rrmscorer
doc: "RRM-RNA scoring version 1.0.11\n\nTool homepage: https://bio2byte.be/rrmscorer/"
inputs:
  - id: adjust_scores
    type:
      - 'null'
      - boolean
    doc: Add 0.89 to scores to better separate training and randomized regions 
      (positive scores indicate likely binders, negative scores indicate less 
      likely binders)
    inputBinding:
      position: 101
      prefix: --adjust-scores
  - id: fasta_file
    type:
      - 'null'
      - File
    doc: Fasta file path
    inputBinding:
      position: 101
      prefix: --fasta
  - id: plot_title
    type:
      - 'null'
      - string
    doc: Title for the generated plots
    inputBinding:
      position: 101
      prefix: --title
  - id: rna_sequence
    type:
      - 'null'
      - string
    doc: RNA sequence
    inputBinding:
      position: 101
      prefix: --rna
  - id: top
    type:
      - 'null'
      - boolean
    doc: To find the top scoring RNA fragments
    inputBinding:
      position: 101
      prefix: --top
  - id: uniprot_id
    type:
      - 'null'
      - string
    doc: UniProt identifier
    inputBinding:
      position: 101
      prefix: --uniprot
  - id: window_size
    type:
      - 'null'
      - int
    doc: The window size to test
    inputBinding:
      position: 101
      prefix: --window_size
  - id: wrap_title
    type:
      - 'null'
      - boolean
    doc: Wrap long titles to multiple lines
    inputBinding:
      position: 101
      prefix: --wrap-title
  - id: x_max
    type:
      - 'null'
      - float
    doc: Maximum value for x-axis in plots
    default: 1.0
    inputBinding:
      position: 101
      prefix: --x_max
  - id: x_min
    type:
      - 'null'
      - float
    doc: Minimum value for x-axis in plots
    default: -0.9
    inputBinding:
      position: 101
      prefix: --x_min
outputs:
  - id: json_output_dir
    type:
      - 'null'
      - Directory
    doc: Store the results in a json file in the declared directory path
    outputBinding:
      glob: $(inputs.json_output_dir)
  - id: csv_output_dir
    type:
      - 'null'
      - Directory
    doc: Store the results in a CSV file in the declared directory path
    outputBinding:
      glob: $(inputs.csv_output_dir)
  - id: plot_output_dir
    type:
      - 'null'
      - Directory
    doc: Store the plots in the declared directory path
    outputBinding:
      glob: $(inputs.plot_output_dir)
  - id: aligned_output_dir
    type:
      - 'null'
      - Directory
    doc: Store the aligned sequences in the declared directory path
    outputBinding:
      glob: $(inputs.aligned_output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rrmscorer:1.0.11--pyhdfd78af_0
