cwlVersion: v1.2
class: CommandLineTool
baseCommand: t-coffee_t_coffee
label: t-coffee_t_coffee
doc: "Compiling the list of available methods ... (will take a few seconds)\nMethods
  For which an Interface is available in T-Coffee\nYou must install the packages yourself
  when required (use the provided address)\nContact us if you need an extra method
  to be added [cedric.notredame@gmail.com]\n\nTool homepage: https://github.com/cbcrg/tcoffee"
inputs:
  - id: contact_email
    type:
      - 'null'
      - string
    doc: Contact email for adding extra methods.
    default: cedric.notredame@gmail.com
    inputBinding:
      position: 101
  - id: install_package
    type:
      - 'null'
      - string
    doc: Specify a package to install. Use the provided address for 
      installation.
    inputBinding:
      position: 101
  - id: method
    type:
      - 'null'
      - string
    doc: Select a specific alignment method. Available methods are listed below.
    inputBinding:
      position: 101
  - id: msa_method
    type:
      - 'null'
      - string
    doc: Select a multiple sequence alignment method. Available methods are 
      listed in the 'Multiple Sequence Alignment Methods' section.
    inputBinding:
      position: 101
  - id: pairwise_method
    type:
      - 'null'
      - string
    doc: Select a pairwise alignment method. Available methods are listed in the
      'Pairwise Sequence Alignment Methods' section.
    inputBinding:
      position: 101
  - id: prediction_method
    type:
      - 'null'
      - string
    doc: Select a prediction method for generating templates. Available methods 
      are listed in the 'Prediction Methods available to generate Templates' 
      section.
    inputBinding:
      position: 101
  - id: structural_method
    type:
      - 'null'
      - string
    doc: Select a pairwise structural alignment method. Available methods are 
      listed in the 'Pairwise Structural Alignment Methods' section.
    inputBinding:
      position: 101
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/t-coffee:13.46.2.7c9e712d--pl5321hb2a3317_0
stdout: t-coffee_t_coffee.out
