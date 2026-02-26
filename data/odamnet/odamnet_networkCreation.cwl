cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - odamnet
  - networkCreation
label: odamnet_networkCreation
doc: "Creates network (GR format) from WikiPathways request or pathways of interest
  given in GMT file.\n\nTool homepage: https://pypi.org/project/ODAMNet/1.1.0/"
inputs:
  - id: bipartite_name
    type:
      - 'null'
      - string
    doc: Bipartite output name
    default: Bipartite_WP_RareDiseases_geneSymbols.gr
    inputBinding:
      position: 101
      prefix: --bipartiteName
  - id: bipartite_path
    type: Directory
    doc: Output path to save the bipartite
    inputBinding:
      position: 101
      prefix: --bipartitePath
  - id: gmt_file
    type:
      - 'null'
      - File
    doc: Pathways of interest in GMT like format (e.g. from WP request).
    inputBinding:
      position: 101
      prefix: --GMT
  - id: networks_name
    type:
      - 'null'
      - string
    doc: Network output name
    default: WP_RareDiseasesNetwork.gr
    inputBinding:
      position: 101
      prefix: --networksName
  - id: networks_path
    type: Directory
    doc: Output path to save the network
    inputBinding:
      position: 101
      prefix: --networksPath
  - id: output_path
    type:
      - 'null'
      - Directory
    doc: Output path name (for complementary output files)
    default: OutputResults
    inputBinding:
      position: 101
      prefix: --outputPath
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/odamnet:1.1.0--pyhdfd78af_0
stdout: odamnet_networkCreation.out
