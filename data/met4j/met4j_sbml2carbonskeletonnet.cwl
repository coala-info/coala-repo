cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - met4j
  - convert.Sbml2CarbonSkeletonNet
label: met4j_sbml2carbonskeletonnet
doc: "Metabolic networks used for quantitative analysis often contain links that are irrelevant for graph-based structural analysis. For example, inclusion of side compounds or modelling artifacts such as 'biomass' nodes. Focusing on links between compounds that share parts of their carbon skeleton allows to avoid many transitions involving side compounds, and removes entities without defined chemical structure. This app produces a Carbon Skeleton Network relevant for graph-based analysis of metabolism, in GML or matrix format, from a SBML and an GSAM atom mapping file. GSAM (see https://forgemia.inra.fr/metexplore/gsam) performs atom mapping at genome-scale level using the Reaction Decoder Tool (https://github.com/asad/ReactionDecoder) and allows to compute the number of conserved atoms of a given type between reactants.This app also enables Markov-chain based analysis of metabolic networks by computing reaction-normalized transition probabilities on the Carbon Skeleton Network.\n\nTool homepage: https://forgemia.inra.fr/metexplore/met4j/-/blob/master/met4j-toolbox/README.md"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: format
    type: ['null', string]
    doc: 'Format of the exported graphTabulated edge list by default (source id edge type target id). Other options include GML, JsonGraph, and tabulated node list (label node id node type). (default: tab) Choices: gml, tab, nodeList, json, matrix, jsonviz'
    inputBinding:
      position: 1
      prefix: -f
  - id: from_indexes
    type: ['null', boolean]
    doc: 'Use GSAM output with carbon indexes (default: false)'
    inputBinding:
      position: 2
      prefix: -fi
  - id: gsam_file
    type: File
    doc: input GSAM file
    inputBinding:
      position: 3
      prefix: -g
  - id: input_sbml
    type: File
    doc: input SBML file
    inputBinding:
      position: 4
      prefix: -i
  - id: keep_single_carbon
    type: ['null', boolean]
    doc: 'keep edges involving single-carbon compounds, such as CO2 (requires formulas in SBML) (default: false)'
    inputBinding:
      position: 5
      prefix: -ks
  - id: only_main_transition
    type: ['null', boolean]
    doc: 'Compute RPAIRS-like tags and keep only main transitions for each reaction (default: false)'
    inputBinding:
      position: 6
      prefix: -main
  - id: nocomp
    type: ['null', boolean]
    doc: 'merge compartments (requires unique compound names that are consistent across compartments) (default: false)'
    inputBinding:
      position: 7
      prefix: -mc
  - id: simple
    type: ['null', boolean]
    doc: 'merge parallel edges to produce a simple graph (default: false)'
    inputBinding:
      position: 8
      prefix: -me
  - id: output
    type: string
    doc: 'output file: path to the tabulated file where the resulting network will be exported'
    inputBinding:
      position: 9
      prefix: -o
  - id: remove_isolated_nodes
    type: ['null', boolean]
    doc: 'remove isolated nodes (default: false)'
    inputBinding:
      position: 10
      prefix: -ri
  - id: transitionproba
    type: ['null', boolean]
    doc: 'set transition probability as weight (default: false)'
    inputBinding:
      position: 11
      prefix: -tp
  - id: undirected
    type: ['null', boolean]
    doc: 'create as undirected (default: false)'
    inputBinding:
      position: 12
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
