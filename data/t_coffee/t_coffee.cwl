cwlVersion: v1.2
class: CommandLineTool
baseCommand: t_coffee
label: t_coffee
doc: "T-Coffee is a multiple sequence alignment program. It can be used to align protein
  and nucleic acid sequences. T-Coffee can also be used to align structural information.\n\
  \nTool homepage: https://github.com/jashkenas/coffee-script-tmbundle"
inputs:
  - id: input_file
    type: File
    doc: Input sequence file (e.g., FASTA format)
    inputBinding:
      position: 1
  - id: method
    type:
      - 'null'
      - string
    doc: Specify the alignment method to use. This can be one of the pairwise or
      multiple sequence alignment methods listed in the help text.
    inputBinding:
      position: 102
  - id: template_method
    type:
      - 'null'
      - string
    doc: Specify the method to generate templates for alignment. This can be one
      of the prediction methods listed in the help text.
    inputBinding:
      position: 102
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output alignment file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/t-coffee:13.46.2.7c9e712d--pl5321hb2a3317_0
