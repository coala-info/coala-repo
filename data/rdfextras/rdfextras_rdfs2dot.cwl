cwlVersion: v1.2
class: CommandLineTool
baseCommand: rdfs2dot
label: rdfextras_rdfs2dot
doc: "Converts an RDFS graph to a DOT graph.\n\nTool homepage: https://github.com/RDFLib/rdfextras"
inputs:
  - id: input_file
    type:
      - 'null'
      - File
    doc: Input RDFS file (defaults to stdin)
    inputBinding:
      position: 1
  - id: format
    type:
      - 'null'
      - string
    doc: Input RDF format (e.g., 'turtle', 'xml', 'jsonld')
    inputBinding:
      position: 102
      prefix: --format
  - id: no_attributes
    type:
      - 'null'
      - boolean
    doc: Do not include attributes in the output DOT file
    inputBinding:
      position: 102
      prefix: --no-attributes
  - id: no_attributes_as_attributes
    type:
      - 'null'
      - boolean
    doc: Do not represent attributes as attributes
    inputBinding:
      position: 102
      prefix: --no-attributes-as-attributes
  - id: no_attributes_as_edges
    type:
      - 'null'
      - boolean
    doc: Do not represent attributes as edges
    inputBinding:
      position: 102
      prefix: --no-attributes-as-edges
  - id: no_attributes_as_links
    type:
      - 'null'
      - boolean
    doc: Do not represent attributes as links
    inputBinding:
      position: 102
      prefix: --no-attributes-as-links
  - id: no_attributes_as_nodes
    type:
      - 'null'
      - boolean
    doc: Do not represent attributes as nodes
    inputBinding:
      position: 102
      prefix: --no-attributes-as-nodes
  - id: no_attributes_as_nodes
    type:
      - 'null'
      - boolean
    doc: Do not represent attributes as nodes
    inputBinding:
      position: 102
      prefix: --no-attributes-as-nodes
  - id: no_blank_nodes
    type:
      - 'null'
      - boolean
    doc: Do not include blank nodes in the output DOT file
    inputBinding:
      position: 102
      prefix: --no-blank-nodes
  - id: no_blank_nodes_as_attributes
    type:
      - 'null'
      - boolean
    doc: Do not represent blank nodes as attributes
    inputBinding:
      position: 102
      prefix: --no-blank-nodes-as-attributes
  - id: no_blank_nodes_as_edges
    type:
      - 'null'
      - boolean
    doc: Do not represent blank nodes as edges
    inputBinding:
      position: 102
      prefix: --no-blank-nodes-as-edges
  - id: no_blank_nodes_as_links
    type:
      - 'null'
      - boolean
    doc: Do not represent blank nodes as links
    inputBinding:
      position: 102
      prefix: --no-blank-nodes-as-links
  - id: no_blank_nodes_as_nodes
    type:
      - 'null'
      - boolean
    doc: Do not represent blank nodes as nodes
    inputBinding:
      position: 102
      prefix: --no-blank-nodes-as-nodes
  - id: no_blank_nodes_as_nodes
    type:
      - 'null'
      - boolean
    doc: Do not represent blank nodes as nodes
    inputBinding:
      position: 102
      prefix: --no-blank-nodes-as-nodes
  - id: no_classes
    type:
      - 'null'
      - boolean
    doc: Do not include classes in the output DOT file
    inputBinding:
      position: 102
      prefix: --no-classes
  - id: no_classes_as_attributes
    type:
      - 'null'
      - boolean
    doc: Do not represent classes as attributes
    inputBinding:
      position: 102
      prefix: --no-classes-as-attributes
  - id: no_classes_as_edges
    type:
      - 'null'
      - boolean
    doc: Do not represent classes as edges
    inputBinding:
      position: 102
      prefix: --no-classes-as-edges
  - id: no_classes_as_links
    type:
      - 'null'
      - boolean
    doc: Do not represent classes as links
    inputBinding:
      position: 102
      prefix: --no-classes-as-links
  - id: no_classes_as_nodes
    type:
      - 'null'
      - boolean
    doc: Do not represent classes as nodes
    inputBinding:
      position: 102
      prefix: --no-classes-as-nodes
  - id: no_classes_as_nodes
    type:
      - 'null'
      - boolean
    doc: Do not represent classes as nodes
    inputBinding:
      position: 102
      prefix: --no-classes-as-nodes
  - id: no_comments
    type:
      - 'null'
      - boolean
    doc: Do not include comments in the output DOT file
    inputBinding:
      position: 102
      prefix: --no-comments
  - id: no_comments_as_attributes
    type:
      - 'null'
      - boolean
    doc: Do not represent comments as attributes
    inputBinding:
      position: 102
      prefix: --no-comments-as-attributes
  - id: no_comments_as_edges
    type:
      - 'null'
      - boolean
    doc: Do not represent comments as edges
    inputBinding:
      position: 102
      prefix: --no-comments-as-edges
  - id: no_comments_as_links
    type:
      - 'null'
      - boolean
    doc: Do not represent comments as links
    inputBinding:
      position: 102
      prefix: --no-comments-as-links
  - id: no_comments_as_nodes
    type:
      - 'null'
      - boolean
    doc: Do not represent comments as nodes
    inputBinding:
      position: 102
      prefix: --no-comments-as-nodes
  - id: no_comments_as_nodes
    type:
      - 'null'
      - boolean
    doc: Do not represent comments as nodes
    inputBinding:
      position: 102
      prefix: --no-comments-as-nodes
  - id: no_edges
    type:
      - 'null'
      - boolean
    doc: Do not include edges in the output DOT file
    inputBinding:
      position: 102
      prefix: --no-edges
  - id: no_edges_as_attributes
    type:
      - 'null'
      - boolean
    doc: Do not represent edges as attributes
    inputBinding:
      position: 102
      prefix: --no-edges-as-attributes
  - id: no_edges_as_edges
    type:
      - 'null'
      - boolean
    doc: Do not represent edges as edges
    inputBinding:
      position: 102
      prefix: --no-edges-as-edges
  - id: no_edges_as_links
    type:
      - 'null'
      - boolean
    doc: Do not represent edges as links
    inputBinding:
      position: 102
      prefix: --no-edges-as-links
  - id: no_edges_as_nodes
    type:
      - 'null'
      - boolean
    doc: Do not represent edges as nodes
    inputBinding:
      position: 102
      prefix: --no-edges-as-nodes
  - id: no_edges_as_nodes
    type:
      - 'null'
      - boolean
    doc: Do not represent edges as nodes
    inputBinding:
      position: 102
      prefix: --no-edges-as-nodes
  - id: no_labels
    type:
      - 'null'
      - boolean
    doc: Do not include labels in the output DOT file
    inputBinding:
      position: 102
      prefix: --no-labels
  - id: no_links
    type:
      - 'null'
      - boolean
    doc: Do not include links in the output DOT file
    inputBinding:
      position: 102
      prefix: --no-links
  - id: no_links_as_attributes
    type:
      - 'null'
      - boolean
    doc: Do not represent links as attributes
    inputBinding:
      position: 102
      prefix: --no-links-as-attributes
  - id: no_links_as_edges
    type:
      - 'null'
      - boolean
    doc: Do not represent links as edges
    inputBinding:
      position: 102
      prefix: --no-links-as-edges
  - id: no_links_as_links
    type:
      - 'null'
      - boolean
    doc: Do not represent links as links
    inputBinding:
      position: 102
      prefix: --no-links-as-links
  - id: no_links_as_nodes
    type:
      - 'null'
      - boolean
    doc: Do not represent links as nodes
    inputBinding:
      position: 102
      prefix: --no-links-as-nodes
  - id: no_links_as_nodes
    type:
      - 'null'
      - boolean
    doc: Do not represent links as nodes
    inputBinding:
      position: 102
      prefix: --no-links-as-nodes
  - id: no_literals
    type:
      - 'null'
      - boolean
    doc: Do not include literals in the output DOT file
    inputBinding:
      position: 102
      prefix: --no-literals
  - id: no_literals_as_attributes
    type:
      - 'null'
      - boolean
    doc: Do not represent literals as attributes
    inputBinding:
      position: 102
      prefix: --no-literals-as-attributes
  - id: no_literals_as_edges
    type:
      - 'null'
      - boolean
    doc: Do not represent literals as edges
    inputBinding:
      position: 102
      prefix: --no-literals-as-edges
  - id: no_literals_as_links
    type:
      - 'null'
      - boolean
    doc: Do not represent literals as links
    inputBinding:
      position: 102
      prefix: --no-literals-as-links
  - id: no_literals_as_nodes
    type:
      - 'null'
      - boolean
    doc: Do not represent literals as nodes
    inputBinding:
      position: 102
      prefix: --no-literals-as-nodes
  - id: no_literals_as_nodes
    type:
      - 'null'
      - boolean
    doc: Do not represent literals as nodes
    inputBinding:
      position: 102
      prefix: --no-literals-as-nodes
  - id: no_namespace_prefixes
    type:
      - 'null'
      - boolean
    doc: Do not use namespace prefixes in the output DOT file
    inputBinding:
      position: 102
      prefix: --no-namespace-prefixes
  - id: no_nodes
    type:
      - 'null'
      - boolean
    doc: Do not include nodes in the output DOT file
    inputBinding:
      position: 102
      prefix: --no-nodes
  - id: no_nodes_as_attributes
    type:
      - 'null'
      - boolean
    doc: Do not represent nodes as attributes
    inputBinding:
      position: 102
      prefix: --no-nodes-as-attributes
  - id: no_nodes_as_edges
    type:
      - 'null'
      - boolean
    doc: Do not represent nodes as edges
    inputBinding:
      position: 102
      prefix: --no-nodes-as-edges
  - id: no_nodes_as_links
    type:
      - 'null'
      - boolean
    doc: Do not represent nodes as links
    inputBinding:
      position: 102
      prefix: --no-nodes-as-links
  - id: no_nodes_as_nodes
    type:
      - 'null'
      - boolean
    doc: Do not represent nodes as nodes
    inputBinding:
      position: 102
      prefix: --no-nodes-as-nodes
  - id: no_nodes_as_nodes
    type:
      - 'null'
      - boolean
    doc: Do not represent nodes as nodes
    inputBinding:
      position: 102
      prefix: --no-nodes-as-nodes
  - id: no_properties
    type:
      - 'null'
      - boolean
    doc: Do not include properties in the output DOT file
    inputBinding:
      position: 102
      prefix: --no-properties
  - id: no_properties_as_attributes
    type:
      - 'null'
      - boolean
    doc: Do not represent properties as attributes
    inputBinding:
      position: 102
      prefix: --no-properties-as-attributes
  - id: no_properties_as_edges
    type:
      - 'null'
      - boolean
    doc: Do not represent properties as edges
    inputBinding:
      position: 102
      prefix: --no-properties-as-edges
  - id: no_properties_as_edges
    type:
      - 'null'
      - boolean
    doc: Do not represent properties as edges
    inputBinding:
      position: 102
      prefix: --no-properties-as-edges
  - id: no_properties_as_links
    type:
      - 'null'
      - boolean
    doc: Do not represent properties as links
    inputBinding:
      position: 102
      prefix: --no-properties-as-links
  - id: no_properties_as_nodes
    type:
      - 'null'
      - boolean
    doc: Do not represent properties as nodes
    inputBinding:
      position: 102
      prefix: --no-properties-as-nodes
  - id: no_types
    type:
      - 'null'
      - boolean
    doc: Do not include types in the output DOT file
    inputBinding:
      position: 102
      prefix: --no-types
  - id: no_types_as_attributes
    type:
      - 'null'
      - boolean
    doc: Do not represent types as attributes
    inputBinding:
      position: 102
      prefix: --no-types-as-attributes
  - id: no_types_as_edges
    type:
      - 'null'
      - boolean
    doc: Do not represent types as edges
    inputBinding:
      position: 102
      prefix: --no-types-as-edges
  - id: no_types_as_links
    type:
      - 'null'
      - boolean
    doc: Do not represent types as links
    inputBinding:
      position: 102
      prefix: --no-types-as-links
  - id: no_types_as_nodes
    type:
      - 'null'
      - boolean
    doc: Do not represent types as nodes
    inputBinding:
      position: 102
      prefix: --no-types-as-nodes
  - id: no_types_as_nodes
    type:
      - 'null'
      - boolean
    doc: Do not represent types as nodes
    inputBinding:
      position: 102
      prefix: --no-types-as-nodes
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output DOT file (defaults to stdout)
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rdfextras:0.4--py27_2
