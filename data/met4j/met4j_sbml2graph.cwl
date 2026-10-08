cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - met4j
  - convert.Sbml2Graph
label: met4j_sbml2graph
doc: "Create a graph representation of a SBML file content, and export it in graph file format. The graph can be either a compound graph, a reaction graph or a bipartite graph, and can be exported in gml or tabulated file format.\n\nTool homepage: https://forgemia.inra.fr/metexplore/met4j/-/blob/master/met4j-toolbox/README.md"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: bipartite
    type: ['null', boolean]
    doc: 'create bipartite graph (default: false)'
    inputBinding:
      position: 1
      prefix: -b
  - id: compound
    type: ['null', boolean]
    doc: 'create compound graph (default: true)'
    inputBinding:
      position: 2
      prefix: -c
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
  - id: output
    type: string
    doc: 'output file: path to the tabulated file where the resulting network will be exported'
    inputBinding:
      position: 5
      prefix: -o
  - id: reaction
    type: ['null', boolean]
    doc: 'create reaction graph (default: false)'
    inputBinding:
      position: 6
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
