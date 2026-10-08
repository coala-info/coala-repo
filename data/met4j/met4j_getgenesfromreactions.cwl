cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - met4j
  - attributes.GetGenesFromReactions
label: met4j_getgenesfromreactions
doc: "Get associated gene list from a list of reactions and a SBML file. Parse SBML GPR annotations and output a tab-separated file with one row per gene, associated reaction identifiers from input file in first column, gene identifiers in second column.\n\nTool homepage: https://forgemia.inra.fr/metexplore/met4j/-/blob/master/met4j-toolbox/README.md"
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
  - id: reaction_file
    type: File
    doc: Input Reaction file
    inputBinding:
      position: 5
      prefix: -r
  - id: separator
    type: ['null', string]
    doc: 'Separator in reaction file (default: )'
    inputBinding:
      position: 6
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
