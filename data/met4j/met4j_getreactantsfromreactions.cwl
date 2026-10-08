cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - met4j
  - attributes.GetReactantsFromReactions
label: met4j_getreactantsfromreactions
doc: "Get reactant lists from a list of reactions and a Sbml file. Output a tab-separated file with one row per reactant, reaction identifiers in first column, reactant identifiers in second column. It can provides substrates, products, or both (by default). In the case of reversible reactions, all reactants are considered as both substrates and products\n\nTool homepage: https://forgemia.inra.fr/metexplore/met4j/-/blob/master/met4j-toolbox/README.md"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: column
    type: ['null', int]
    doc: 'Column number in reaction file (first as 1) (default: 1)'
    inputBinding:
      position: 1
      prefix: -col
  - id: header
    type: ['null', boolean]
    doc: 'Skip reaction file header (default: false)'
    inputBinding:
      position: 2
      prefix: -header
  - id: input_sbml
    type: File
    doc: Input SBML file
    inputBinding:
      position: 3
      prefix: -i
  - id: output
    type: string
    doc: Output file
    inputBinding:
      position: 4
      prefix: -o
  - id: products
    type: ['null', boolean]
    doc: 'Extract products only (default: false)'
    inputBinding:
      position: 5
      prefix: -p
  - id: reaction_file
    type: File
    doc: Input Reaction file
    inputBinding:
      position: 6
      prefix: -r
  - id: substrates
    type: ['null', boolean]
    doc: 'Extract substrates only (default: false)'
    inputBinding:
      position: 7
      prefix: -s
  - id: separator
    type: ['null', string]
    doc: 'Separator in reaction file (default: )'
    inputBinding:
      position: 8
      prefix: -sep
outputs:
  - id: output_file
    type: File
    doc: Output file written by -o
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/met4j:2.2.2--hdfd78af_0
