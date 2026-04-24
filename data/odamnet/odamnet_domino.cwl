cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - odamnet
  - domino
label: odamnet_domino
doc: "Perform Active module identification analysis between genes targeted by\n  chemicals
  and rare diseases pathways using DOMINO.\n\n  1. DOMINO on network using target
  genes as seed 2. Overlap analysis between\n  identified active modules and rare
  disease pahtways\n\nTool homepage: https://pypi.org/project/ODAMNet/1.1.0/"
inputs:
  - id: background_file
    type:
      - 'null'
      - File
    doc: "Background genes file name NOTE: This\n                                \
      \  argument is required if pathOfInterestGMT\n                             \
      \     chosen."
    inputBinding:
      position: 101
      prefix: --backgroundFile
  - id: chemicals_file
    type:
      - 'null'
      - File
    doc: Chemicals file name
    inputBinding:
      position: 101
      prefix: --chemicalsFile
  - id: ctd_file
    type:
      - 'null'
      - File
    doc: CTD file name
    inputBinding:
      position: 101
      prefix: --CTD_file
  - id: direct_association
    type:
      - 'null'
      - boolean
    doc: "True: Extract target genes from chemicals\n                            \
      \      False: Extract target genes from chemicals +\n                      \
      \            its child chemicals"
    inputBinding:
      position: 101
      prefix: --directAssociation
  - id: nb_pub
    type:
      - 'null'
      - int
    doc: "Minimum number of publications to keep an\n                            \
      \      interaction"
    inputBinding:
      position: 101
      prefix: --nbPub
  - id: net_uuid
    type:
      - 'null'
      - string
    doc: NDEx network ID
    inputBinding:
      position: 101
      prefix: --netUUID
  - id: network_file
    type: File
    doc: Network file name
    inputBinding:
      position: 101
      prefix: --networkFile
  - id: pathways_gmt_file
    type:
      - 'null'
      - File
    doc: "Pathways of interest file name (GMT file)\n                            \
      \      NOTE: This argument is required if\n                                \
      \  backgroundFile chosen."
    inputBinding:
      position: 101
      prefix: --GMT
  - id: target_genes_file
    type:
      - 'null'
      - File
    doc: Target genes file name
    inputBinding:
      position: 101
      prefix: --targetGenesFile
outputs:
  - id: output_path
    type:
      - 'null'
      - Directory
    doc: Output folder name to save results
    outputBinding:
      glob: $(inputs.output_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/odamnet:1.1.0--pyhdfd78af_0
