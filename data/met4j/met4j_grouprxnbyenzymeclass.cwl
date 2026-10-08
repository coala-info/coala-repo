cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - met4j
  - attributes.GroupRxnByEnzymeClass
label: met4j_grouprxnbyenzymeclass
doc: "Alternative functional grouping of reactions in model :Replace pathways in model by groups of reactions sharing EC numbers. EC numbers are retrieved from annotation fields, and propagated to their parent class (e.g. EC 1.2.3.4 will be added to groups 1.2.3, 1.2 and 1). Reactions without EC number are kept in the model but won't have any group assigned. Original pathway assignments are erased. EC groups with size out of the range [min-max] are ignored.\n\nTool homepage: https://forgemia.inra.fr/metexplore/met4j/-/blob/master/met4j-toolbox/README.md"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: input_sbml
    type: File
    doc: input SBML file
    inputBinding:
      position: 1
      prefix: -i
  - id: max_size
    type: ['null', int]
    doc: 'maximum size of the EC class to convert as pathway (default: 200)'
    inputBinding:
      position: 2
      prefix: -max
  - id: min_size
    type: ['null', int]
    doc: 'minimum size of the EC class to convert as pathway (default: 2)'
    inputBinding:
      position: 3
      prefix: -min
  - id: output
    type: string
    doc: output SBML file
    inputBinding:
      position: 4
      prefix: -o
outputs:
  - id: output_file
    type: File
    doc: Output file written by -o
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/met4j:2.2.2--hdfd78af_0
