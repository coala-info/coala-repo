cwlVersion: v1.2
class: CommandLineTool
baseCommand: rnamining
label: rnamining
doc: "RNAmining: a deep learning stand-alone and web server tool for sequences coding
  prediction and RNA functional assignation\n\nTool homepage: https://github.com/lfreitasl/RNAmining/tree/pypackage"
inputs:
  - id: filename
    type: File
    doc: The filename with a sequence to predict
    inputBinding:
      position: 101
      prefix: --filename
  - id: organism_name
    type: string
    doc: 'The name of the organism you want to predict/train. Currently, the following
      organism names are suported in this tool: escherichia_coli, arabidopsis_thaliana,
      drosophila_melanogaster, homo_sapiens, mus_musculus, saccharomyces_cerevisiae'
    inputBinding:
      position: 101
      prefix: --organism_name
  - id: output_folder
    type: Directory
    doc: The output folder
    inputBinding:
      position: 101
      prefix: --output_folder
  - id: prediction_type
    type: string
    doc: The type of the sequence (coding_prediction, 
      ncRNA_functional_assignation)
    inputBinding:
      position: 101
      prefix: --prediction_type
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rnamining:1.0.4--pyhdfd78af_0
stdout: rnamining.out
