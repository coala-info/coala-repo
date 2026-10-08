cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - met4j
  - convert.Sbml2PathwayNet
label: met4j_sbml2pathwaynet
doc: "Creation of a Pathway Network representation of a SBML file content Genome-scale metabolic networks are often partitioned into metabolic pathways. Pathways are frequently considered independently despite frequent coupling in their activity due to shared metabolites. In order to decipher the interconnections linking overlapping pathways, this app proposes the creation of \"Pathway Network\", where two pathways are linked if they share compounds.\n\nTool homepage: https://forgemia.inra.fr/metexplore/met4j/-/blob/master/met4j-toolbox/README.md"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: custom_weights
    type: ['null', File]
    doc: an optional file containing weights for pathway pairs
    inputBinding:
      position: 1
      prefix: -cw
  - id: format
    type: ['null', string]
    doc: 'Format of the exported graphTabulated edge list by default (source id edge type target id). Other options include GML, JsonGraph, and tabulated node list (label node id node type). (default: tab) Choices: gml, tab, nodeList, json, matrix, jsonviz'
    inputBinding:
      position: 2
      prefix: -f
  - id: input_sbml
    type: File
    doc: input SBML file
    inputBinding:
      position: 3
      prefix: -i
  - id: connector_weights
    type: ['null', boolean]
    doc: 'set number of connecting compounds as weight (default: false)'
    inputBinding:
      position: 4
      prefix: -ncw
  - id: output
    type: string
    doc: output Graph file
    inputBinding:
      position: 5
      prefix: -o
  - id: only_sources_and_sinks
    type: ['null', boolean]
    doc: 'consider only metabolites that are source or sink in the pathway (i.e non-intermediary compounds) (default: false)'
    inputBinding:
      position: 6
      prefix: -oss
  - id: remove_isolated_nodes
    type: ['null', boolean]
    doc: 'remove isolated nodes (default: false)'
    inputBinding:
      position: 7
      prefix: -ri
  - id: side_compounds
    type: ['null', File]
    doc: input Side compound file (recommended)
    inputBinding:
      position: 8
      prefix: -sc
outputs:
  - id: output_file
    type: File
    doc: Output file written by -o
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/met4j:2.2.2--hdfd78af_0
