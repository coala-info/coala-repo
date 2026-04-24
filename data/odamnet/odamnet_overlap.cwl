cwlVersion: v1.2
class: CommandLineTool
baseCommand: odamnet_overlap
label: odamnet_overlap
doc: "Perform Overlap analysis between genes targeted by chemicals and rare diseases
  pathways.\n\nTool homepage: https://pypi.org/project/ODAMNet/1.1.0/"
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
  - id: output_path
    type:
      - 'null'
      - Directory
    doc: Output folder name to save results
    inputBinding:
      position: 101
      prefix: --outputPath
  - id: pathways_of_interest_gmt
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
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/odamnet:1.1.0--pyhdfd78af_0
stdout: odamnet_overlap.out
