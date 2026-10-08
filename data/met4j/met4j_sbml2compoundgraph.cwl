cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - met4j
  - convert.Sbml2CompoundGraph
label: met4j_sbml2compoundgraph
doc: "Metabolic networks used for quantitative analysis often contain links that are irrelevant for graph-based structural analysis. For example, inclusion of side compounds or modelling artifacts such as 'biomass' nodes. While Carbon Skeleton Graph offer a relevant alternative topology for graph-based analysis, it requires compounds' structure information, usually not provided in model, and difficult to retrieve for model with sparse cross-reference annotations. In contrary to the Sbml2Graph app that performs a raw conversion of the SBML content, the present app propose a fine-tuned creation of compound graph from predefined list of side compounds and degree weighting to get relevant structure without structural data.This app also enables Markov-chain based analysis of metabolic networks by computing reaction-normalized transition probabilities on the network.\n\nTool homepage: https://forgemia.inra.fr/metexplore/met4j/-/blob/master/met4j-toolbox/README.md"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: custom_weights
    type: ['null', File]
    doc: an optional file containing weights for compound pairs
    inputBinding:
      position: 1
      prefix: -cw
  - id: degree_weights
    type: ['null', boolean]
    doc: 'penalize traversal of hubs by using degree square weighting (default: false)'
    inputBinding:
      position: 2
      prefix: -dw
  - id: format
    type: ['null', string]
    doc: 'Format of the exported graphTabulated edge list by default (source id edge type target id). Other options include GML, JsonGraph, and tabulated node list (label node id node type). (default: tab) Choices: gml, tab, nodeList, json, matrix, jsonviz'
    inputBinding:
      position: 3
      prefix: -f
  - id: input_sbml
    type: File
    doc: input SBML file
    inputBinding:
      position: 4
      prefix: -i
  - id: mergecomp
    type: ['null', string]
    doc: 'merge compartments. Use names if consistent and unambiguous across compartments, or identifiers if compartment suffix is present (id in form "xxx_y" with xxx as base identifier and y as compartment label). (default: no) Choices: no, by_name, by_id'
    inputBinding:
      position: 5
      prefix: -mc
  - id: simple
    type: ['null', boolean]
    doc: 'merge parallel edges to produce a simple graph (default: false)'
    inputBinding:
      position: 6
      prefix: -me
  - id: output
    type: string
    doc: 'output file: path to the tabulated file where the resulting network will be exported'
    inputBinding:
      position: 7
      prefix: -o
  - id: remove_isolated_nodes
    type: ['null', boolean]
    doc: 'remove isolated nodes (default: false)'
    inputBinding:
      position: 8
      prefix: -ri
  - id: side_compounds
    type: ['null', File]
    doc: input Side compound file
    inputBinding:
      position: 9
      prefix: -sc
  - id: transitionproba
    type: ['null', boolean]
    doc: 'set weight as random walk transition probability, normalized by reaction (default: false)'
    inputBinding:
      position: 10
      prefix: -tp
  - id: undirected
    type: ['null', boolean]
    doc: 'create as undirected (default: false)'
    inputBinding:
      position: 11
      prefix: -un
outputs:
  - id: output_file
    type: File
    doc: Output file written by -o
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/met4j:2.2.2--hdfd78af_0
