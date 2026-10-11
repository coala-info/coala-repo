cwlVersion: v1.2
class: CommandLineTool
baseCommand: [netsyn_dataExport]
label: netsyn_dataExport
doc: "Export the NetSyn graph and results (graphML, HTML, tables).\n\nTool homepage: https://github.com/labgem/netsyn"
inputs:
  - id: input_nodes
    type: File
    doc: Nodes file from SyntenyFinder.
    inputBinding:
      position: 1
      prefix: --inputNodes
  - id: input_edges
    type: File
    doc: Edges file from SyntenyFinder.
    inputBinding:
      position: 2
      prefix: --inputEdges
  - id: input_organisms
    type: File
    doc: Organisms file from ClusteringIntoFamilies.
    inputBinding:
      position: 3
      prefix: --inputOrganisms
  - id: input_proteins
    type: File
    doc: Proteins file from ClusteringIntoFamilies.
    inputBinding:
      position: 4
      prefix: --inputProteins
  - id: output_name
    type: string
    doc: Prefix of the output files.
    inputBinding:
      position: 5
      prefix: --outputName
  - id: metadata_file
    type:
      - 'null'
      - File
    doc: Metadata file provided by the user.
    inputBinding:
      position: 6
      prefix: --metadataFile
  - id: clustering_method
    type:
      - 'null'
      - string
    doc: Clustering method (MCL, Infomap, Louvain, WalkTrap; default MCL).
    inputBinding:
      position: 7
      prefix: --ClusteringMethod
  - id: grouping_on_label
    type:
      - 'null'
      - string
    doc: Metadata column used to group nodes (incompatible with grouping_on_taxonomy).
    inputBinding:
      position: 8
      prefix: --GroupingOnLabel
  - id: grouping_on_taxonomy
    type:
      - 'null'
      - string
    doc: Taxonomic rank used to group nodes (superkingdom, phylum, class, order, family, genus, species).
    inputBinding:
      position: 9
      prefix: --GroupingOnTaxonomy
  - id: log_level
    type:
      - 'null'
      - type: enum
        symbols: [ERROR, error, WARNING, warning, INFO, info, DEBUG, debug]
        name: dataExport_log_level
    doc: Log level.
    inputBinding:
      position: 90
      prefix: --logLevel
  - id: log_file
    type:
      - 'null'
      - string
    doc: Log file (stderr by default).
    inputBinding:
      position: 91
      prefix: --logFile
outputs:
  - id: output_files
    type:
      type: array
      items: File
    doc: Exported graph and result files.
    outputBinding:
      glob: $(inputs.output_name)*
  - id: log_output
    type:
      - 'null'
      - File
    doc: Log file, when log_file is given.
    outputBinding:
      glob: |-
        ${ return inputs.log_file ? inputs.log_file : null; }
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/netsyn:1.0.0--pyh7e72e81_0
