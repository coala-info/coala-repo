cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - met4j
  - attributes.GetEntities
label: met4j_getentities
doc: "Parse a SBML file to return a list of entities composing the network: metabolites, reactions, genes and others.The output file is a tabulated file with two columns, one with entity identifiers, and one with the entity type. If no entity type is selected, all of them are returned by default. Only identifiers are written, attributes can be extracted from dedicated apps or from the Sbml2Tab app.\n\nTool homepage: https://forgemia.inra.fr/metexplore/met4j/-/blob/master/met4j-toolbox/README.md"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: compartments
    type: ['null', boolean]
    doc: 'Extract Compartments (default: false)'
    inputBinding:
      position: 1
      prefix: -c
  - id: genes
    type: ['null', boolean]
    doc: 'Extract Genes (default: false)'
    inputBinding:
      position: 2
      prefix: -g
  - id: input_sbml
    type: File
    doc: Input SBML file
    inputBinding:
      position: 3
      prefix: -i
  - id: metabolites
    type: ['null', boolean]
    doc: 'Extract Metabolites (default: false)'
    inputBinding:
      position: 4
      prefix: -m
  - id: no_type_col
    type: ['null', boolean]
    doc: 'Do not write type column (default: false)'
    inputBinding:
      position: 5
      prefix: -nt
  - id: output
    type: string
    doc: Output file
    inputBinding:
      position: 6
      prefix: -o
  - id: pathways
    type: ['null', boolean]
    doc: 'Extract Pathways (default: false)'
    inputBinding:
      position: 7
      prefix: -p
  - id: reactions
    type: ['null', boolean]
    doc: 'Extract Reactions (default: false)'
    inputBinding:
      position: 8
      prefix: -r
outputs:
  - id: output_file
    type: File
    doc: Output file written by -o
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/met4j:2.2.2--hdfd78af_0
